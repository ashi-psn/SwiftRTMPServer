import Foundation
import SwiftyBit
import NIO

protocol RTMPConnectionHandleDelegate {
    func sendData(data: Data, context: ChannelHandlerContext)
    func changeConnectionState(state: RTMPServer.ConnectionState)
}

class RTMPConnectionHandler {
    
    var delegate: RTMPConnectionHandleDelegate?
    
    func handle(_ data: inout Data, context: ChannelHandlerContext) {
        
        RTMPConnectionResponseCreater.create(data: &data) { stream in
            
            switch stream.header.basicHeader.fmt {
            case .zero, .one, .two:
                if let messageType = stream.header.messageHeader.messageType {
                    
                    switch messageType {
                    case .setChankSize:
                        onReceiveSetChank(context: context)
                        
                    case .windowAcknowledgement:
                        onReceiveWindowAcknowledgement(context: context)
                        
                    case .setPeerBandWidth:
                        onReceiveSetPeerBandWidth(context: context)
                        
                    case .amf0command:
                        onReceiveCommand(context: context, stream: stream)
                        
                    case .amf0data:
                        onReceiveCommand(context: context, stream: stream)
                        
                    case .abort:
                        onReceiveAbort(context: context)
                        
                    case .acknowledgemtn:
                        onReceiveAcknowledgemtn(context: context)
                    case .videoData:
                        onReceiveVideoData(context: context)
                    }
                } else {
                    onReceiveCommand(context: context, stream: stream)
                }
                
            case .three:
                onReceiveCommand(context: context, stream: stream)
            }
        }
    }
}

extension RTMPConnectionHandler: RTMPConnectionEventCallback {
    
    func onReceiveCommand(context: ChannelHandlerContext, stream: RTMPStream) {
        
        let commandName = (stream.body.body.first! as? RTMPStringValue)?.value
        print(commandName as Any)
        switch commandName {
            
        case "connect":
            var data = Data()
            
            let windowAcknowledgementData = WindowAcknowledgementSizeCommand()
                .toData()
            data.append(windowAcknowledgementData)
            
            let setPeerData = SetPeerBandWidthCommand().toData()
            data.append(setPeerData)
            
            let setStreamData = SetChankSizeCommand().toData()
            data.append(setStreamData)
                
            delegate?.sendData(data: data, context: context)
            
        case "createStream":
            let createStreamCommand = CreateStreamResultCommand()
            delegate?.sendData(data: createStreamCommand.toData(), context: context)
            
        case "publish":
            delegate?.changeConnectionState(state: .connectionEstablish)
            let command = OnStatusCommand().toData()
            delegate?.sendData(data: command, context: context)
            
        case .some(let value):
            print(value)
            
        case .none:
            print()
        }
    }
    
    func onReceiveAbort(context: ChannelHandlerContext) {
        print()
    }
    
    func onReceiveAcknowledgemtn(context: ChannelHandlerContext) {
        print()
    }
    
    func onReceiveWindowAcknowledgement(context: ChannelHandlerContext) {
        print()
    }

    func onReceiveSetPeerBandWidth(context: ChannelHandlerContext) {
        print()
    }
    
    func onReceiveAbord(context: ChannelHandlerContext) {
        print()
    }
    
    func onReceiveSetChank(context: ChannelHandlerContext) {
        let createStreamCommand = ConnectResultCommand()
        delegate?.sendData(data: createStreamCommand.toData(), context: context)
    }
    
    func onReceiveCreateStream(context: ChannelHandlerContext) {
        let command = CreateStreamResultCommand()
        delegate?.sendData(data: command.toData(), context: context)
    }
    
    func onReceiveFCPublish(context: ChannelHandlerContext) {
        print()
    }
    
    func onReceiveReleaseStream(context: ChannelHandlerContext) {
        print()
    }
    
    func onReceivePublish(context: ChannelHandlerContext) {
        delegate?.changeConnectionState(state: .connectionEstablish)
        let command = OnStatusCommand()
        delegate?.sendData(data: command.toData(), context: context)
    }
    
    func onReceiveVideoData(context: ChannelHandlerContext) {
        
    }
}
