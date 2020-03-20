//
//  File.swift
//  
//
//  Created by JohnConner on 2020/3/20.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let pop = rushPopCompletion {
            pop(self)
            // 清除回调缓存操作
            rushPopCompletion = nil
        }
    }
}
