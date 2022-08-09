import Foundation

struct RTMPHeader: RTMPDataCreateConvertible {
    
    var basicHeaderType: ChankBasicHeaderType
    var basicHeader: ChankBasicHeader
    var messageHeader: ChankMessageHeader
    var extendedTimestamp: ExtendedTimestampHeader?
    
    static func create(data: inout Data) -> RTMPHeader {
        
        let basicHeader = ChankBasicHeader.create(data: &data)
        let basicHeaderType = basicHeader.basicHeaderType
        let fmtType = basicHeader.fmt
        let messageHeader = ChankMessageHeader.create(data: &data, formatType: fmtType)
        
        return RTMPHeader(
            basicHeaderType: basicHeaderType,
            basicHeader: basicHeader,
            messageHeader: messageHeader
        )
    }
    
    func toData() -> Data {
        
        var data = Data()
        
        data.append(basicHeader.toData())
        data.append(messageHeader.toData())
        
        if let extendedTimestamp = extendedTimestamp {
            data.append(extendedTimestamp.toData())
        }
        
        return data
    }
}
