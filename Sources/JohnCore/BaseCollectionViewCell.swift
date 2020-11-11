//
//  BaseCollectionViewCell.swift
//  AiErXin
//
//  Created by JohnConner on 2020/7/20.
//  Copyright © 2020 tenpoint. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        print(">>> Subclass override this method!")
    }
}

class UIInnerCollectionViewCell<View: UIView>: BaseCollectionViewCell, InnerCell {
    var innerView: View = View(frame: .zero)
    
    override func setupCell() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        contentView.addSubview(innerView)
        innerView.snp.makeConstraints({ make in
            make.edges.equalTo(contentView).inset(contentInsets())
        })
    }
    
    func contentInsets() -> UIEdgeInsets {
        return .zero
    }
}
