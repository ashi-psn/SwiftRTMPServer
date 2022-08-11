import Foundation
import NIO
import SwiftyBit

final class RTMPChannelHandler: ChannelInboundHandler {
    
    var connectionState: RTMPServer.ConnectionState = .unconnected
    
    var c1: C1?
    
    public typealias InboundIn = ByteBuffer
    public typealias OutboundOut = ByteBuffer
    
    let connectionHandler = RTMPConnectionHandler()
    let streamHandler = RTMPDataStreamHandler()
    
    init() {
        connectionHandler.delegate = self
    }

    public func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        
        var data = self.unwrapInboundIn(data)
        
        guard let inputBytes = data.readBytes(length: data.readableBytes) else {
            return
        }
        
        let responseData = Data(bytes: inputBytes, count: inputBytes.count)
        self.listen(data: responseData, context: context)
        
    }
    
    public func channelReadComplete(context: ChannelHandlerContext) {
        context.flush()
    }
    
    public func errorCaught(context: ChannelHandlerContext, error: Error) {
        print("error: ", error)
        context.close(promise: nil)
    }
    
    func listen(data: Data, context: ChannelHandlerContext) {
        
        var data = data
        
        //byte数がC0 + C1で1537byteで来た場合
        if (self.connectionState == .unconnected && data.count == 1537) {
            self.connectionState = .sendS2
            onReceiveC0C1(data: data, context: context)
            return
        }


        switch self.connectionState {
        case.unconnected:
            self.onReceiveC0(data: data, context: context)
            self.connectionState = .sendS0

        case .sendS0:
            self.onReceiveC1(data: data, context: context)
            self.connectionState = .sendS1

        case .sendS1:
            if data.count > 1536 {
                let c2Data = data.prefix(1536)
                var otherData = data.bytes
                otherData.removeSubrange(1536...otherData.count - 1)
                self.onReceiveC2(data: c2Data, context: context)
            } else {
                self.onReceiveC2(data: data, context: context)
            }

            self.connectionState = .sendS2

        case .sendS2:
            //C2とconnectが同時に来る場合がある
            if data.count > 1536 {
                //C2とそれ以外に分割する
                var mutableData = data
                let c2Byte = mutableData.removeByteFromFirst(to: 1536)
                self.onReceiveC2(data: c2Byte, context: context)
                
                self.connectionState = .connected
                
                //C2以外のデータを処理するため再帰させる
                self.listen(data: mutableData, context: context)
                
            } else {
                guard data.count == 1536 else {
                    fatalError("invalid C2 format")
                }
                self.onReceiveC2(data: data, context: context)
                self.connectionState = .connected
            }
            
        case .connected:
            connectionHandler.handle(&data, context: context)
            
        case .connectionEstablish:
            streamHandler.handle(&data, context: context)
        }
    }
}

extension RTMPChannelHandler: HandShakableRecevable {
    
    func onReceiveC0(data: Data, context: ChannelHandlerContext) {
        sendS0(context: context)
    }
    
    func onReceiveC0(version: UInt8, context: ChannelHandlerContext) {
        sendS0(context: context)
    }
    
    func onReceiveC0C1(data: Data, context: ChannelHandlerContext) {
        guard let version = data.first else {
            fatalError("version format is invalid")
        }
        
        guard version == 3 else {
            fatalError("invalid version \(version). Only support version 3")
        }
        
        self.sendS0S1S2(data: data, context: context)
    }
    
    func onReceiveC1(data: Data, context: ChannelHandlerContext) {
        let c1 = C1(data: data)
        self.onReceiveC1(c1: c1, context: context)
    }
    
    func onReceiveC1(c1: C1, context: ChannelHandlerContext) {
        sendS2(chank: c1, context: context)
    }
    
    func onReceiveC2(data: Data, context: ChannelHandlerContext) {
        
    }
}

extension RTMPChannelHandler: HandShakableSendable {
    func sendS0(context: ChannelHandlerContext) {
        let s0 = S0()
        sendMessage(request: s0, context: context)
    }
    
    func sendS1(context: ChannelHandlerContext) {
        let s1 = S1()
        sendMessage(request: s1, context: context)
    }
    
    func sendS0S1S2(data: Data, context: ChannelHandlerContext) {
        let c1 = C1(data: data.dropFirst())
        let s0 = S0()
        let s1 = S1()
        let s2 = S2(from: c1)
        
        var sendingData = Data()
        sendingData.append(s0.toData())
        sendingData.append(s1.toData())
        sendingData.append(s2.toData())
        sendMessage(request: sendingData, context: context)
    }
    
    func sendS2(chank: C1, context: ChannelHandlerContext) {
        let s2 = S2(from: chank)
        sendMessage(request: s2, context: context)
    }
    
    func sendMessage<T>(request: T, context: ChannelHandlerContext) where T : DataConvertible {
        sendMessage(request: request.toData(), context: context)
    }
    
    func sendMessage(request: Data, context: ChannelHandlerContext) {
        let writeBuffer = ByteBuffer(bytes: request)
        context.writeAndFlush(wrapOutboundOut(writeBuffer), promise: nil)
    }
}

extension RTMPChannelHandler: RTMPConnectionHandleDelegate {
    
    func changeConnectionState(state: RTMPServer.ConnectionState) {
        self.connectionState = state
    }
    
    
    func sendData(data: Data, context: ChannelHandlerContext) {
        let writeBuffer = ByteBuffer(bytes: data)
        context.writeAndFlush(wrapOutboundOut(writeBuffer), promise: nil)
    }
}
