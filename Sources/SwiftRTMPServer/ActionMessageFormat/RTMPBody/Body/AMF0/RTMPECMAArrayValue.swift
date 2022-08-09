import Foundation

struct RTMPECMAArrayValue: RTMPAMF0ObjectConvertible {
    
    static var amf0Marker: AMF0Marker = .ecmaArray
    
    var value: [RTMPObjectPropertyValue]
    
    static func create(data: inout Data) -> RTMPECMAArrayValue {
        
        guard isEqualMarkar(data: data) else {
            fatalError("markar is not number")
        }
        
        var value: [RTMPObjectPropertyValue] = []
        
        //markar部分削除
        data.removeByteFromFirst(to: 1)
        
        //remove length
        data.removeByteFromFirst(to: MemoryLayout<UInt32>.size)
        
        while !isEndProperty(data: data) {
            let property = RTMPObjectPropertyValue.create(data: &data)
            value.append(property)
        }
        
        //終了時にcheckByteの3byte削除
        data.removeByteFromFirst(to: 3)
        
        return RTMPECMAArrayValue(value: value)
    }
    
    func toData() -> Data {
        var data = Data()
        let length: UInt32 = UInt32(value.count)
        
        data.append(markerData)
        data.append(length.data)
        value.forEach {
            data.append($0.toData())
        }
        
        let endMarker:[UInt8] = [
            0x00,
            0x00,
            0x09
        ]
        
        data.append(endMarker.data)
        return data
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
    
}
