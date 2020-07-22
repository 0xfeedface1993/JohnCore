//
//  File.swift
//  
//
//  Created by JohnConner on 2020/3/20.
//

import UIKit
import SnapKit

public protocol BaseStackView {
    associatedtype StackValue: Equatable
    associatedtype UnitView: UIView
    /// 竖直、水平列表视图
    var stackView: UIStackView { get set }
    /// 重载列表视图，这里需提供数据和视图初始化配置操作
    /// - Parameters:
    ///   - values: 数据绑定列表
    ///   - config: 每个视图初始化配置操作
    func reloadStack(values: [StackValue], config: @escaping (UnitView, StackValue) -> Void)
}

/// 水平列表视图
public protocol HoriztalStackView: BaseStackView {
    
}

extension HoriztalStackView {
    public func reloadStack(values: [StackValue], config: @escaping (UnitView, StackValue) -> Void) {
        stackView.arrangedSubviews.enumerated().forEach({
            self.stackView.removeArrangedSubview($0.element)
            $0.element.removeFromSuperview()
        })

        for i in values {
            let item = UnitView(frame: .zero)
            config(item, i)
            if let v = stackView.arrangedSubviews.last {
                stackView.addArrangedSubview(item)
                item.snp.makeConstraints({ make in
                    make.height.equalTo(v)
                })
                continue
            }
            stackView.addArrangedSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}

/// 垂直列表视图
public protocol VerticalStackView: BaseStackView {
    
}

extension VerticalStackView {
    public func reloadStack(values: [StackValue], config: @escaping (UnitView, StackValue) -> Void) {
        stackView.arrangedSubviews.enumerated().forEach({
            self.stackView.removeArrangedSubview($0.element)
            $0.element.removeFromSuperview()
        })

        stackView.axis = .vertical
        
        for i in values {
            let item = UnitView(frame: .zero)
            config(item, i)
            stackView.addArrangedSubview(item)
            item.snp.makeConstraints({ make in
                make.width.equalTo(stackView)
            })
        }
    }
}
