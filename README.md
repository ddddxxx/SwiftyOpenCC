# Swifty Open Chinese Convert

[![Build Status](https://travis-ci.org/XQS6LB3A/SwiftyOpenCC.svg?branch=master)](https://travis-ci.org/XQS6LB3A/SwiftyOpenCC)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg?)](https://github.com/Carthage/Carthage)
![platforms](https://img.shields.io/badge/platforms-macOS%20%7C%20iOS%20%7C%20tvOS-lightgrey.svg)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![codebeat badge](https://codebeat.co/badges/556efead-e22c-4804-b557-5036aa5c0209)](https://codebeat.co/projects/github-com-xqs6lb3a-swiftyopencc-master)

Swift port of [Open Chinese Convert](https://github.com/BYVoid/OpenCC/tree/7fdaa43f1c548cc53ab9c7b59a697851060f4f46)

## Requirements

- macOS 10.9+ / iOS 8.0+ / tvOS 9.0+
- Xcode 8+
- Swift 3.0+

## Installation

### [Carthage](https://github.com/Carthage/Carthage)

Add the project to your `Cartfile`:

```
github "XQS6LB3A/SwiftyOpenCC"
```

## Usage

### Quick Start

```swift
import OpenCC

let str = "鼠标里面的硅二极管坏了，导致光标分辨率降低。"
let converter = ChineseConverter(option: [.traditionalize, .TWStandard, .TWIdiom])
converter.convert("str")
// 滑鼠裡面的矽二極體壞了，導致游標解析度降低。
```

### Documentation

[Github Pages](http://XQS6LB3A.github.io/SwiftyOpenCC)

%100 Documented

## License

SwiftyOpenCC is available under the MIT license. See the [LICENSE file](LICENSE).
