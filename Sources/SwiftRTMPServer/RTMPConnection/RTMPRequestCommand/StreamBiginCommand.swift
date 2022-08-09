import Foundation

struct StreamBiginCommand: RTMPServerRequestConvertible {
    
    var format: FormatType = .three
    
    var chankStreamId: UInt16 = 2
    
    var messageTypeId: RTMPMessageType = .amf0command
    
    var messageStreamId: UInt32? = 2
    
    var body: Data = {
        return Data()
    }()
    
    
}
