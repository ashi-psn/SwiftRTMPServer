import Foundation

struct ChankMessageHeader: RTMPChankMessageDataConvertible {
    
    let fmtType: FormatType
    
    // MARK: - FMT0 only appeard
    /// Timestamp Format 3byte
    var timestamp: [UInt8]?
    
    /// Message Stream ID 4byte
    var messageStreamId: UInt32?
    
    // MARK: - FMT0 and FMT1 appeard
    /// MessageLength format 3byte
    var messageLength: UInt32?
    
    /// Message type ID format 1byte
    var messageType: RTMPMessageType?
    
    // MARK: - FMT1 and FMT2 appeard
    /// Timestamp Format 3byte
    var timestampDelta: [UInt8]?
    
    
    static func create(data: inout Data, formatType: FormatType) -> ChankMessageHeader {
        
        switch formatType {
        case .zero:
            return createFMT0ChankMessageHeader(data: &data)
        case .one:
            return createFMT1ChankMessageHeader(data: &data)
        case .two:
            return createFMT2ChankMessageHeader(data: &data)
        case .three:
            return createFMT3ChankMessageHeader(data: &data)
        }
    }
    
    func toData() -> Data {
        
        switch fmtType {
        case .zero:
            return toDataFMT0Format()
        case .one:
            return toDataFMT1Format()
        case .two:
            return toDataFMT2Format()
        case .three:
            return toDataFMT3Format()
        }
    }
}

// MARK: - ChankMessageHeader + create
extension ChankMessageHeader {
    
    private static func createFMT0ChankMessageHeader(data: inout Data) -> ChankMessageHeader {
        
        //timestampは先頭から3バイト
        let timestamp = data.removeByteFromFirst(to: 3).bytes
        
        //message lengthは続く3バイト
        //3byteのため、UInt32にして値を保持するため、1byte付け足す
        let messageLengthByte = data.removeByteFromFirst(to: 3).bytes
        var maskData = Data()
        maskData.append(0b00)
        let messageLengthData = Data(
            bytes: messageLengthByte,
            count: messageLengthByte.count)
        maskData.append(messageLengthData)
        let messageLength = maskData.uint32
        
        //messagetypeは1バイト
        let messageTypeId = data.removeFirst()
        guard let messageType = RTMPMessageType(rawValue: messageTypeId) else {
            fatalError("messageType cannot support value \(messageTypeId)")
        }
        //message stream idは4byte
        let messageStreamIdByte = data.removeByteFromFirst(to: 4).bytes
        let messageStreamIdData = Data(
            bytes: messageStreamIdByte,
            count: messageStreamIdByte.count)
        let messageStreamId = messageStreamIdData.uint32
        
        
        return ChankMessageHeader(
            fmtType: .zero,
            timestamp: timestamp,
            messageStreamId: messageStreamId,
            messageLength: messageLength,
            messageType: messageType
        )
    }
    
    private static func createFMT1ChankMessageHeader(data: inout Data) -> ChankMessageHeader {
        
        //timestampは先頭から3バイト
        let timestampDelta = data.removeByteFromFirst(to: 3).bytes
        
        //message lengthは続く3バイト
        //3byteのため、UInt32にして値を保持するため、1byte付け足す
        let messageLengthByte = data.removeByteFromFirst(to: 3).bytes
        var maskData = Data()
        maskData.append(0b00)
        let messageLengthData = Data(
            bytes: messageLengthByte,
            count: messageLengthByte.count)
        maskData.append(messageLengthData)
        let messageLength = maskData.uint32
        
        //messagetypeは1バイト
        let messageTypeId = data.removeFirst()
        guard let messageType = RTMPMessageType(rawValue: messageTypeId) else {
            fatalError("messageType cannot support value \(messageTypeId)")
        }
        
        return ChankMessageHeader(
            fmtType: .one,
            messageLength: messageLength,
            messageType: messageType,
            timestampDelta: timestampDelta
        )
    }
    
    private static func createFMT2ChankMessageHeader(data: inout Data) -> ChankMessageHeader {
        
        //timestampは先頭から3バイト
        let timestampDelta = data.removeByteFromFirst(to: 3).bytes
        
        return ChankMessageHeader(
            fmtType: .two,
            timestampDelta: timestampDelta
        )
    }
    
    private static func createFMT3ChankMessageHeader(data: inout Data) -> ChankMessageHeader {
        return ChankMessageHeader(fmtType: .three)
    }
}

// MARK: - ChankMessageHeader + toData
extension ChankMessageHeader {
    
    func toDataFMT0Format() -> Data {
        
        var data = Data()
        
        //timestamp
        if let timestamp = timestamp {
            data.append(timestamp.data)
        }
        
        //messageLength
        if let messageLength = messageLength {
            var messageLengthData = messageLength.data
            messageLengthData.removeFirst()
            data.append(messageLengthData)
        }
        
        //message type id
        if let messageType = messageType {
            data.append(messageType.rawValue.data)
        }
        
        //messagestreamid
        //bigendianにする
        if let messageStreamId = messageStreamId {
            data.append(messageStreamId.bigEndian.data)
        }
        
        return data
    }
    
    func toDataFMT1Format() -> Data {
        
        var data = Data()
        
        //timestamp
        if let timestampDelta = timestampDelta {
            data.append(timestampDelta.data)
        }
        
        //messageLength
        if let messageLength = messageLength {
            var messageLengthData = messageLength.data
            messageLengthData.removeFirst()
            data.append(messageLengthData)
        }
        
        //message type id
        if let messageType = messageType {
            data.append(messageType.rawValue.data)
        }
        
        return data
    }
    
    func toDataFMT2Format() -> Data {
        
        guard let timestampDelta = timestampDelta else {
            fatalError("timestampDelta must exist")
        }
        return timestampDelta.data
    }
    
    func toDataFMT3Format() -> Data {
        return Data()
    }
}
