// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftyOpenCC",
    products: [
        .library(
            name: "OpenCC",
            targets: ["OpenCC"]),
    ],
    targets: [
        .target(
            name: "OpenCCBridge",
            dependencies: []),
        .target(
            name: "OpenCC",
            dependencies: ["OpenCCBridge"]),
        .testTarget(
            name: "OpenCCTests",
            dependencies: ["OpenCC"]),
    ],
    cLanguageStandard: .gnu99,
    cxxLanguageStandard: .gnucxx11
)
