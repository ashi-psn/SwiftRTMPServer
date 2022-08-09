import XCTest
@testable import SwiftRTMPServer

class testRTMPNumberValue: XCTestCase {
    
    let expectNumberPropertyData: [UInt8] = [
        0x00,
        0x3f,
        
        0xf0,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
    ]

    override func setUpWithError() throws {
    }
    
    func testToData() {
        
        let expectData = Data(bytes: expectNumberPropertyData, count: expectNumberPropertyData.count)
        
        let numberValue = RTMPNumberValue(value: 1)
        let data = numberValue.toData()
        
        XCTAssertEqual(numberValue.value, 1)
        XCTAssertEqual(data, expectData)
    }
    
    func testCreate() {
        var data2 = expectNumberPropertyData.data
        let numValue2 = RTMPNumberValue.create(data: &data2)
        
        XCTAssertEqual(data2.count, 0)
        XCTAssertEqual(numValue2.value, 1)
    }
    
}
