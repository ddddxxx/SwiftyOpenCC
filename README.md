# SwiftyOpenCC

![platforms](https://img.shields.io/badge/platforms-macOS%20%7C%20iOS%20%7C%20tvOS-lightgrey.svg)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

Swift port of [OpenCC](https://github.com/BYVoid/OpenCC/tree/7fdaa43f1c548cc53ab9c7b59a697851060f4f46)

## Requirements

- macOS 10.9+ / iOS 8.0+ / tvOS 9.0+
- Xcode 8+
- Swift 3.0+

## Installation

### [Carthage](https://github.com/Carthage/Carthage)

<del>Add the project to your `Cartfile`:</del>

Carthage unable to build OpenCC submodule. I'm working on this.

<!--
```
github "XQS6LB3A/SwiftyOpenCC"
```
-->

### Manual

Download latest [release](https://github.com/XQS6LB3A/SwiftyOpenCC/releases), copy appropriate binary into your project.

## Usage

```swift
import OpenCC
```
```swift
let converter = OpenCCConverter(option: [.traditionalize])
converter.convert("忧郁的台湾乌龟")
// 憂鬱的臺灣烏龜
```

## License

SwiftyOpenCC is available under the MIT license. See the [LICENSE file](LICENSE).
