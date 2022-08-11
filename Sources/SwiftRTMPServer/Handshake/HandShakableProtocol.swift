import Foundation
import NIO

protocol HandShakableRecevable {
    
    var connectionState: RTMPServer.ConnectionState { get }
    
    func onReceiveC0(data: Data, context: ChannelHandlerContext)

    func onReceiveC0(version: UInt8, context: ChannelHandlerContext)
    
    func onReceiveC0C1(data: Data, context: ChannelHandlerContext)
    
    func onReceiveC1(data: Data, context: ChannelHandlerContext)
    
    func onReceiveC1(c1: C1, context: ChannelHandlerContext)
    
    func onReceiveC2(data: Data, context: ChannelHandlerContext)
    
}

protocol HandShakableSendable {
    
    func sendS0(context: ChannelHandlerContext)
    
    func sendS1(context: ChannelHandlerContext)
    
    func sendS0S1S2(data: Data, context: ChannelHandlerContext)
    
    func sendS2(chank: C1, context: ChannelHandlerContext)
    
    func sendMessage<T>(request: T, context: ChannelHandlerContext) where T: RTMPAMF0ObjectConvertible
    func sendMessage(request: Data, context: ChannelHandlerContext)
}
