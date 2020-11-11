//
//  UIView+Tap.swift
//  DropByApp
//
//  Created by JohnConner on 2020/7/6.
//  Copyright © 2020 JohnConner. All rights reserved.
//

import UIKit

extension UIView {
    // 定义手势和闭包关联的Key
    private struct AssociateKeys {
        static var gestureKey = "UIView+Extension+gestureKey"
        static var closureKey = "UIView+Extension+closureKey"
    }
    
    // 为view添加点击事件
    @discardableResult
    func onTap(_ closure: @escaping () -> ()) -> Self {
        var gesture = objc_getAssociatedObject(self, &AssociateKeys.gestureKey)
        if gesture == nil {
            gesture = UITapGestureRecognizer(target: self, action: #selector(handleActionForTapGesture(_:)))
            addGestureRecognizer(gesture as! UIGestureRecognizer)
            isUserInteractionEnabled = true
            objc_setAssociatedObject(self, &AssociateKeys.gestureKey, gesture, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
        objc_setAssociatedObject(self, &AssociateKeys.closureKey, closure, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        return self
    }
    
    // 点击手势实际调用的函数
    @objc private func handleActionForTapGesture(_ gesture: UITapGestureRecognizer) {
        if gesture.state == UIGestureRecognizer.State.recognized {
            let obj = objc_getAssociatedObject(self, &AssociateKeys.closureKey)
            if let action = obj as? ()->() {
                action()
            }
        }
    }
}

extension Array where Element == UIView {
    // 同时给多个view添加事件
    func onTap(_ closure: @escaping () -> ()) {
        forEach({ $0.onTap(closure) })
    }
}
