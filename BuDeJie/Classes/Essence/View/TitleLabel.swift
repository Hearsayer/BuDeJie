//
//  TitleLabel.swift
//  BuDeJie
//
//  Created by he on 2017/8/16.
//  Copyright © 2017年 hezongjiang. All rights reserved.
//

import UIKit

private let selectedRed: CGFloat   = 0.88
private let selectedGreen: CGFloat = 0.188
private let selectedBlue: CGFloat  = 0.14

private let normalRed: CGFloat   = 0.2
private let normalGreen: CGFloat = 0.2
private let normalBlue: CGFloat  = 0.2

class TitleLabel: UILabel {
    
    /// 标题颜色
    var titleColor: UIColor = UIColor.black
    
    /// 根据比例，改变label颜色和大小
    var scale: CGFloat = 0 {
        
        didSet {
            
            let red = normalRed + (selectedRed - normalRed) * scale
            let green = normalGreen + (selectedGreen - normalGreen) * scale
            let blue = normalBlue + (selectedBlue - normalBlue) * scale
            textColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textAlignment = .center
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
