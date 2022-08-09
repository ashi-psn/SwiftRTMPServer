import XCTest
@testable import SwiftRTMPServer

class testRTMPStingValue: XCTestCase {
    
    let expectStringPropertyData: [UInt8] = [
        0x02,
        0x00,
        0x07,
        0x63,
        
        0x6f,
        0x6e,
        0x6e,
        0x65,
        0x63,
        0x74
    ]

    override func setUpWithError() throws {
    }
    
    func testToStringData() {
        
        let expectData = Data(bytes: expectStringPropertyData, count: expectStringPropertyData.count)
        
        let stringValue = RTMPStringValue(value: "connect")
        let data = stringValue.toData()
        
        XCTAssertEqual(stringValue.value, "connect")
        XCTAssertEqual(data, expectData)
    }
    
    func testCreate() {
        var expectData = Data(bytes: expectStringPropertyData, count: expectStringPropertyData.count)
        
        let stringValue = RTMPStringValue.create(data: &expectData)
        XCTAssertEqual(expectData.count, 0)
        XCTAssertEqual(stringValue.value, "connect")
    }
}

