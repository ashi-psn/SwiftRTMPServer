import Foundation

enum AMF0Marker: UInt8 {
    case number = 0x00
//    case boolean = 0x01
    case string = 0x02
    case object = 0x03
    case null = 0x05
//    case undefined = 0x06
//    case reference = 0x07
    case ecmaArray = 0x08
//    case objectEnd = 0x09
//    case strinctArray = 0x0A
//    case date = 0x0B
//    case longString = 0x0C
//    case unsupported = 0x0D
//    case xmlDocument = 0x0F
//    case typedObject = 0x10
    
    var nameValue: String {
        switch self {
        case .number:
            return "number"
        case .string:
            return "string"
        case .object:
            return "object"
        case .null:
            return "null"
        case .ecmaArray:
            return "ECMA Array"
        }
    }
    
    var data: Data {
        return Data(bytes: [self.rawValue], count: 1)
    }
    
    func createValue(data: inout Data) -> RTMPAMF0ObjectConvertible {
        switch self {
        case .number:
            return RTMPNumberValue.create(data: &data)
        case .string:
            return RTMPStringValue.create(data: &data)
        case .object:
            return RTMPObjectValue.create(data: &data)
        case .null:
            return RTMPNullValue.create(data: &data)
        case .ecmaArray:
            return RTMPECMAArrayValue.create(data: &data)
        }
    }
}
