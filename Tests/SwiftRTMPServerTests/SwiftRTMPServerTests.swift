import XCTest
@testable import SwiftRTMPServer

final class SwiftRTMPServerTests: XCTestCase {
    func testExample() throws {

//        let expectation = XCTestExpectation()

        let server = RTMPServer(configuration: RTMPConfiguration())
        server.listhen()
    }
}
