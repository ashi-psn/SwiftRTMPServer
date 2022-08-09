import XCTest
@testable import SwiftRTMPServer

class testRTMPSetChankSizeValue: XCTestCase {
    
    let expectByte: [UInt8] = [
        0x00,
        0x00,
        0x10,
        0x00
    ]

    override func setUpWithError() throws {
    }
    
    func testToData() {
        
        let expectData = Data(bytes: expectByte, count: expectByte.count)
        
        let value = RTMPSetChankSizeValue(chankSize: 4096)
        let data = value.toData()
        
        XCTAssertEqual(data, expectData)
    }
    
    func testCreate() {
        var expectData = Data(bytes: expectByte, count: expectByte.count)
        
        let value = RTMPSetChankSizeValue.create(data: &expectData)
        XCTAssertEqual(value.chankSize, 4096)
    }
}

