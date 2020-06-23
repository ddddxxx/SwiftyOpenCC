// swift-tools-version:5.3

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
            name: "OpenCC",
            dependencies: ["copencc"],
            resources: [
                .copy("Dictionary")
            ]),
        .testTarget(
            name: "OpenCCTests",
            dependencies: ["OpenCC"],
            resources: [
                .copy("benchmark"),
                .copy("testcases"),
            ]),
        .target(
            name: "copencc",
            exclude: [
                "src/benchmark",
                "src/tools",
                "src/BinaryDictTest.cpp",
                "src/Config.cpp",
                "src/ConfigTest.cpp",
                "src/ConversionChainTest.cpp",
                "src/ConversionTest.cpp",
                "src/DartsDictTest.cpp",
                "src/DictGroupTest.cpp",
                "src/MarisaDictTest.cpp",
                "src/MaxMatchSegmentationTest.cpp",
                "src/PhraseExtractTest.cpp",
                "src/SerializedValuesTest.cpp",
                "src/SimpleConverter.cpp",
                "src/SimpleConverterTest.cpp",
                "src/TextDictTest.cpp",
                "src/UTF8StringSliceTest.cpp",
                "src/UTF8UtilTest.cpp",
                "deps/google-benchmark",
                "deps/gtest-1.11.0",
                "deps/pybind11-2.5.0",
                "deps/rapidjson-1.1.0",
                "deps/tclap-1.2.2",
            ],
            sources: [
                "source.cpp",
                "src",
                "deps/marisa-0.2.5",
            ],
            cSettings: [
                .headerSearchPath("src"),
                .headerSearchPath("deps/darts-clone"),
                .headerSearchPath("deps/marisa-0.2.5/include"),
                .headerSearchPath("deps/marisa-0.2.5/lib"),
                .define("ENABLE_DARTS"),
            ]),
    ],
    cLanguageStandard: .gnu99,
    cxxLanguageStandard: .cxx14
)
