//
//  File.swift
//  
//
//  Created by JohnConner on 2020/3/20.
//

import UIKit

extension UIImageView {
    /// 根据滚动视图下拉位移进行四周扩充、放大的动画，保证下拉时顶部不留空白
    /// - Parameter scrollView: 滚动视图
    public func scale(withScrollView scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        guard let size = self.image?.size else { return }
        let radio = size.width / size.height
        
        defer {
            self.superview?.layoutIfNeeded()
        }
        
        if y < 0 {
            let offset = y > 0 ? y:abs(y)
            let widthOffset = radio * offset
            let scale = CGAffineTransform(scaleX: 1 + widthOffset / size.width, y: 1 + offset / size.height)
            let tranlation = CGAffineTransform(translationX: 0, y: y)
            self.transform = scale.concatenating(tranlation)
            return
        }
        
        self.transform = CGAffineTransform.identity
    }
}
