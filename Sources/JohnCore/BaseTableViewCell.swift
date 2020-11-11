//
//  BaseTableViewCell.swift
//  DropByApp-Shop
//
//  Created by mac on 2020/7/13.
//  Copyright © 2020 JohnConner. All rights reserved.
//

import UIKit

public class BaseTableViewCell: UITableViewCell {
    /// 顶部线条，默认隐藏
    public let topLine = UIView()
    /// 底部线条，默认隐藏
    public let bottomLine = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
        
        bottomLine.backgroundColor = UIColor.hexColor(0xcccccc, alpha: 0.6)
        topLine.backgroundColor = UIColor.hexColor(0xcccccc, alpha: 0.6)
        bottomLine.isHidden = true
        topLine.isHidden = true
        
        contentView.addSubview(topLine)
        contentView.addSubview(bottomLine)
        
        topLine.snp.makeConstraints({ make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(1)
        })
        
        bottomLine.snp.makeConstraints({ make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        })
    }
    
    public func setupCell() {
        print(">>> Subclass override this method!")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public protocol InnerCell {
    associatedtype View: UIView
    /// 内部视图容器，根据泛型指定你想要的最基础视图
    var innerView: View { get set }
    /// innerView距离cell的内边距
    func contentInsets() -> UIEdgeInsets
    /// 想做其他自定义初始化操作请重写此方法
    func setupCell()
}

public protocol CellIdentifier {
    static var identifier: String { get set }
}

public class UIInnerTableViewCell<View: UIView>: BaseTableViewCell, InnerCell {
    public var innerView: View = View(frame: .zero)
    
    public override func setupCell() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        contentView.addSubview(innerView)
        innerView.snp.makeConstraints({ make in
            make.edges.equalTo(contentView).inset(contentInsets())
        })
    }
    
    public func contentInsets() -> UIEdgeInsets {
        return .zero
    }
}

