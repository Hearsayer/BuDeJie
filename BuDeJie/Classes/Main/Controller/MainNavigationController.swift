//
//  MainNavigationController.swift
//  BuDeJie
//
//  Created by he on 2017/6/15.
//  Copyright © 2017年 hezongjiang. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 自定义 NavigationController 会使边缘返回失效，重新设置 delegate 使其生效
        interactivePopGestureRecognizer?.delegate = self
        
        
    }
    
    /// 全屏手势返回
    private func fullScreenReturn() {
        
        let target = interactivePopGestureRecognizer?.delegate

        let pan = UIPanGestureRecognizer(target: target, action: Selector(("handleNavigationTransition:")))

        pan.delegate = self

        view.addGestureRecognizer(pan)

        interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if childViewControllers.count > 0 {
            
            viewController.hidesBottomBarWhenPushed = true
            
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.backItem(target: self, action: #selector(back))
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc private func back() {
        popViewController(animated: true)
    }

}

extension MainNavigationController: UIGestureRecognizerDelegate {
    
    // 如果写了 interactivePopGestureRecognizer?.delegate = self，则必须实现该代理，否则在根控制器滑动，会造成界面假死
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return childViewControllers.count > 1
    }
}
