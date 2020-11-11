//
//  Dictionary+Layout.swift
//  AiErXin
//
//  Created by JohnConner on 2020/6/10.
//  Copyright © 2020 冉茂兵. All rights reserved.
//

import UIKit

extension Dictionary where Key == String, Value == Any {
    /// 激活AutoLayout布局
    public func activeAutoLayout() {
        self.compactMap({ $0.value as? UIView }).forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
    }
}

extension Array where Element == NSLayoutConstraint {
    /// 激活约束
    public func activeAll() {
        NSLayoutConstraint.activate(self)
    }
}

extension String {
    /// 若字符串为空 则返回默认字符串 否则返回自身
    /// - Parameter defaultText: 默认字符串
    /// - Returns: 非空字符串
    public func noneEmptyStyle(defaultText: String) -> String {
        isEmpty ? defaultText:self
    }
}
