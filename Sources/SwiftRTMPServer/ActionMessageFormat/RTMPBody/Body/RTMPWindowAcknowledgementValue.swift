import Foundation

struct RTMPWindowAcknowledgementValue: RTMPDataCreateConvertible {
    
    let windowAcknowledgementSize: UInt32
    
    static func create(data: inout Data) -> RTMPWindowAcknowledgementValue {
        
        let windowAcknowledgementSizeByte = data.removeByteFromFirst(to: 4).bytes
        let windowAcknowledgementSizeData = Data(
            bytes: windowAcknowledgementSizeByte,
            count: windowAcknowledgementSizeByte.count
        )
        let windowAcknowledgementSize = windowAcknowledgementSizeData.uint32
        
        return RTMPWindowAcknowledgementValue(
            windowAcknowledgementSize: windowAcknowledgementSize
        )
    }
    
    func toData() -> Data {
        return windowAcknowledgementSize.data
    }
}
