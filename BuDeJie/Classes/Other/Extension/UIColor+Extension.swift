//
//  UIColor+Extension.swift
//  BuDeJie
//
//  Created by he on 2017/8/14.
//  Copyright © 2017年 hezongjiang. All rights reserved.
//

import UIKit

extension UIColor {
    
    var randomColor: UIColor {
        let red = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
        let green = CGFloat( arc4random_uniform(255))/CGFloat(255.0)
        let blue = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    class func create(r: UInt8, g: UInt8, b: UInt8) -> UIColor {
        return self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1)
    }
}
