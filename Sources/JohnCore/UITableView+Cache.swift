//
//  UITableView+Cache.swift
//  DropByApp
//
//  Created by JohnConner on 2020/7/11.
//  Copyright © 2020 JohnConner. All rights reserved.
//

import UIKit

protocol HeightCache {
    /// 缓存高度集合，根据cell位置缓存
    var heightCaches: [IndexPath:CGFloat] { get set }
}
