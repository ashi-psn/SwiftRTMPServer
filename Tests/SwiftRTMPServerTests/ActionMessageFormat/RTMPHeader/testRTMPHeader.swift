import XCTest
import SwiftyBit
@testable import SwiftRTMPServer

class testRTMPHeader: XCTestCase {
    
    let expect12ByteMessageHeader: [UInt8] = [
        //fmtAndChankStreamId
        0x03,
        
        //timestamp
        0x00,
        0x00,
        0x00,
        
        //messagelength
        0x00,
        0x00,
        0x8b,
        
        //message type id
        0x14,
        
        //message stream id
        0xff,
        0xff,
        0xff,
        0xff
    ]
    
    
    
    func testCreate12Byte() {
        var testData = expect12ByteMessageHeader.data
        let header = RTMPHeader.create(data: &testData)
        
        //basic header
        XCTAssertEqual(header.basicHeader.fmt, .zero)
        XCTAssertEqual(header.basicHeader.basicHeaderType, ChankBasicHeaderType.one)
        XCTAssertEqual(header.basicHeader.chankStreamId, 3)
        XCTAssertEqual(testData.count, 0)
        
        //message header
        XCTAssertEqual(header.messageHeader.fmtType, .zero)
        XCTAssertEqual(header.messageHeader.timestamp?.count, 3)
        XCTAssertEqual(header.messageHeader.messageLength, 139)
        XCTAssertEqual(header.messageHeader.messageType, .amf0command)
        XCTAssertEqual(header.messageHeader.messageStreamId, UInt32.max)
        
        
    }
    
    
    func testToData12Byte() {
        var testData = expect12ByteMessageHeader.data
        let header = RTMPHeader.create(data: &testData)
        let data = header.toData()
        
        XCTAssertEqual(data, expect12ByteMessageHeader.data)
    }
}

