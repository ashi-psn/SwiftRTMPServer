import XCTest
@testable import SwiftRTMPServer

class testS1: XCTestCase {
    
    override func setUp() {
    }
    
    func testrandomBytes() {
        
        let s1 = S1()
        
        XCTAssertEqual(s1.time.count, 4)
        XCTAssertEqual(s1.zero.count, 4)
        XCTAssertEqual(s1.randomBytes.count, 1528)
        XCTAssertEqual(s1.toData().count, 1536)
    }
}
