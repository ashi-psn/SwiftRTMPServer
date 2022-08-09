import XCTest
@testable import SwiftRTMPServer

class testS2: XCTestCase {
    
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
    
    var c1: C1?
    
    override func setUp() {
        data.append(expectDate)
        data.append(expectZero)
        data.append(Data(bytes: random, count: random.count))
        c1 = C1(data: data)
    }
    
    
    func testrandomBytes() {
        
        guard let c1 = c1 else {
            XCTFail()
            fatalError()
        }
        
        let s2 = S2(from: c1)
        
        XCTAssertEqual(s2.time1.count, 4)
        XCTAssertEqual(s2.time2.count, 4)
        XCTAssertEqual(s2.randomBytes.count, 1528)
        
        
        XCTAssertEqual(s2.time1, c1.time)
//        let data = Data(bytes: s2.time2, count: s2.time2.count)
//        let timediff = Int(data: data)
//        XCTAssertNotEqual(timediff, 0)
        XCTAssertEqual(s2.randomBytes, random)
    }
}
