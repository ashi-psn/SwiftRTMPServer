// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftRTMPServer",
    platforms: [
        .macOS(.v10_14)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SwiftRTMPServer",
            targets: ["SwiftRTMPServer"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.0.0"),
        .package(url: "https://github.com/ashi-psn/SwiftyBit", branch: "main")
    ],
    targets: [
        .target(
            name: "SwiftRTMPServer",
            dependencies: [
                .product(name: "SwiftyBit", package: "SwiftyBit"),
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio"),
                .product(name: "NIOHTTP1", package: "swift-nio")
            ]),
        .testTarget(
            name: "SwiftRTMPServerTests",
            dependencies: ["SwiftRTMPServer"]),
    ]
)
