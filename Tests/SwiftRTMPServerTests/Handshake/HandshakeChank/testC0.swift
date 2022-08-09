import XCTest
@testable import SwiftRTMPServer

class testC0: XCTestCase {
    
    let expectVersion: UInt8 = 0b0011
    let expectVersionString: String = "3"
    
    func testExpectVersion() {
        
        let c0 = C0(serverVersion: expectVersion)
        XCTAssertEqual(String(c0.serverVersion, radix: 16), expectVersionString)
    }
}
