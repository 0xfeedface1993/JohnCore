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
    
    /// 查找当前视图控制器下最顶层的视图控制器，如果自己就是最顶层就返回自身
    ///
    /// 使用方法如下：
    ///
    /// ````
    /// extension AppDelegate {
    ///     // 查找顶层视图控制器，也就是当前显示的视图控制
    ///     var topViewController: UIViewController? {
    ///         guard let mainWindow = UIViewController().currentWindow else {
    ///             print(">>> 当前无激活window")
    ///             return nil
    ///         }
    ///
    ///         guard let rootViewController = mainWindow.rootViewController else {
    ///             print(">>> 当前激活window无rootViewController")
    ///             return nil
    ///         }
    ///
    ///         return rootViewController.catchViewController
    ///     }
    /// }
    /// ````
    public var catchViewController: UIViewController {
        if let navi = self as? UINavigationController {
            guard let top = navi.topViewController else {
                print(">>> \(self): 当前vc是UINavigationController，但是没有找到下一级，所以下一级视图控制器是自己")
                return navi
            }
            
            if let present = top.presentedViewController {
                return present.catchViewController
            }
            
            return top.catchViewController
        }
        
        if let tab = self as? UITabBarController {
            guard let selected = tab.selectedViewController else {
                print(">>> \(self): 当前vc是UITabBarController，但是没有找到下一级，所以下一级视图控制器是自己")
                return tab
            }
            
            return selected.catchViewController
        }
        
        if let present = presentedViewController {
            return present.catchViewController
        }
        
        print(">>> \(self): --- 找到最顶层控制器 ---")
        return self
    }
}
