import Foundation

struct RTMPSetChankSizeValue: RTMPDataCreateConvertible {
    
    let chankSize: UInt32
    
    static func create(data: inout Data) -> RTMPSetChankSizeValue {
        
        let chankSizeByte = data.removeByteFromFirst(to: 4).bytes
        let chankSizeData = Data(
            bytes: chankSizeByte,
            count: chankSizeByte.count
        )
        let chankSize = chankSizeData.uint32
        
        return RTMPSetChankSizeValue(
            chankSize: chankSize
        )
    }
    
    func toData() -> Data {
        return chankSize.data
    }
}
