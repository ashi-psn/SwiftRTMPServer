import SwiftyBit
import Foundation

struct RTMPObjectValue: RTMPAMF0ObjectConvertible {
    
    static let amf0Marker: AMF0Marker = .object
    
    var value: [RTMPObjectPropertyValue]

    let endMarkerData: Data = [
        0x00,
        0x00,
        0x09
    ].data

    static func create(data: inout Data) -> RTMPObjectValue {
        
        guard isEqualMarkar(data: data) else {
            fatalError("markar is not string")
        }
        
        var value: [RTMPObjectPropertyValue] = []
        
        //markar部分削除
        data.removeByteFromFirst(to: 1)
        
        while !isEndProperty(data: data) {
            let property = RTMPObjectPropertyValue.create(data: &data)
            value.append(property)
        }
        
        //終了時にcheckByteの3byte削除
        data.removeByteFromFirst(to: 3)
        
        return RTMPObjectValue(value: value)
    }
    
    /// Is end of object marker
    /// - Parameter data: check 3byte
    /// - Returns: isEndProperty
    private static func isEndProperty(data: Data) -> Bool {
        let mutableData = data
        let currentEndData = Array(mutableData.bytes[0..<3]).data
        
        
        let checkBytes: [UInt8] = [
            0x00,
            0x00,
            0x09
        ]
        
        let checkByteData = Data(bytes: checkBytes, count: checkBytes.count)
        
        let isEnd = checkByteData == currentEndData
        
        return isEnd
    }

    func toData() -> Data {

        var data = Data()
        //marker
        data.append(markerData)

        //property
        for property in value {
            let propertyData = property.toData()
            data.append(propertyData)
        }

        //insert end property marker
        data.append(endMarkerData)

        return data
    }
}
