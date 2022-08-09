import Foundation

struct S0 {
    let serverVersion: UInt8 = 3
}

extension S0: DataConvertible {
    
    func toData() -> Data {
        return serverVersion.data
    }
}
