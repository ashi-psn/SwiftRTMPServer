import XCTest
@testable import SwiftRTMPServer

class testRTMPObjectValue: XCTestCase {
    
    let expectObjectByte: [UInt8] = [
        0x03,
        
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
        0x00,
        0x04,
        0x74,
        0x79,
        
        0x70,
        0x65,
        0x02,
        0x00,
        0x0a,
        0x6e,
        0x6f,
        0x6e,
        
        0x70,
        0x72,
        0x69,
        0x76,
        0x61,
        0x74,
        0x65,
        0x00,
        
        0x08,
        0x66,
        0x6c,
        0x61,
        0x73,
        0x68,
        0x56,
        0x65,
        
        0x72,
        0x02,
        0x00,
        0x24,
        0x46,
        0x4d,
        0x4c,
        0x45,
        
        0x2f,
        0x33,
        0x2e,
        0x30,
        0x20,
        0x28,
        0x63,
        0x6f,
        
        0x6d,
        0x70,
        0x61,
        0x74,
        0x69,
        0x62,
        0x6c,
        0x65,
        
        0x3b,
        0x20,
        0x4c,
        0x61,
        0x76,
        0x66,
        0x35,
        0x39,
        
        0x2e,
        0x31,
        0x36,
        0x2e,
        0x31,
        0x30,
        0x30,
        0x29,
        
        0x00,
        0x05,
        0x74,
        0x63,
        0x55,
        0x72,
        0x6c,
        0x02,
        
        0x00,
        0x1a,
        0x72,
        0x74,
        0x6d,
        0x70,
        0x3a,
        0x2f,
        
        0x2f,
        0x6c,
        0x6f,
        0x63,
        0x61,
        0x6c,
        0x68,
        0x6f,
        
        0x73,
        0x74,
        0x3a,
        0x31,
        0x39,
        0x33,
        0x35,
        0x2f,
        
        0x6c,
        0x69,
        0x76,
        0x65,
        0x00,
        0x00,
        0x09,
    ]

    override func setUpWithError() throws {
    }
    
    
    func testCreate() {
        var data2 = expectObjectByte.data
        let numValue2 = RTMPObjectValue.create(data: &data2)
        
        XCTAssertEqual(data2.count, 0)
        XCTAssertEqual(numValue2.value.count, 4)
    }
    
    func testToData() {
        var data2 = expectObjectByte.data
        let numValue2 = RTMPObjectValue.create(data: &data2)
        
        let data = numValue2.toData()
        
        XCTAssertEqual(data, expectObjectByte.data)
    }
}
