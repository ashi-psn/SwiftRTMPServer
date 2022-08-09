import XCTest
@testable import SwiftRTMPServer

class testRTMPNullValue: XCTestCase {
    
    let expectByte: [UInt8] = [
        0x05
    ]

    override func setUpWithError() throws {
    }
    
    func testToData() {
        
        let expectData = Data(bytes: expectByte, count: expectByte.count)
        
        let nullValue = RTMPNullValue()
        let data = nullValue.toData()
        
        XCTAssertEqual(data, expectData)
    }
    
    func testCreate() {
        var expectData = Data(bytes: expectByte, count: expectByte.count)
        
        let nullValue = RTMPNullValue.create(data: &expectData)
        XCTAssertEqual(nullValue.markerData, AMF0Marker.null.data)
    }
}

