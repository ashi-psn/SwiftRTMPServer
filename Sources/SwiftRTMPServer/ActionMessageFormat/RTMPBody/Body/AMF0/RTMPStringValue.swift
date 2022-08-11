import Foundation

struct RTMPStringValue: RTMPAMF0ObjectConvertible {
    
    static var amf0Marker: AMF0Marker = .string
    
    let value: String
    
    private static var messageLengthMarkerByteSize: Int { 2 }
    
    static func create(data: inout Data) -> RTMPStringValue {
        
        guard isEqualMarkar(data: data) else {
            fatalError("markar is not string")
        }
        
        //markar部分削除
        data.removeByteFromFirst(to: 1)
        
        let messageLengthByte = data
            .removeByteFromFirst(to: messageLengthMarkerByteSize)
        
        let messageLength = messageLengthByte.uint16
        
        let messageValueData = data
            .removeByteFromFirst(to: Int(messageLength))
        
        let message = String(data: messageValueData, encoding: .utf8) ?? ""
        
        return RTMPStringValue(value: message)
    }
    
    func toData() -> Data {
        
        guard let valueData = value.data(using: .utf8) else {
            fatalError("string value can not cast string")
        }
        
        //nemelengthを2バイト固定長にする
        let stringValueLength = UInt16(value.count)
        let stringValueLengthByte = stringValueLength.data
        
        
        var data = Data()
        data.append(markerData)
        data.append(stringValueLengthByte)
        data.append(valueData)
        
        return data
    }
}
