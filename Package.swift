// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftyOpenCC",
    platforms: [
        .macOS(.v10_10), .iOS(.v8), .tvOS(.v9),
    ],
    products: [
        .library(
            name: "SwiftyOpenCC",
            targets: ["SwiftyOpenCC"]),
    ],
    targets: [
        .target(
            name: "OpenCCBridge",
            dependencies: []),
        .target(
            name: "SwiftyOpenCC",
            dependencies: ["OpenCCBridge"]),
        .testTarget(
            name: "SwiftyOpenCCTests",
            dependencies: ["SwiftyOpenCC"]),
    ],
    cLanguageStandard: .gnu99,
    cxxLanguageStandard: .gnucxx11
)
