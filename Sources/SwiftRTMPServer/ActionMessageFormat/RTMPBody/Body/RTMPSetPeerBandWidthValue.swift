import Foundation

struct RTMPSetPeerBandWidthValue: RTMPDataCreateConvertible {
    
    enum LimitType: UInt8 {
        case hard = 0
        case soft = 1
        case dynamic = 2
    }
    
    let bandWidth: UInt32
    let limitType: LimitType
    
    static func create(data: inout Data) -> RTMPSetPeerBandWidthValue {
        
        let bandWidthByte = data.removeByteFromFirst(to: 4).bytes
        let bandWidthData = Data(
            bytes: bandWidthByte,
            count: bandWidthByte.count
        )
        let bandWidth = bandWidthData.uint32
        
        let limitTypeByte = data.removeByteFromFirst(to: 1).bytes
        let limitTypeData = Data(
            bytes: limitTypeByte,
            count:limitTypeByte.count
        )
        
        guard let limitType = LimitType(rawValue: limitTypeData.uint8) else {
            fatalError("can not create limittype")
        }
        
        return RTMPSetPeerBandWidthValue(
            bandWidth: bandWidth,
            limitType: limitType
        )
    }
    
    func toData() -> Data {
        var data = Data()
        data.append(bandWidth.data)
        data.append(limitType.rawValue.data)
        return data
    }
}
