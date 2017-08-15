//
//  SquareItemCell.swift
//  BuDeJie
//
//  Created by he on 2017/8/14.
//  Copyright © 2017年 hezongjiang. All rights reserved.
//

import UIKit
import Kingfisher

class SquareItemCell: UICollectionViewCell {

    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var square: SquareItem? {
        didSet {
            
            let url = URL(string: square?.icon ?? "")
            iconView.kf.setImage(with: url)
            
            titleLabel.text = square?.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = .white
    }

}
