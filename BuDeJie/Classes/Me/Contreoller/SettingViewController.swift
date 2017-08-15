//
//  SettingViewController.swift
//  BuDeJie
//
//  Created by he on 2017/7/26.
//  Copyright © 2017年 hezongjiang. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    
    fileprivate lazy var textField = UITextField(frame: CGRect(x: 100, y: 200, width: 100, height: 30))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        textField.placeholder = "123131231"
        textField.palceholdColor = UIColor.red
        view.addSubview(textField)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(textField.palceholdColor)
    }
}
