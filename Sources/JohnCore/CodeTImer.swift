//
//  File.swift
//  
//
//  Created by JohnConner on 2020/3/20.
//

import UIKit

public let CodeFetchTimeKey = "com.tp.code.fetch.time"

public protocol CodeFetchUpdator {
    var displayLink: CADisplayLink? { get set }
}

extension CodeFetchUpdator {
    /// 检测是否可以获取新的验证码，距离上次获取时间超过60s即可重新获取
    public func canFetchCode() -> (Bool, TimeInterval) {
        guard let date = UserDefaults.standard.object(forKey: CodeFetchTimeKey) as? Date else { return (true, 0) }
        let time = Date().timeIntervalSince(date)
        return (time > 60, 60 - time)
    }
    
    /// 保存当前获取验证码的时间
    public func tapCode() {
        UserDefaults.standard.set(Date(), forKey: CodeFetchTimeKey)
    }
}
