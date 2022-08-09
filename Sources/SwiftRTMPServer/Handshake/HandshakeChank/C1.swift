import Foundation

struct C1 {
    
    
    /// time area 4 bytes
    let time: [UInt8]
    
    /// zero fill field 4bytes
    let zero: [UInt8]
    
    
    /// random bytes area 1528bytes
    let randomBytes: [UInt8]
    
    let createdAt: Date = Date()
    
    init(data: Data) {
        
        guard data.count == 1536 else {
            fatalError("invalid data format")
        }
        
        //先頭から4バイト取り出す
        time = data.prefix(4).reversed()
        
        //5バイト目から8バイトまで取り出す
        zero = data[4...7].reversed()
        //9バイト目からバイトまで取り出す
//        randomBytes = data[8...1535].reversed()
        randomBytes = data.suffix(1528)
    }
}
