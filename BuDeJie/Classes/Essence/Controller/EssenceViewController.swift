//
//  EssenceViewController.swift
//  BuDeJie
//
//  Created by he on 2017/6/15.
//  Copyright © 2017年 hezongjiang. All rights reserved.
//

import UIKit

class EssenceViewController: UIViewController {
    
    /// 每个标题的宽度
    fileprivate var titleLabelWidth: CGFloat = UIScreen.width / 5
    
    /// 标题栏
    fileprivate lazy var titlesView: UIScrollView = {
       
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 64, width: self.view.bounds.width, height: 35))
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = UIColor.create(r: 240, g: 240, b: 240).withAlphaComponent(0.9)
        return scrollView
    }()
    
    /// 下划线
    fileprivate lazy var titleUnderline: UIView = {
       
        let lineHeight: CGFloat = 2
        
        let line = UIView(frame: CGRect(x: 0, y: self.titlesView.bounds.height - lineHeight, width: self.titleLabelWidth, height: lineHeight))
        line.backgroundColor = UIColor.red
        return line
    }()
    
    /// 内容
    fileprivate lazy var contentsView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    /// scrollView是否正在滚动
    fileprivate var scrollViewIsScroll = false
    
    /// 当前选中的标题
    fileprivate var currentSelectdTitle: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        
        view.backgroundColor = UIColor.create(r: 240, g: 240, b: 240)
        
        setupNavigationBar()
        
        setupChildViewController()
        
        setupTitlesView()
        
        scrollViewDidEndDecelerating(contentsView)
    }
    
    @objc fileprivate func game() {
        
    }
    
    
}

// MARK: - 界面初始化设置
private extension EssenceViewController {
    
    func setupNavigationBar() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: nil, imageName: "friendsRecommentIcon", heightImageName: "friendsRecommentIcon-click", target: self, action: #selector(game))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, imageName: "MainTagSubIcon", heightImageName: "MainTagSubIconClick", target: self, action: #selector(game))
        navigationItem.titleView = UIImageView(image: UIImage(named: "MainTitle"))
    }
    
    func setupChildViewController() {
        
        let vc1 = AllViewController()
        vc1.title = "全部"
        addChildViewController(vc1)
        
        let vc2 = AllViewController()
        vc2.title = "视频"
        addChildViewController(vc2)
        
        let vc3 = AllViewController()
        vc3.title = "声音"
        addChildViewController(vc3)
        
        let vc4 = AllViewController()
        vc4.title = "图片"
        addChildViewController(vc4)
        
        let vc5 = AllViewController()
        vc5.title = "段子"
        addChildViewController(vc5)
    }
    
    func setupTitlesView() {
        
        view.addSubview(contentsView)
        
        view.addSubview(titlesView)
        
        let childVcCount = childViewControllers.count
        
        for i in 0..<childVcCount {
            
            let x = CGFloat(i) * titleLabelWidth
            
            let label = TitleLabel(frame: CGRect(x: x, y: 0, width: titleLabelWidth, height: titlesView.bounds.height))
            label.tag = i
            label.text = childViewControllers[i].title
            label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(titleClick(_:))))
            label.textColor = UIColor.black
            titlesView.addSubview(label)
            
            if i == 0 { label.scale = 1 }
        }
        
        titlesView.contentSize = CGSize(width: CGFloat(childVcCount) * titleLabelWidth, height: 0)
        contentsView.contentSize = CGSize(width: CGFloat(childVcCount) * contentsView.frame.width, height: 0)
        
        titlesView.addSubview(titleUnderline)
    }
    
    /// 监听标题点击
    @objc func titleClick(_ tap: UITapGestureRecognizer) {
        
        guard let index = tap.view?.tag, scrollViewIsScroll == false, tap.view != currentSelectdTitle else { return }
        
        contentsView.setContentOffset(CGPoint(x: contentsView.bounds.width * CGFloat(index), y: 0), animated: true)
        
        currentSelectdTitle = tap.view as? UILabel
    }
}

// MARK: - UIScrollViewDelegate
extension EssenceViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollViewIsScroll = true
        
        let scale = scrollView.contentOffset.x / scrollView.bounds.width
        
        if scale < 0 || scale > CGFloat(titlesView.subviews.count - 1) { return }
        
        titleUnderline.frame.origin.x = titleLabelWidth * scale
        
        let leftIdx = Int(scale)
        
        let rightIdx = leftIdx + 1
        // 左边label
        let leftLabele = titlesView.subviews[leftIdx] as? TitleLabel
        // 右边label
        let rightLable = (rightIdx >= titlesView.subviews.count) ? nil : (titlesView.subviews[rightIdx] as? TitleLabel)
        
        // 右边颜色比例
        let rightScale = scale - CGFloat(leftIdx)
        // 左边颜色比例
        let leftScale = 1 - rightScale
        
        leftLabele?.scale = leftScale
        rightLable?.scale = rightScale
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        scrollViewDidEndDecelerating(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewIsScroll = false
        
        if scrollView != contentsView { return }
        
        // 当前位置控制器索引
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        
        // 即将显示的控制器
        let willShowVC = childViewControllers[index]
        
        // 即将显示的控制器对应的标题
        let title = titlesView.subviews[index]
        
        for label in (titlesView.subviews as? [TitleLabel]) ?? [] {
            if label != title { label.scale = 0 }
        }
        
        // 标题居中显示
        var titleOffsetX = title.center.x - titlesView.bounds.width * 0.5
        
        // 标题超出边界处理
        if titleOffsetX < 0 { titleOffsetX = 0 }
        let maxOffsetX = titlesView.contentSize.width - titlesView.bounds.width
        if titleOffsetX > maxOffsetX { titleOffsetX = maxOffsetX }
        
        titlesView.setContentOffset(CGPoint(x: titleOffsetX, y: 0), animated: true)
        
        // 如果该控制器已经显示，直接返回
        if willShowVC.isViewLoaded { return }
        
        // 显示控制器
        willShowVC.view.frame = CGRect(x: scrollView.contentOffset.x, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        
        scrollView.addSubview(willShowVC.view)
    }
}
