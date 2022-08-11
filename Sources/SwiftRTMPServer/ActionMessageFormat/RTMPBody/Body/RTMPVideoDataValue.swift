import Foundation

struct RTMPVideoDataValue: RTMPDataCreateConvertible {
    
    enum ControlType: UInt8 {
        case h264 = 0x17
    }
    
    let control: ControlType
    
    let videoData: Data
    
    private static var controlLength: Int {
        return 1
    }
    
    static func create(data: inout Data) -> RTMPVideoDataValue {
        
        let control = data.removeByteFromFirst(to: controlLength).uint8
        guard let control = ControlType(rawValue: control) else {
            fatalError("control value is unsupported \(control)")
        }
        
        let videoData = data.removeByteFromFirst(to: data.count)
        
        return RTMPVideoDataValue(
            control: control,
            videoData: videoData
        )
    }
    
    func toData() -> Data {
        var data = Data()
        data.append(control.rawValue.data)
        data.append(videoData)
        return data
    }
}
