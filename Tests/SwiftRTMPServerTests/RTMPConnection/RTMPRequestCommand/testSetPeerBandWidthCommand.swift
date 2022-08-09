import XCTest
@testable import SwiftRTMPServer

class testSetPeerBandWidthCommand: XCTestCase {
    
    let testByte: [UInt8] = [
        0x02,
        0x00,
        0x00,
        0x00,
        
        0x00,
        0x00,
        0x05,
        0x06,
        0x00,
        0x00,
        0x00,
        0x00,
        
        0x00,
        0x4c,
        0x4b,
        0x40,
        0x02
    ]

    override func setUpWithError() throws {
    }
    
    
    func testCreate() {
        let command = SetPeerBandWidthCommand()
        XCTAssertEqual(command.format, .zero)
        
        
    }
    
    func testToData() {
        let testData = testByte.data
        let body = SetPeerBandWidthCommand()
        XCTAssertEqual(body.toData(), testData)
    }
}


