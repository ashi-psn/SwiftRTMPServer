import Foundation

struct RTMPNullValue: RTMPAMF0ObjectConvertible {
    
    static var amf0Marker: AMF0Marker = .null
    
    static func create(data: inout Data) -> RTMPNullValue {
        guard isEqualMarkar(data: data) else {
            fatalError("markar is not number")
        }
        
        //markar部分削除
        data.removeByteFromFirst(to: 1)
        
        return RTMPNullValue()
    }
    
    func toData() -> Data {
        return markerData
    }    
}

