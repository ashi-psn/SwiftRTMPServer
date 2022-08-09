import XCTest
import SwiftyBit
@testable import SwiftRTMPServer

class testChankBasicHeader: XCTestCase {
    
    let expectedFmtVersion: UInt8  = 3
    let expectedChankStreamId: UInt8 = 3
    
    let expect1ByteBasicHeader: UInt8 = 0b01000011
    let expect2ByteBasicHeader: UInt16 = 0b0100000000000011
    let expect3ByteBasicHeader: [UInt8] = [
        0b01111111,
        0b11111111,
        0b11111111
    ]
    
    
    func testCreate1Byte() {
        var testType1Data = expect1ByteBasicHeader.data
        let type1 = ChankBasicHeader.create(data: &testType1Data)
        XCTAssertEqual(type1.fmt.rawValue, 1)
        XCTAssertEqual(type1.basicHeaderType, ChankBasicHeaderType.one)
        XCTAssertEqual(type1.chankStreamId, 3)
        XCTAssertEqual(testType1Data.count, 0)
    }
    
    func testCreate2Byte() {
        var testType2Data = expect2ByteBasicHeader.data
        let type2 = ChankBasicHeader.create(data: &testType2Data)
        XCTAssertEqual(type2.fmt.rawValue, 1)
        XCTAssertEqual(type2.basicHeaderType, ChankBasicHeaderType.two)
        XCTAssertEqual(type2.chankStreamId, 3)
        XCTAssertEqual(testType2Data.count, 0)
    }
    
    func testCreate3Byte() {
        var testType3Data = expect3ByteBasicHeader.data
        let type3 = ChankBasicHeader.create(data: &testType3Data)
        XCTAssertEqual(type3.fmt.rawValue, 1)
        XCTAssertEqual(type3.basicHeaderType, ChankBasicHeaderType.three)
        XCTAssertEqual(type3.chankStreamId, UInt16.max)
        XCTAssertEqual(testType3Data.count, 0)
    }
    
    func testToData1Byte() {
        var testType1Data = expect1ByteBasicHeader.data
        let type1 = ChankBasicHeader.create(data: &testType1Data)
        
        let data = type1.toData()
        XCTAssertEqual(data, expect1ByteBasicHeader.data)
        XCTAssertEqual(data.count, 1)
    }
    
    func testToData2Byte() {
        var testType2Data = expect2ByteBasicHeader.data
        let type2 = ChankBasicHeader.create(data: &testType2Data)
        let data = type2.toData()
        
        XCTAssertEqual(data, expect2ByteBasicHeader.data)
        XCTAssertEqual(data.count, 2)
    }
    
    func testToData3Byte() {
        var testType3Data = expect3ByteBasicHeader.data
        let type3 = ChankBasicHeader.create(data: &testType3Data)
        let data = type3.toData()
        
        XCTAssertEqual(data, expect3ByteBasicHeader.data)
        XCTAssertEqual(data.count, 3)
    }
}

