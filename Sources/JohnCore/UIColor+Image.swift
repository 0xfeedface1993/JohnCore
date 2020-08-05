//
//  File.swift
//  
//
//  Created by JohnConner on 2020/8/5.
//

import UIKit

extension UIColor {
    /// 颜色转图片, 经常用于按钮背景绘制
    open var imageValue: UIImage? {
        return imageValue(with: CGSize(width: 1, height: 1))
    }
    
    open func imageValue(with size: CGSize) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(self.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 对当前颜色添加透明度
    /// - Parameter optical: 透明度
    /// - Returns: 包含透明度的新颜色
    open func optical(_ optical: CGFloat) -> UIColor {
        let alpha = (optical >= 0 && optical <= 1) ? optical:1.0
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        self.getRed(&red, green: &green, blue: &blue, alpha: nil)
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
