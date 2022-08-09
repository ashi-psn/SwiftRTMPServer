import Foundation

enum ChankBasicHeaderType: Int {
    case one = 1
    case two = 2
    case three = 3
    
    var basicHeaderByteSize: Int {
        return self.rawValue
    }
}
