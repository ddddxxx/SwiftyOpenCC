import Cocoa
import OpenCC

let str = "忧郁的台湾乌龟"

let converter = OpenCCConverter(option: [.traditionalize])

converter.convert(str)
