import XCTest
@testable import SwiftRTMPServer

class testExtendedTimestampHeader: XCTestCase {
    
    let expectExtendedTimestamp: [UInt8] = [
        0b00,
        0b00,
        0b01,
        0b00
    ]

    override func setUpWithError() throws {
    }
    
    func testCreate() {
        let testBytes: [UInt8] = expectExtendedTimestamp
        
        var data = testBytes.data
        let header = ExtendedTimestampHeader.create(data: &data)
        
        let timestamp = header.timestamp
        
        XCTAssertEqual(timestamp.count, 4)
        
        XCTAssertEqual(timestamp, expectExtendedTimestamp)
    }
    
    func testToData() {
        let testBytes: [UInt8] = expectExtendedTimestamp
        
        var data = testBytes.data
        let header = ExtendedTimestampHeader.create(data: &data)
        let resultData = header.toData()
        
        XCTAssertEqual(resultData, expectExtendedTimestamp.data)
    }
}
