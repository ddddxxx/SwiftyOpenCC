import Cocoa
import OpenCC

let str = "鼠标里面的硅二极管坏了，导致光标分辨率降低。"

let converter = ChineseConverter(option: [.traditionalize, .TWStandard, .TWIdiom])

print(converter.convert(str))
