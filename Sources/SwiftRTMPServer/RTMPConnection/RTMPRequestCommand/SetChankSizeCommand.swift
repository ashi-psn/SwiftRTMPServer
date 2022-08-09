import Foundation

struct SetChankSizeCommand: RTMPServerRequestConvertible {
    
    var format: FormatType = .zero
    
    var chankStreamId: UInt16 = 2
    
    var messageTypeId: RTMPMessageType = .setChankSize
    
    var messageStreamId: UInt32? = 0
    
    var body: Data = {
        var data = Data()
        let chankSize: UInt32 = 4096
        data.append(chankSize.data)
        return data
    }()
}
