//
//  File.swift
//  
//
//  Created by JohnConner on 2020/3/20.
//

import UIKit

extension UIView {
    /// 添加圆角layer配置
    /// - Parameter radius: 圆角半径
    public func roundBoarder(radius: CGFloat) {
        self.backgroundColor = .clear
        self.layer.cornerRadius = radius
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.hexColor(0x666666).cgColor
        clipsToBounds = true
    }
    
    /// 为视图添加虚线边框
    /// - Parameters:
    ///   - width: 虚线宽度
    ///   - cornerRadius: 虚线圆角
    public func makeDashBarder(width: CGFloat, cornerRadius: CGFloat) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.strokeColor = UIColor.hexColor(0x999999).cgColor
        shapeLayer.lineWidth = width
        shapeLayer.lineCap = .round
        shapeLayer.lineDashPattern = [NSNumber(value: 4), NSNumber(value: 2)]
        
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        shapeLayer.path = path.cgPath
        
        layer.addSublayer(shapeLayer)
    }
}
