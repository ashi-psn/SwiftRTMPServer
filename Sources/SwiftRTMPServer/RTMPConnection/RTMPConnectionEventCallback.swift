import Foundation
import NIO

protocol RTMPConnectionEventCallback {
    
    func onReceiveWindowAcknowledgement(context: ChannelHandlerContext)
    
    func onReceiveCommand(context: ChannelHandlerContext, stream: RTMPStream)
    
    func onReceiveAbort(context: ChannelHandlerContext)
    
    func onReceiveAcknowledgemtn(context: ChannelHandlerContext)
    
    func onReceiveSetPeerBandWidth(context: ChannelHandlerContext)
    
    func onReceiveAbord(context: ChannelHandlerContext)
    
    func onReceiveSetChank(context: ChannelHandlerContext)
    
    func onReceiveCreateStream(context: ChannelHandlerContext)
    
    func onReceiveFCPublish(context: ChannelHandlerContext)
    
    func onReceiveReleaseStream(context: ChannelHandlerContext)
    
    func onReceivePublish(context: ChannelHandlerContext)
    
    func onReceiveVideoData(context: ChannelHandlerContext)
    
}
