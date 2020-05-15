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
            name: "copencc",
            exclude: [
                "upstream/src/benchmark",
                "upstream/src/tools",
                "upstream/src/BinaryDictTest.cpp",
                "upstream/src/Config.cpp",
                "upstream/src/ConfigTest.cpp",
                "upstream/src/ConversionChainTest.cpp",
                "upstream/src/ConversionTest.cpp",
                "upstream/src/DartsDictTest.cpp",
                "upstream/src/DictGroupTest.cpp",
                "upstream/src/MarisaDictTest.cpp",
                "upstream/src/MaxMatchSegmentationTest.cpp",
                "upstream/src/PhraseExtractTest.cpp",
                "upstream/src/SerializedValuesTest.cpp",
                "upstream/src/SimpleConverter.cpp",
                "upstream/src/SimpleConverterTest.cpp",
                "upstream/src/TextDictTest.cpp",
                "upstream/src/UTF8StringSliceTest.cpp",
                "upstream/src/UTF8UtilTest.cpp",
            ],
            sources: [
                "upstream/src",
                "upstream/deps/marisa-0.2.5/lib",
                "source.cpp",
            ],
            cSettings: [
                .headerSearchPath("upstream/src"),
                .headerSearchPath("upstream/deps/darts-clone"),
                .headerSearchPath("upstream/deps/marisa-0.2.5/include"),
                .headerSearchPath("upstream/deps/marisa-0.2.5/lib"),
                .define("ENABLE_DARTS"),
            ]),
        .target(
            name: "OpenCC",
            dependencies: ["copencc"]),
        .testTarget(
            name: "OpenCCTests",
            dependencies: ["OpenCC"]),
    ],
    cLanguageStandard: .gnu99,
    cxxLanguageStandard: .gnucxx11
)
