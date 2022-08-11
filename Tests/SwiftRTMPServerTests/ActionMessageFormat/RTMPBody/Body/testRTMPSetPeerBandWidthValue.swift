import XCTest
@testable import SwiftRTMPServer

class testRTMPSetPeerBandWidthValue: XCTestCase {
    
    let expectByte: [UInt8] = [
        0x00,
        0x4c,
        0x4b,
        0x40,
        0x02
    ]

    override func setUpWithError() throws {
    }
    
    func testToData() {
        
        let expectData = Data(bytes: expectByte, count: expectByte.count)
        
        let value = RTMPSetPeerBandWidthValue(bandWidth: 5000000, limitType: .dynamic)
        let data = value.toData()
        
        XCTAssertEqual(data, expectData)
    }
    
    func testCreate() {
        var expectData = Data(bytes: expectByte, count: expectByte.count)
        
        let value = RTMPSetPeerBandWidthValue.create(data: &expectData)
        XCTAssertEqual(value.bandWidth, 5000000)
        XCTAssertEqual(value.limitType, .dynamic)
    }
}
