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
}
