import Foundation

struct CreateStreamResultCommand: RTMPServerRequestConvertible {
    
    var format: FormatType = .zero
    
    var chankStreamId: UInt16 = 3
    
    var messageTypeId: RTMPMessageType = .amf0command
    
    var messageStreamId: UInt32? = 0
    
    var body: Data = {
        var data = Data()
        let stringValue = RTMPStringValue(value: "_result")
        let numberValue = RTMPNumberValue(value: 4)
        let nullValue = RTMPNullValue()
        let number2Value = RTMPNumberValue(value: 1)
        
        
        data.append(stringValue.toData())
        data.append(numberValue.toData())
        data.append(nullValue.toData())
        data.append(number2Value.toData())
        
        return data
    }()
    
}
