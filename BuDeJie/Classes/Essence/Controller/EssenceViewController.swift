//
//  EssenceViewController.swift
//  BuDeJie
//
//  Created by he on 2017/6/15.
//  Copyright © 2017年 hezongjiang. All rights reserved.
//

import UIKit

class EssenceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        // Do any additional setup after loading the view.
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: nil, imageName: "friendsRecommentIcon", heightImageName: "friendsRecommentIcon-click", target: self, action: #selector(game))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, imageName: "MainTagSubIcon", heightImageName: "MainTagSubIconClick", target: self, action: #selector(game))
        navigationItem.titleView = UIImageView(image: UIImage(named: "MainTitle"))
    }
    
    @objc private func game() {
        
    }
}
