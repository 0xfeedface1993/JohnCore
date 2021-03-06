# JohnCore

这是我常用的Swift扩展库，使用Swift 5.1编写，很多方法和业务逻辑是无较大关联的，比如判断字符串是不是有效手机号这种功能。

希望你喜欢这个扩展库，祝你好运！


## Navigate

- [UIColor](#UIColor)
- [Number](#Number)
  - [Double](#Number)
  - [Float](#Number)

## UIColor

颜色相关扩展，目前只有16进制颜色转换这一个功能，在`UIColor+Hex.swift`里面。

```swift
public static func hexColor(_ hex: UInt32, alpha: CGFloat = 1.0) -> UIColor
```

## Number

`Float`、`Double`数据转化成优雅的文本，比如数值`0.12000`转化为字符串`0.12`.

```swift
// fractionDigits暂时没有任何作用
public func niceNumber(withFractionDigits fractionDigits: UInt) -> String
```

## String Validation

手机号、邮箱验证

```swift
/// 检测字符串是否是手机号
public func isValidPhone() -> Bool
/// 检测字符串是否是邮箱
/// - Returns: true为是邮箱
public func isEmailAddress() -> Bool 
```

## UIButton

UIButton一般没有什么复杂的封装，为了提升SwiftUI语感和提升代码提示速度，因此此框架添加了链式语法的封装。

```swift
actionButton
    .title("确定")
    .forgroundColor(.white)
    .makeBackgroundColorImage(.hexColor(0x259AFA))
    .font(.systemFont(ofSize: 15, weight: .medium))
    .contentInsets(UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0))
    .cornerRadius(8)
```
