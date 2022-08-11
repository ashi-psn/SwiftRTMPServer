import Foundation
import SwiftyBit

final class RTMPDataResponseCreater {
    
    static var tempData = Data()
    
    static func create(data: inout Data, completation: ((RTMPStream) -> Void)) {
        
        var mutableData = tempData
        tempData = Data()
        mutableData.append(data)
        
        print("start create")
        mutableData.outputHex()
        print("--------------------")
        let header = RTMPHeader.create(data: &mutableData)
        print(header)
        
    }
}
