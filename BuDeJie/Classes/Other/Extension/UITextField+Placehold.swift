//
//  UITextField+Placehold.swift
//  BuDeJie
//
//  Created by he on 2017/8/5.
//  Copyright © 2017年 hezongjiang. All rights reserved.
//

import UIKit

extension UITextField {
    
    var palceholdColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, "pColor") as? UIColor
        }
        
        set {
            objc_setAssociatedObject(self, "pColor", newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            setValue(newValue, forKeyPath: "placeholderLabel.textColor")
        }
    }
    
}
