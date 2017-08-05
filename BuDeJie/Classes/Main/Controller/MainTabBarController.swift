//
//  MainTabBarController.swift
//  BuDeJie
//
//  Created by he on 2017/6/15.
//  Copyright © 2017年 hezongjiang. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    let dict = [["title" : "精华", "image" : "essence", "clsName" : "EssenceViewController"],
                ["title" : "新帖", "image" : "new", "clsName" : "NewViewController"],
                ["clsName" : "UIViewController"],
                ["title" : "关注", "image" : "friendTrends", "clsName" : "FriendTrendViewController"],
                ["title" : "我", "image" : "me", "clsName" : "MeViewController"]]
    
    fileprivate lazy var publicBtn: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 49))
//        button.backgroundColor = UIColor.red
        button.setImage(UIImage(named: "tabBar_publish_icon"), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let item = UITabBarItem.appearance()
        
        item.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.black], for: .selected)
        
        setupChildController()
        
        publicBtn.center.x = tabBar.frame.width * 0.5
        tabBar.addSubview(publicBtn)
    }
    
    private func setupChildController() {
        
        for classInfo in dict {
            
            guard
                let title = classInfo["title"],
                let className = classInfo["clsName"],
                let image = classInfo["image"],
                let clsString = Bundle.main.infoDictionary?["CFBundleName"] as? String,
                let cls = NSClassFromString(clsString + "." + className) as? UIViewController.Type
            else {
                addChildViewController(UIViewController())
                continue
            }
            
            let vc = cls.init()
            vc.title = title
            vc.tabBarItem.image = UIImage(named: "tabBar_" + image + "_icon")
            vc.tabBarItem.selectedImage = UIImage(named: "tabBar_" + image + "_click_icon")
            
            let nav = MainNavigationController(rootViewController: vc)
            addChildViewController(nav)
        }
    }
}
