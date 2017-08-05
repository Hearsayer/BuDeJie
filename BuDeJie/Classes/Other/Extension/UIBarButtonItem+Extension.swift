//
//  UIBarButtonItem+Extension.swift
//  BuDeJie
//
//  Created by he on 2017/6/16.
//  Copyright © 2017年 hezongjiang. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init(title: String?, imageName: String, heightImageName: String, target: Any?, action: Selector) {
        
        let button = UIButton()
        
        button.setTitle(title, for: .normal)
        
        button.setImage(UIImage(named: imageName), for: .normal)
        
        button.setImage(UIImage(named: heightImageName), for: .highlighted)
        
        button.addTarget(target, action: action, for: .touchUpInside)
        
        button.sizeToFit()
        
        self.init(customView: button)
    }
    
    class func backItem(target: Any?, action: Selector) -> UIBarButtonItem {
        
        let button = UIButton()
        
        button.setTitle("返回", for: .normal)
        
        button.setTitleColor(.red, for: .highlighted)
        button.setTitleColor(.darkGray, for: .normal)
        
        button.setImage(UIImage(named: ""), for: .normal)
        button.setImage(UIImage(named: ""), for: .highlighted)
        
        button.addTarget(target, action: action, for: .touchUpInside)
        
        button.sizeToFit()
        
        button.contentEdgeInsets.left = -10
        
        return UIBarButtonItem(customView: button)
    }
    
}
