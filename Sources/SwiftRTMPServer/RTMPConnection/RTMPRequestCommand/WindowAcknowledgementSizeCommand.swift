import Foundation

struct WindowAcknowledgementSizeCommand: RTMPServerRequestConvertible {
    
    let format: FormatType = .zero
    
    var chankStreamId: UInt16 = 2
    
    var messageTypeId: RTMPMessageType = .windowAcknowledgement
    
    var messageStreamId: UInt32? = 0
    
    var body: Data = {
        UInt32(5000000).data
    }()
}
