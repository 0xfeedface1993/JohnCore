//
//  File.swift
//  
//
//  Created by JohnConner on 2020/3/20.
//

import Foundation

extension String {
    /// 检测字符串是否是手机号
    public func isValidPhone() -> Bool {
        let sets = CharacterSet.decimalDigits
        if let result = self.rangeOfCharacter(from: sets.inverted) {
            print(">>> 非法字符：\(self[result])")
            return false
        }
        return self.count == 11
    }
    
    /// 检测字符串是否是邮箱
    /// - Returns: true为是邮箱
    public func isEmailAddress() -> Bool {
        let expression = try! NSRegularExpression(pattern: "^[A-Za-z0-9\\u4e00-\\u9fa5]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$", options: .caseInsensitive)
        let nsText = self as NSString
        let range = NSRange(location: 0, length: nsText.length)
        guard let result = expression.firstMatch(in: self, options: .reportCompletion, range: range) else {
            print(">>> 非邮箱： \(self)")
            return false
        }
        print(">>> email: \(nsText.substring(with: result.range))")
        return true
    }
}
