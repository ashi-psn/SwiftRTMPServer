import Foundation

protocol RTMPServerRequestConvertible: DataConvertible {
    
    var format: FormatType { get }
    var chankStreamId: UInt16 { get }
    var chankBasicHeaderType: ChankBasicHeaderType { get }
    var timestamp: [UInt8] { get }
    var timestampDelta: [UInt8] { get }
    var messageLength: UInt32 { get }
    var messageLengthData: Data { get }
    var messageTypeId: RTMPMessageType { get }
    var messageStreamId: UInt32? { get }
    
    var chankBasicHeader: ChankBasicHeader { get }
    var chankMessageHeader: ChankMessageHeader { get }
    var extendedTimestamp: ExtendedTimestampHeader? { get }
    var body: Data { get }
    
    func toRTMPHeader() -> RTMPHeader
}

extension RTMPServerRequestConvertible {
    
    var chankBasicHeaderType: ChankBasicHeaderType {
        //6bit最大値以下であれば1byte
        //1byte最大値よりおおきければ3byte
        //1byte以内かつ6bit以上であれば2byte
        let sixBitMax =
            NSDecimalNumber(decimal: pow(2, 6))
            .uint32Value
        
        if chankStreamId <= sixBitMax {
            return .one
        } else if chankStreamId > UInt8.max {
            return .three
        } else {
            return .two
        }
    }
    
    var timestamp: [UInt8] {
        return [
            0x00,
            0x00,
            0x00
        ]
    }
    
    var timestampDelta: [UInt8] {
        return [
            0x00,
            0x00,
            0x00
        ]
    }
    
    var messageLength: UInt32 {
        return UInt32(body.count)
    }
    
    var messageLengthData: Data {
        //先頭1byteを削除して3byteにする
        var bodySizeData = messageLength.data
        bodySizeData.removeFirst()
        return bodySizeData
    }
    
    var messageStreamId: UInt32? {
        return nil
    }
    
    var chankBasicHeader: ChankBasicHeader {
        return ChankBasicHeader(
            basicHeaderType: chankBasicHeaderType,
            fmt: format,
            chankStreamId: chankStreamId
        )
    }
    
    var chankMessageHeader: ChankMessageHeader {
        return ChankMessageHeader(
            fmtType: format,
            timestamp: timestamp,
            messageStreamId: messageStreamId,
            messageLength: messageLength,
            messageType: messageTypeId,
            timestampDelta: timestampDelta
        )
    }
    
    var extendedTimestamp: ExtendedTimestampHeader? {
        return nil
    }
    
    func toRTMPHeader() -> RTMPHeader {
        return RTMPHeader(
            basicHeaderType: chankBasicHeaderType,
            basicHeader: chankBasicHeader,
            messageHeader: chankMessageHeader,
            extendedTimestamp: extendedTimestamp
        )
    }
    
    func toData() -> Data {
        var data = Data()
        
        let basicHeaderData = chankBasicHeader.toData()
        data.append(basicHeaderData)
        let messageHeaderData = chankMessageHeader.toData()
        data.append(messageHeaderData)
        
        if let extendedTimestamp = extendedTimestamp {
            data.append(extendedTimestamp.toData())
        }
        
        //add body data
        data.append(body)
        return data
    }
}
