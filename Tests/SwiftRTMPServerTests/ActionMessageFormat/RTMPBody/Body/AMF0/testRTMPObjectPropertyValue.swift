import XCTest
@testable import SwiftRTMPServer

class testRTMPObjectPropertyValue: XCTestCase {
    
    let expectObjectByte: [UInt8] = [
        0x00,
        0x03,
        0x61,
        0x70,
        0x70,
        0x02,
        0x00,
        0x04,
        
        0x6c,
        0x69,
        0x76,
        0x65,
    ]

    override func setUpWithError() throws {
    }
    
    
    func testCreate() {
        var data = expectObjectByte.data
        let property = RTMPObjectPropertyValue.create(data: &data)
        
        XCTAssertEqual(data.count, 0)
        XCTAssertTrue(property.value is RTMPStringValue, "")
    }
    
    func testToData() {
        var data2 = expectObjectByte.data
        let property = RTMPObjectPropertyValue.create(data: &data2)
        
        let data = property.toData()
        
        XCTAssertEqual(data, expectObjectByte.data)
    }
}
