import Foundation

struct OnStatusCommand: RTMPServerRequestConvertible {
    
    var format: FormatType = .zero
    
    var chankStreamId: UInt16 = 5
    
    var messageTypeId: RTMPMessageType = .amf0command
    
    var messageStreamId: UInt32? = 1
    
    var body: Data = {
        
        var data = Data()
        let stringValue = RTMPStringValue(value: "onStatus")
        let numberValue = RTMPNumberValue(value: 0)
        let nullValue = RTMPNullValue()
        let objectValue = RTMPObjectValue(
            value: [
                RTMPObjectPropertyValue(
                    name: "level",
                    value: RTMPStringValue(value: "status")
                ),
                RTMPObjectPropertyValue(
                    name: "code",
                    value: RTMPStringValue(value: "NetStream.Publish.Start")
                ),
                RTMPObjectPropertyValue(
                    name: "description",
                    value: RTMPStringValue(value: "Start publishing")
                )
            ]
        )
        
        data.append(stringValue.toData())
        data.append(numberValue.toData())
        data.append(nullValue.toData())
        data.append(objectValue.toData())
        
        return data
    }()
    
    
}
