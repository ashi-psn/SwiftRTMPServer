import Foundation

protocol DataConvertible {
    func toData() -> Data
}

protocol RTMPChankMessageDataConvertible {
    static func create(data: inout Data, formatType: FormatType) -> Self
}

protocol RTMPDataCreateConvertible: DataConvertible {
    static func create(data: inout Data) -> Self
}

protocol RTMPAMF0ObjectConvertible: RTMPDataCreateConvertible {
    static var amf0Marker: AMF0Marker { get }
    var markerData: Data { get }
    static func isEqualMarkar(data: Data) -> Bool
}

extension RTMPAMF0ObjectConvertible {
    
    var markerData: Data {
        return Self.amf0Marker.data
    }
    
    static func isEqualMarkar(data: Data) -> Bool {
        guard let firstByte = data.first else {
            fatalError("data is empty")
        }
        
        return firstByte == amf0Marker.rawValue
    }
}
