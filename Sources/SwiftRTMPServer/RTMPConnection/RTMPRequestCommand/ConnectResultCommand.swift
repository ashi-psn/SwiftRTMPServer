import Foundation

struct ConnectResultCommand: RTMPServerRequestConvertible {
    
    var format: FormatType = .zero
    
    var chankStreamId: UInt16 = 3
    
    var messageTypeId: RTMPMessageType = .amf0command
    
    var messageStreamId: UInt32? = 0
    
    var body: Data = {
        var data = Data()
        let stringValue = RTMPStringValue(value: "_result")
        let numberValue = RTMPNumberValue(value: 1)
        let fmsVersionObjectValue = RTMPObjectValue(
            value: [
                RTMPObjectPropertyValue(
                    name: "fmsVer",
                    value: RTMPStringValue(value: "FMS/3,0,1,123")
                ),
                RTMPObjectPropertyValue(
                    name: "capabilities",
                    value: RTMPNumberValue(value: 31)
                )
            ]
        )
        let levelObjectValue = RTMPObjectValue(
            value: [
                RTMPObjectPropertyValue(
                    name: "level",
                    value: RTMPStringValue(value: "status")
                ),
                RTMPObjectPropertyValue(
                    name: "code",
                    value: RTMPStringValue(value: "NetConnection.Connect.Success")
                ),
                RTMPObjectPropertyValue(
                    name: "description",
                    value: RTMPStringValue(value: "Connection succeeded.")
                ),
                RTMPObjectPropertyValue(
                    name: "objectEncoding",
                    value: RTMPNumberValue(value: 0)
                )
            ]
        )
        
        data.append(stringValue.toData())
        data.append(numberValue.toData())
        data.append(fmsVersionObjectValue.toData())
        data.append(levelObjectValue.toData())
        
        return data
    }()
    
}
