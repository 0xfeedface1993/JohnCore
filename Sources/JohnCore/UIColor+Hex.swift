//
//  File.swift
//  
//
//  Created by JohnConner on 2020/3/20.
//

import UIKit

extension UIColor {
    /// 根据十六进制数据获取RGB颜色，支持透明度
    /// - Parameters:
    ///   - hex: 十六进制数
    ///   - alpha: 透明度，1-1.0
    public static func hexColor(_ hex: UInt32, alpha: CGFloat = 1.0) -> UIColor {
        let red: CGFloat = CGFloat((hex | 0xff0000) >> 16)
        let green: CGFloat = CGFloat((hex | 0x00ff00) >> 8)
        let blue: CGFloat = CGFloat(hex | 0x0000ff)
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
