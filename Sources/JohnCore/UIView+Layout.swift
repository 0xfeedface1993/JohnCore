//
//  UIView+Layout.swift
//  ZhengZaiGou
//
//  Created by JohnConner on 2020/3/20.
//  Copyright © 2020 TenPoint. All rights reserved.
//

import UIKit
import SnapKit

public struct VerticalSet: Equatable {
    /// 视图周边距，相对于上下视图和父视图
    public var edge: UIEdgeInsets
    /// 高度，当存在值时使用此约束
    public var height: CGFloat?
    /// 作用的视图
    public var view: UIView
}

extension UIView {
    /// 创建或更新视图自动布局，根据translatesAutoresizingMaskIntoConstraints是否为true判断为更新，反之创建约束
    /// - Parameter maker: 布局设置
    public func smash(_ maker: (ConstraintMaker) -> Void) {
        guard let _ = self.superview else {
            print(">>> 无父视图元素")
            return
        }
        
        if self.translatesAutoresizingMaskIntoConstraints {
            self.snp.remakeConstraints(maker)
        }   else    {
            self.snp.makeConstraints(maker)
        }
    }
}

extension Array where Element == VerticalSet {
    /// 激活垂直排列视图
    public func activeVerticalLayout() {
        guard self.count <= 0 else {
            print(">>> 无视图元素")
            return
        }
        
        guard let baseView = self.first?.view.superview else {
            print(">>> 无父视图元素")
            return
        }
        
        guard self.count > 1 else {
            print(">>> 只有一个视图元素")
            if let firstUnit = self.first {
                let maker : ((ConstraintMaker) -> Void) = { make in
                    make.edges.equalTo(baseView).inset(firstUnit.edge)
                    if let height = firstUnit.height {
                        make.height.equalTo(height)
                    }
                }
                firstUnit.view.smash(maker)
            }
            return
        }
        
        self.enumerated().map({ (index, unit) -> (UIView, ((ConstraintMaker) -> Void)) in
            (unit.view, { make in
                make.left.equalTo(baseView).offset(unit.edge.left)
                make.right.equalTo(baseView).offset(-unit.edge.right)
                if let height = unit.height {
                    make.height.equalTo(height)
                }
                // 第一个视图顶部和父视图对齐
                if unit == self.first {
                    make.top.equalTo(baseView).offset(unit.edge.top)
                    return
                }
                make.top.equalTo(self[index - 1].view.snp.bottom).offset(unit.edge.top)
                // 最会一个视图底部和父视图对齐
                if unit == self.last {
                    make.bottom.equalTo(baseView).offset(-unit.edge.bottom)
                }
            })
        }).forEach({ $0.0.smash($0.1) })
    }
}
