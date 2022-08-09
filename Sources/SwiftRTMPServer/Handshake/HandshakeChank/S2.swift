import Foundation

struct S2 {
    /// init from c1 timestamp(4bytes)
    let time1: [UInt8]
    
    /// init from recived c1 time(4byte)
    /// c1を読み取った時間のタイムスタンプ
    let time2: [UInt8]
    
    /// init from c1 randomBytes(1528bytes)
    let randomBytes: [UInt8]
    
    init(from data: C1) {
        self.time1 = data.time
        self.time2 = [
            0x00,
            0x00,
            0x00,
            0x00
        ]
        
        self.randomBytes = data.randomBytes
    }
}

extension S2: DataConvertible {
    func toData() -> Data {
        var bytes: [UInt8] = []
        bytes += time1
        bytes += time2
        bytes += randomBytes
        let data = Data(bytes: &bytes, count: bytes.count)
        return data
    }
}
