import XCTest
@testable import SwiftRTMPServer

class testSetChankSizeCommand: XCTestCase {
    
    let testByte: [UInt8] = [
        0x02,
        0x00,
        0x00,
        
        0x00,
        0x00,
        0x00,
        0x04,
        0x01,
        0x00,
        0x00,
        0x00,
        
        0x00,
        0x00,
        0x00,
        0x10,
        0x00
    ]

    override func setUpWithError() throws {
    }
    
    
    func testCreate() {
        let body = SetChankSizeCommand()
        XCTAssertEqual(body.format, .zero)
        
    }
    
    func testToData() {
        let testData = testByte.data
        let body = SetChankSizeCommand()
        XCTAssertEqual(body.toData(), testData)
    }
}


