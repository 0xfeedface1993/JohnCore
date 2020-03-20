//
//  File.swift
//  
//
//  Created by JohnConner on 2020/3/20.
//

import Foundation

/// 遵循此协议说明可进行参数化，用于HTTP请求参数构建
public protocol ParamsValue {
    /// 返回组装后的参数字符串，比如对于String类型的值则拼出 "type=1"
    /// - Parameter key: 参数名
    func paramsText(key: String) -> String?
}

/// 接口顶层参数需遵循此协议，目前支持[String:String]、[String:[String]]两种参数格式
/// 当构建报文时， 调用 httpBodyText() 即可获得post报文文本，或get请求请求?后面的字符串
public protocol Aris {
    func httpBodyText() -> String?
}

extension String: ParamsValue {
    public func paramsText(key: String) -> String? {
        return "\(key)=\(self)"
    }
}

extension Array: ParamsValue where Element == String {
    public func paramsText(key: String) -> String? {
        return self.map({ "\(key)=\($0)" }).joined(separator: "&")
    }
}

extension Dictionary: Aris where Key == String, Value : Any {
    public func httpBodyText() -> String? {
        return self.compactMap({ item in
            guard let obj = item.value as? ParamsValue else {
                return nil
            }
            return obj.paramsText(key: item.key)
        }).joined(separator: "&")
    }
}
