//
//  WebViewController.swift
//  BuDeJie
//
//  Created by he on 2017/8/14.
//  Copyright © 2017年 hezongjiang. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var urlString = ""
    
    fileprivate lazy var webView = WKWebView()
    
    fileprivate lazy var progress = UIProgressView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupui()
        
        guard let url = URL(string: urlString) else { return }
        
        webView.load(URLRequest(url: url))
    }
    
    private func setupui() {
        
        webView.frame = view.bounds
        view.addSubview(webView)
        
        progress.frame = CGRect(x: 0, y: 64, width: view.bounds.width, height: 2)
        view.addSubview(progress)
        
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        let estimatedProgress = webView.estimatedProgress
        progress.progress = Float(estimatedProgress)
        progress.isHidden = estimatedProgress >= 1
        
        title = webView.title
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        webView.removeObserver(self, forKeyPath: "title")
    }
}
