//import XCTest
//@testable import SwiftRTMPServer
//
//class testRTMPStreamHandler: XCTestCase {
//
//    let testData:[UInt8] = [
//        0x00,
//        0x03,
//        0x00,
//        0x00,
//        0x00,
//        0x00,
//        0x00,
//        0x8b,
//        0x14,
//        0x00,
//        0x00,
//        0x00,
//        0x00,
//        0x02,
//        0x00,
//        0x07,
//        0x63,
//        0x6f,
//        0x6e,
//        0x6e,
//        0x65,
//        0x63,
//        0x74,
//        0x00,
//        0x3f,
//        0xf0,
//        0x00,
//        0x00,
//        0x00,
//        0x00,
//        0x00,
//        0x00,
//        0x03,
//        0x00,
//        0x03,
//        0x61,
//        0x70,
//        0x70,
//        0x02,
//        0x00,
//        0x04,
//        0x6c,
//        0x69,
//        0x76,
//        0x65,
//        0x00,
//        0x04,
//        0x74,
//        0x79,
//        0x70,
//        0x65,
//        0x02,
//        0x00,
//        0x0a,
//        0x6e,
//        0x6f,
//        0x6e,
//        0x70,
//        0x72,
//        0x69,
//        0x76,
//        0x61,
//        0x74,
//        0x65,
//        0x00,
//        0x08,
//        0x66,
//        0x6c,
//        0x61,
//        0x73,
//        0x68,
//        0x56,
//        0x65,
//        0x72,
//        0x02,
//        0x00,
//        0x24,
//        0x46,
//        0x4d,
//        0x4c,
//        0x45,
//        0x2f,
//        0x33,
//        0x2e,
//        0x30,
//        0x20,
//        0x28,
//        0x63,
//        0x6f,
//        0x6d,
//        0x70,
//        0x61,
//        0x74,
//        0x69,
//        0x62,
//        0x6c,
//        0x65,
//        0x3b,
//        0x20,
//        0x4c,
//        0x61,
//        0x76,
//        0x66,
//        0x35,
//        0x39,
//        0x2e,
//        0x31,
//        0x36,
//        0x2e,
//        0x31,
//        0x30,
//        0x30,
//        0x29,
//        0x00,
//        0x05,
//        0x74,
//        0x63,
//        0x55,
//        0x72,
//        0x6c,
//        0x02,
//        0x00,
//        0x1a,
//        0x72,
//        0x74,
//        0x6d,
//        0x70,
//        0x3a,
//        0x2f,
//        0x2f,
//        0x6c,
//        0x6f,
//        0x63,
//        0x61,
//        0x6c,
//        0x68,
//        0x6f,
//        0x73,
//        0x74,
//        0x3a,
//        0x31,
//        0x39,
//        0x33,
//        0x35,
//        0x2f,
//        0x6c,
//        0x69,
//        0x76,
//        0x65,
//        0x00,
//        0x00,
//        0x09,
//    ]
//
//    override func setUpWithError() throws {
//    }
//
//    func testHandle() {
//
//        let data = Data(bytes: testData, count: testData.count)
//
////        let streamHandler = RTMPStreamHandler()
////
////        streamHandler.handle(data)
//        let messageData = Array(data[12..<data.count])
//        let message = String(data: messageData.data, encoding: .ascii)
//
//        XCTAssertEqual(data.count, 228)
//    }
//
//    func testGetFMT() {
//
//        let testVersion0: UInt8 = 0b00111111
//        let testVersion1: UInt8 = 0b01111111
//        let testVersion2: UInt8 = 0b10111111
//
//        let streamHandler = RTMPStreamHandler()
//
////        let v0 = streamHandler.getFMT(data: testVersion0.data)
////        let v1 = streamHandler.getFMT(data: testVersion1.data)
////        let v2 = streamHandler.getFMT(data: testVersion2.data)
////
////        XCTAssertEqual(v0, .type0)
////        XCTAssertEqual(v1, .type1)
////        XCTAssertEqual(v2, .type2)
//
//    }
//
//}
