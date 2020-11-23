//
//  BaseCollectionViewCell.swift
//  AiErXin
//
//  Created by JohnConner on 2020/7/20.
//  Copyright © 2020 tenpoint. All rights reserved.
//

import UIKit

open class BaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupCell() {
        print(">>> Subclass override this method!")
    }
}

open class UIInnerCollectionViewCell<View: UIView>: BaseCollectionViewCell, InnerCell {
    open var innerView: View = View(frame: .zero)
    
    open override func setupCell() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        contentView.addSubview(innerView)
        innerView.snp.makeConstraints({ make in
            make.edges.equalTo(contentView).inset(contentInsets())
        })
    }
    
    open func contentInsets() -> UIEdgeInsets {
        return .zero
    }
}
