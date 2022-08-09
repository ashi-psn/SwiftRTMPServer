import Foundation

struct S1 {
    /// time area 4 bytes
    let time: [UInt8] = {
        let bytes: [UInt8] = (1...4).map { _ in 0 }
        return bytes
    }()
    
    
    /// zero fill field 4bytes
    let zero: [UInt8] = {
        let bytes: [UInt8] = (1...4).map { _ in 0 }
        return bytes
    }()
    
    
    /// random bytes area 1528bytes
    let randomBytes: [UInt8] = {
        let bytes = (1...1528).map { _ in
            UInt8.random(in: 0...255)
        }
        return bytes
    }()
}

extension S1: DataConvertible {
    func toData() -> Data {
        var bytes: [UInt8] = []
        bytes += time
        bytes += zero
        bytes += randomBytes
        let data = Data(bytes: &bytes, count: bytes.count)
        return data
    }
}
