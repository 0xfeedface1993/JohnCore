//
//  File.swift
//  
//
//  Created by JohnConner on 2020/8/5.
//

import UIKit

extension UIButton {
    /// 设置按钮文本颜色
    /// - Parameter color: 文字颜色
    /// - Parameter state: 在按钮什么状态显示，默认为normal状态
    /// - Returns: UIButton自身对象
    @discardableResult
    func forgroundColor(_ color: UIColor, state: UIControl.State = .normal) -> UIButton {
        setTitleColor(color, for: state)
        return self
    }
    
    /// 设置按钮文本
    /// - Parameters:
    ///   - text: 文本
    ///   - state: 在按钮什么状态显示，默认为normal状态
    /// - Returns: UIButton自身对象
    @discardableResult
    func title(_ text: String, state: UIControl.State = .normal) -> UIButton {
        setTitle(text, for: state)
        return self
    }
    
    /// 设置按钮文字内容内边距
    /// - Parameter inset: 内边距
    /// - Returns: UIButton自身对象
    @discardableResult
    func contentInsets(_ inset: UIEdgeInsets) -> UIButton {
        contentEdgeInsets = inset
        return self
    }
    
    /// 设置按钮背景色，点击时有透明效果，可设置disable时的颜色
    /// - Parameter backgroundColor: 背景色
    /// - Parameter optical: highlighted状态下背景色的透明度
    /// - Parameter disableColor: disabled状态下背景色
    /// - Returns: UIButton自身对象
    @discardableResult
    func makeBackgroundColorImage(_ backgroundColor: UIColor, optical: CGFloat = 0.8, disableColor: UIColor = .hexColor(0xcccccc)) -> UIButton {
        setBackgroundImage(backgroundColor.imageValue, for: .normal)
        setBackgroundImage(backgroundColor.optical(optical).imageValue, for: .highlighted)
        setBackgroundImage(disableColor.imageValue, for: .disabled)
        return self
    }
    
    /// 设置按钮文本字体
    /// - Parameter font: 字体
    /// - Returns: UIButton自身对象
    @discardableResult
    func font(_ font: UIFont) -> UIButton {
        titleLabel?.font = font
        return self
    }
    
    /// 设置圆角，当圆角为nil时默认绘制1/2高度圆角
    /// - Parameter radius: 圆角半径
    /// - Returns: UIButton自身对象
    @discardableResult
    func cornerRadius(_ radius: CGFloat? = nil) -> UIButton {
        layer.cornerRadius = radius ?? (titleLabel?.font.lineHeight ?? 0 + contentEdgeInsets.top + contentEdgeInsets.bottom) / 2.0
        clipsToBounds = true
        return self
    }
}
