# JohnCore

这是我常用的Swift扩展库，使用Swift 5.1编写，很多方法和业务逻辑是无较大关联的，比如判断字符串是不是有效手机号这种功能。

希望你喜欢这个扩展库，祝你好运！


## Navigate

- [UIColor](#UIColor)

## UIColor

颜色相关扩展，目前只有16进制颜色转换这一个功能，在`UIColor+Hex.swift`里面。

```swift
public static func hexColor(_ hex: UInt32, alpha: CGFloat = 1.0) -> UIColor
```

