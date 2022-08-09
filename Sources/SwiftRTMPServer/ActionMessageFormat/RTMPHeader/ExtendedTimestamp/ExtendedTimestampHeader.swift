import Foundation

struct ExtendedTimestampHeader: RTMPDataCreateConvertible {
    
    /// Timestamp Format 4byte
    let timestamp: [UInt8]
    
    static func create(data: inout Data) -> ExtendedTimestampHeader {
        let timestamp = data.removeByteFromFirst(to: 4).bytes
        return ExtendedTimestampHeader(timestamp: timestamp)
    }
    
    func toData() -> Data {
        return timestamp.data
    }
}
