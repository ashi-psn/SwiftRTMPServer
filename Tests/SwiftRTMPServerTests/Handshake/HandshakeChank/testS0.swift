import XCTest
@testable import SwiftRTMPServer

class testS0: XCTestCase {
    
    let expectVersion: UInt8 = 3
    
    func testExpectVersion() {
        let s0 = S0()
        
        XCTAssertEqual(s0.serverVersion, expectVersion)
        XCTAssertEqual(s0.toData().count, 1)
    }
}
