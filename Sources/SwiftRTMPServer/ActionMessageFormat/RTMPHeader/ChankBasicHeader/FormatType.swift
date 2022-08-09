import Foundation

enum FormatType: UInt8 {
    case zero = 0
    case one = 1
    case two = 2
    case three = 3
    
    var messageHeaderByteSize: Int {
        switch self {
        case .zero:
            return 11
        case .one:
            return 7
        case .two:
            return 3
        case .three:
            return 0
        }
    }
}
