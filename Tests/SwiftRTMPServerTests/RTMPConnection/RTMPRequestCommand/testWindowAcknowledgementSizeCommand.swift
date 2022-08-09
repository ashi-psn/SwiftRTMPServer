import XCTest
@testable import SwiftRTMPServer

class testWindowAcknowledgementSizeCommand: XCTestCase {
    
    let testByte: [UInt8] = [
        0x02,
        0x00,
        0x00,
        0x00,
        
        0x00,
        0x00,
        0x04,
        0x05,
        0x00,
        0x00,
        0x00,
        0x00,
        
        0x00,
        0x4c,
        0x4b,
        0x40
    ]

    override func setUpWithError() throws {
    }
    
    
    func testCreate() {
        let body = WindowAcknowledgementSizeCommand()
        XCTAssertEqual(body.format, .zero)
        
    }
    
    func testToData() {
        let testData = testByte.data
        let body = WindowAcknowledgementSizeCommand()
        XCTAssertEqual(body.toData(), testData)
    }
}


