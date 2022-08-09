import XCTest
import SwiftyBit
@testable import SwiftRTMPServer


class testC2: XCTestCase {
    
    let expectDate: UInt8 = 0b00
    
    let expectZero: Data = Data([
        0x00,
        0x00,
        0x00,
        0x00,
    ])
    
    let random: [UInt8] = (1...1528).map { _ in
        UInt8.random(in: 0...255)
    }
    
    var data: Data = Data()
    
    var c2: C2?
    
    override func setUp() {
        let s1 = S1()
        c2 = C2(from: s1)
    }
    
    
    func testrandomBytes() {
        
        guard let c2 = c2 else {
            XCTFail()
            fatalError()
        }
        
        XCTAssertEqual(c2.time1.count, 4)
        XCTAssertEqual(c2.time2.count, 4)
        XCTAssertEqual(c2.randomBytes.count, 1528)
    }
    
}
