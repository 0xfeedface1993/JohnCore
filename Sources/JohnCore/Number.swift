//
//  File.swift
//  
//
//  Created by JohnConner on 2020/3/20.
//

import Foundation

extension Float {
    /// 转化浮点型数字显示为更合适的范围
    /// 如 4.09999999 -> 5
    /// - Parameter fractionDigits: 显示最大小数点后面几位
    public func niceNumber(withFractionDigits fractionDigits: UInt) -> String {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal
//        formatter.maximumFractionDigits = Int(fractionDigits)
//        return formatter.string(from: self as NSNumber) ?? ""
        return "\(NSNumber(value: self))"
    }
}

extension Double {
    /// 转化浮点型数字显示为更合适的范围
    /// 如 4.09999999 -> 5
    /// - Parameter fractionDigits: 显示最大小数点后面几位
    public func niceNumber(withFractionDigits fractionDigits: UInt) -> String {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal
//        formatter.maximumFractionDigits = Int(fractionDigits)
//        return formatter.string(from: self as NSNumber) ?? ""
        return "\(NSNumber(value: self))"
    }
}
