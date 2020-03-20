//
//  File.swift
//  
//
//  Created by JohnConner on 2020/3/20.
//

import UIKit

public typealias PopBackBlock = (UIViewController) -> Void

/// 视图控制器-回调绑定缓存
var popBlockCache = [UIViewController:PopBackBlock]()

extension UIViewController {
    /// pop到当前页面时需要执行的回调，在viewDidApear后执行，若赋值nil则为清除操作
    public var rushPopCompletion: PopBackBlock? {
        get {
            popBlockCache[self]
        }
        
        set {
            guard let value = newValue else {
                popBlockCache.removeValue(forKey: self)
                return
            }
            
            popBlockCache[self] = value
        }
    }
}

extension UIViewController {
    public func popViewController(_ controllerType: UIViewController.Type, completion: PopBackBlock? = nil) {
        if let controller = self.navigationController?.viewControllers.filter({ $0.isKind(of: controllerType) }).last {
            if let com = completion {
                controller.rushPopCompletion = com
            }
            self.navigationController?.popToViewController(controller, animated: true)
            return
        }
        
        print(">>> 未找到视图栈中该控制器：\(controllerType)")
    }
    
    public var beforePopController: UIViewController? {
        guard let vcs = self.navigationController?.viewControllers, let index = vcs.firstIndex(of: self) else {
                print(">>> 当前页面不在视图栈内")
            return nil
        }
        guard index < vcs.count, index > 0 else {
            print(">>> 无法正确找到视图栈上一个页面, 默认返回第一个页面")
            return nil
        }
        return vcs[index - 1]
    }
}
