import XCTest
@testable import SwiftRTMPServer

class testRTMPWindowAcknowledgementValue: XCTestCase {
    
    let expectByte: [UInt8] = [
        0x00,
        0x4c,
        0x4b,
        0x40
    ]

    override func setUpWithError() throws {
    }
    
    func testToData() {
        
        let expectData = Data(bytes: expectByte, count: expectByte.count)
        
        let value = RTMPWindowAcknowledgementValue(windowAcknowledgementSize: 5000000)
        let data = value.toData()
        
        XCTAssertEqual(data, expectData)
    }
    
    func testCreate() {
        var expectData = Data(bytes: expectByte, count: expectByte.count)
        
        let value = RTMPWindowAcknowledgementValue.create(data: &expectData)
        XCTAssertEqual(value.windowAcknowledgementSize, 5000000)
    }
}
