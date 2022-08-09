import XCTest
@testable import SwiftRTMPServer

class testC1: XCTestCase {
    
    
    let expectDate: Data = Data([
        0x00,
        0x00,
        0x00,
        0x00,
    ])
    
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
    
    override func setUp() {
        data.append(expectDate)
        data.append(expectZero)
        data.append(Data(bytes: random, count: random.count))
    }
    
    func testExpectVersion() {
        
        let c1 = C1(data: data)
        
        XCTAssertEqual(c1.time.count, 4)
        XCTAssertEqual(c1.zero.count, 4)
        XCTAssertEqual(c1.randomBytes.count, 1528)
        
        let zeroValue = Data(bytes: c1.zero, count: c1.zero.count)
        XCTAssertEqual(zeroValue, expectZero)
        XCTAssertEqual(c1.randomBytes, random)
    }
}
