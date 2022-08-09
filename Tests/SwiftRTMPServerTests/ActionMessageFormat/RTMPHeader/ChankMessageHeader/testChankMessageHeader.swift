import XCTest
import SwiftyBit
@testable import SwiftRTMPServer

class testChankMessageHeader: XCTestCase {
    
    let expectedFmtVersion: UInt8  = 3
    let expectedChankStreamId: UInt8 = 3
    
    let expect11ByteMessageHeader: [UInt8] = [
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
    
    let expect7ByteMessageHeader: [UInt8] = [
        //timestampDelta
        0x00,
        0x00,
        0x03,
        
        //messagelength
        0x00,
        0x00,
        0x8b,
        
        //message type id
        0x14
    ]
    
    let expect3ByteMessageHeader: [UInt8] = [
        //timestampDelta
        0x00,
        0x00,
        0x03,
    ]
    
    
    func testCreate11Byte() {
        var testType0Data = expect11ByteMessageHeader.data
        let type0 = ChankMessageHeader.create(data: &testType0Data, formatType: .zero)
        
        XCTAssertEqual(type0.fmtType, .zero)
        XCTAssertEqual(type0.timestamp?.count, 3)
        XCTAssertEqual(type0.messageLength, 139)
        XCTAssertEqual(type0.messageType, .amf0command)
        XCTAssertEqual(type0.messageStreamId, UInt32.max)
    }
    
    func testCreate2Byte() {
        var testType1Data = expect7ByteMessageHeader.data
        let type1 = ChankMessageHeader.create(data: &testType1Data, formatType: .one)
        
        XCTAssertEqual(type1.fmtType, .one)
        XCTAssertEqual(type1.timestampDelta?.count, 3)
        XCTAssertEqual(type1.messageLength, 0x8b)
        XCTAssertEqual(type1.messageType, .amf0command)
    }

    func testCreate3Byte() {
        var testType3Data = expect3ByteMessageHeader.data
        let type3 = ChankMessageHeader.create(data: &testType3Data, formatType: .two)
        
        XCTAssertEqual(type3.fmtType, .two)
        XCTAssertEqual(type3.timestampDelta?.count, 3)
    }
    
    func testCreate0Byte() {
        var testType3Data = Data()
        let type3 = ChankMessageHeader.create(data: &testType3Data, formatType: .three)
        
        XCTAssertEqual(type3.fmtType, .three)
    }
    
    func testToData11Byte() {
        
        var testType0Data = expect11ByteMessageHeader.data
        let type0 = ChankMessageHeader.create(data: &testType0Data, formatType: .zero)
        let data = type0.toData()
        XCTAssertEqual(data, expect11ByteMessageHeader.data)
        XCTAssertEqual(data.count, 11)
    }
    
    func testToData7Byte() {
        
        var testType1Data = expect7ByteMessageHeader.data
        let type1 = ChankMessageHeader.create(data: &testType1Data, formatType: .one)
        let data = type1.toData()

        XCTAssertEqual(data, expect7ByteMessageHeader.data)
        XCTAssertEqual(data.count, 7)
    }

    func testToData3Byte() {
        var testType3Data = expect3ByteMessageHeader.data
        let type3 = ChankMessageHeader.create(data: &testType3Data, formatType: .two)
        let data = type3.toData()

        XCTAssertEqual(data, expect3ByteMessageHeader.data)
        XCTAssertEqual(data.count, 3)
    }
    
    func testToData0Byte() {
        var testType3Data = Data()
        let type3 = ChankMessageHeader.create(data: &testType3Data, formatType: .three)
        let data = type3.toData()
        
        XCTAssertEqual(data.count, 0)
    }
}

