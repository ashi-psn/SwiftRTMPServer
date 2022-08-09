import Foundation

struct SetPeerBandWidthCommand: RTMPServerRequestConvertible {
    var format: FormatType = .zero
    
    var chankStreamId: UInt16 = 2
    
    var messageTypeId: RTMPMessageType = .setPeerBandWidth
    
    var messageStreamId: UInt32? = 0
    
    var body: Data = {
        var data = Data()
        
        let windowAcknowledgementSize: UInt32 = 5000000
        let limitType: UInt8 = 0x02
        
        data.append(windowAcknowledgementSize.data)
        data.append(limitType.data)
        return data
    }()
}
