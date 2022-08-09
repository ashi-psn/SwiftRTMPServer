import SwiftyBit
import Foundation

struct RTMPNumberValue: RTMPAMF0ObjectConvertible {
    
    static var amf0Marker: AMF0Marker = .number
    
    var value: Double
    
    private static let numberValueByteSize = 8
    
    static func create(data: inout Data) -> RTMPNumberValue {
        
        guard isEqualMarkar(data: data) else {
            fatalError("markar is not number")
        }
        
        //markar部分削除
        data.removeByteFromFirst(to: 1)
        var numValueData = data.removeByteFromFirst(to: numberValueByteSize)
        
        //ビッグエンディアンをリトルエンディアンにする
        numValueData.reverse()
        let numValueUInt64 = numValueData.withUnsafeBytes { $0.load(as: Double.self)}
        
        let numValue = Double(numValueUInt64)
        
        return RTMPNumberValue(
            value: numValue
        )
    }
    
    func toData() -> Data {
        
        var copyValue = value.bitPattern.bigEndian
//        var copyValue = value
        let valueData = Data(
            bytes: &copyValue,
            count: MemoryLayout<UInt64>.size
        )
        var data = Data()
        data.append(markerData)
        data.append(valueData)
        return data
    }
}
