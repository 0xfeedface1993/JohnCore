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
    
    /// 字符串是否是合法的身份证号
    public var isValidIDCardNumber: Bool {
        // 判断是否为空
        guard count == 18 else { return false }
        
        // 判断是否是18位，末尾是否是x
        let regex2: String = "^(\\d{14}|\\d{17})(\\d|[xX])$"
        let identityCardPredicate = NSPredicate(format: "SELF MATCHES %@", regex2)
        guard identityCardPredicate.evaluate(with: self) else { return false }
        
        // 判断生日是否合法
        let datestr = String(self[index(startIndex, offsetBy: 6)..<index(startIndex, offsetBy: 14)])
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        guard let _ = formatter.date(from: datestr) else { return false }
        
        let idCardWi = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2]
        // 将前17位加权因子保存在数组里
        let idCardY = [1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2]
        // 这是除以11后，可能产生的11位余数、验证码，也保存成数组
        // 用来保存前17位各自乖以加权因子后的总和
        let values: [Int] = idCardWi.enumerated().map({
            let range = index(startIndex, offsetBy: $0.offset)..<index(startIndex, offsetBy: $0.offset + 1)
            return (Int(String(self[range])) ?? 0) * idCardWi[$0.offset]
        })
        let idCardWiSum = values.reduce(0) { $0 + $1 }
        let idCardMod = idCardWiSum % idCardY.count
        // 计算出校验码所在数组的位置
        let idCardLast = String(self[index(endIndex, offsetBy: -1)..<endIndex])
        // 得到最后一位身份证号码
        // 如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if idCardMod == 2 {
            return idCardLast == "X" || idCardLast == "x"
        }   else    {
            // 用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            guard let lastInt = Int(idCardLast) else { return false }
            return idCardY[idCardMod] == lastInt
        }
    }
}
