import Foundation
import SwiftyBit
import NIO

class RTMPDataStreamHandler {
    
    func handle(_ data: inout Data, context: ChannelHandlerContext) {
        
        data.outputHex()
        print("===========")
    }
}
