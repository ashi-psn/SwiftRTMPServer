import XCTest
@testable import SwiftRTMPServer

class testCreateStreamResultCommand: XCTestCase {
    
    let testByte: [UInt8] = [
        0x03,
        0x00,
        0x00,
        0x00,
        
        0x00,
        0x00,
        0x1d,
        0x14,
        0x00,
        0x00,
        0x00,
        0x00,
        
        0x02,
        0x00,
        0x07,
        0x5f,
        0x72,
        0x65,
        0x73,
        0x75,
        
        0x6c,
        0x74,
        0x00,
        0x40,
        0x10,
        0x00,
        0x00,
        0x00,
        
        0x00,
        0x00,
        0x00,
        0x05,
        0x00,
        0x3f,
        0xf0,
        0x00,
        
        0x00,
        0x00,
        0x00,
        0x00,
        0x00
    ]

    override func setUpWithError() throws {
    }
    
    
    func testCreate() {
        let command = CreateStreamResultCommand()
        XCTAssertEqual(command.format, .zero)
    }
    
    func testToData() {
        let testData = testByte.data
        let body = CreateStreamResultCommand()
        XCTAssertEqual(body.toData(), testData)
    }
}



