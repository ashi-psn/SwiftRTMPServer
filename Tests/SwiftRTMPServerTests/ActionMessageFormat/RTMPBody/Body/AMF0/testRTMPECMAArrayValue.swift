import XCTest
@testable import SwiftRTMPServer

class testRTMPECMAArrayValue: XCTestCase {
    
    let expectByte: [UInt8] = [
        0x08,
        0x00,
        0x00,
        0x00,
        0x0b,
        0x00,
        0x08,
        0x64,
        0x75,
        0x72,
        0x61,
        0x74,
        0x69,
        0x6f,
        0x6e,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x05,
        0x77,
        0x69,
        0x64,
        0x74,
        0x68,
        0x00,
        0x40,
        0x9e,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x06,
        0x68,
        0x65,
        0x69,
        0x67,
        0x68,
        0x74,
        0x00,
        0x40,
        0x90,
        0xe0,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x0d,
        0x76,
        0x69,
        0x64,
        0x65,
        0x6f,
        0x64,
        0x61,
        0x74,
        0x61,
        0x72,
        0x61,
        0x74,
        0x65,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x09,
        0x66,
        0x72,
        0x61,
        0x6d,
        0x65,
        0x72,
        0x61,
        0x74,
        0x65,
        0x00,
        0x40,
        0x4d,
        0xf8,
        0x53,
        0xe2,
        0x55,
        0x6b,
        0x28,
        0x00,
        0x0c,
        0x76,
        0x69,
        0x64,
        0x65,
        0x6f,
        0x63,
        0x6f,
        0x64,
        0x65,
        0x63,
        0x69,
        0x64,
        0x00,
        0x40,
        0x1c,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x0b,
        0x6d,
        0x61,
        0x6a,
        0x6f,
        0x72,
        0x5f,
        0x62,
        0x72,
        0x61,
        0x6e,
        0x64,
        0x02,
        0x00,
        0x04,
        0x6d,
        0x70,
        0x34,
        0x32,
        0x00,
        0x0d,
        0x6d,
        0x69,
        0x6e,
        0x6f,
        0x72,
        0x5f,
        0x76,
        0x65,
        0x72,
        0x73,
        0x69,
        0x6f,
        0x6e,
        0x02,
        0x00,
        0x01,
        0x30,
        0x00,
        0x11,
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
        0x5f,
        0x62,
        0x72,
        0x61,
        0x6e,
        0x64,
        0x73,
        0x02,
        0x00,
        0x08,
        0x6d,
        0x70,
        0x34,
        0x32,
        0x6d,
        0x70,
        0x34,
        0x31,
        0x00,
        0x07,
        0x65,
        0x6e,
        0x63,
        0x6f,
        0x64,
        0x65,
        0x72,
        0x02,
        0x00,
        0x0d,
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
        0x00,
        0x08,
        0x66,
        0x69,
        0x6c,
        0x65,
        0x73,
        0x69,
        0x7a,
        0x65,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x09
    ]

    override func setUpWithError() throws {
    }
    
    func testToData() {
        
        let expectData = Data(bytes: expectByte, count: expectByte.count)
        
        let value = RTMPECMAArrayValue(value: [
            RTMPObjectPropertyValue(name: "duration", value: RTMPNumberValue(value: 0)),
            RTMPObjectPropertyValue(name: "width", value: RTMPNumberValue(value: 1920)),
            RTMPObjectPropertyValue(name: "height", value: RTMPNumberValue(value: 1080)),
            RTMPObjectPropertyValue(name: "videodatarate", value: RTMPNumberValue(value: 0)),
            RTMPObjectPropertyValue(name: "framerate", value: RTMPNumberValue(value: 59.94005994005994)),
            RTMPObjectPropertyValue(name: "videocodecid", value: RTMPNumberValue(value: 7)),
            RTMPObjectPropertyValue(name: "major_brand", value: RTMPStringValue(value: "mp42")),
            RTMPObjectPropertyValue(name: "minor_version", value: RTMPStringValue(value: "0")),
            RTMPObjectPropertyValue(name: "compatible_brands", value: RTMPStringValue(value: "mp42mp41")),
            RTMPObjectPropertyValue(name: "encoder", value: RTMPStringValue(value: "Lavf59.16.100")),
            RTMPObjectPropertyValue(name: "filesize", value: RTMPNumberValue(value: 0))
        ])
        let data = value.toData()
        
        XCTAssertEqual(data, expectData)
    }
    
    func testCreate() {
        var expectData = Data(bytes: expectByte, count: expectByte.count)
        
        let value = RTMPECMAArrayValue.create(data: &expectData)
        XCTAssertEqual(value.markerData, AMF0Marker.ecmaArray.data)
        
        
        for i in 0..<value.value.count {
            let property = value.value[i]
            
            switch i {
            case 0:
                XCTAssertEqual(property.name, "duration")
                XCTAssertEqual((property.value as! RTMPNumberValue).value, 0)
                
            case 1:
                XCTAssertEqual(property.name, "width")
                XCTAssertEqual((property.value as! RTMPNumberValue).value, 1920)
                
            case 2:
                XCTAssertEqual(property.name, "height")
                XCTAssertEqual((property.value as! RTMPNumberValue).value, 1080)
                
                
            case 3:
                XCTAssertEqual(property.name, "videodatarate")
                XCTAssertEqual((property.value as! RTMPNumberValue).value, 0)
                
            case 4:
                XCTAssertEqual(property.name, "framerate")
                XCTAssertEqual((property.value as! RTMPNumberValue).value, 59.94005994005994)
                
            case 5:
                XCTAssertEqual(property.name, "videocodecid")
                XCTAssertEqual((property.value as! RTMPNumberValue).value, 7)
                
            case 6:
                XCTAssertEqual(property.name, "major_brand")
                XCTAssertEqual((property.value as! RTMPStringValue).value, "mp42")
                
            case 7:
                XCTAssertEqual(property.name, "minor_version")
                XCTAssertEqual((property.value as! RTMPStringValue).value, "0")
                
            case 8:
                XCTAssertEqual(property.name, "compatible_brands")
                XCTAssertEqual((property.value as! RTMPStringValue).value, "mp42mp41")
                
            case 9:
                XCTAssertEqual(property.name, "encoder")
                XCTAssertEqual((property.value as! RTMPStringValue).value, "Lavf59.16.100")
                
            case 10:
                XCTAssertEqual(property.name, "filesize")
                XCTAssertEqual((property.value as! RTMPNumberValue).value, 0)
                
                
            default:
                print()
            }
        }
    }
}
