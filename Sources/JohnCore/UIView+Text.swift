//
//  File.swift
//  
//
//  Created by JohnConner on 2020/3/20.
//

import UIKit

extension String {
   
}

extension UIFont {
    /// 根据当前字体大小计算字符串的渲染大小，支持宽度限制
    /// - Parameters:
    ///   - string: 需要计算的文字
    ///   - width: 宽度限制
    public func recommandSize(string: String, constrainedToWidth width: Double) -> CGSize {
        let attributes = [NSAttributedString.Key.font:self]
        let attString = NSAttributedString(string: string, attributes: attributes)
        let framesetter = CTFramesetterCreateWithAttributedString(attString)
        return CTFramesetterSuggestFrameSizeWithConstraints(framesetter,
                                                            CFRange(location: 0,length: 0),
                                                            nil,
                                                            CGSize(width: width, height: Double.greatestFiniteMagnitude),
                                                            nil)
    }
}


