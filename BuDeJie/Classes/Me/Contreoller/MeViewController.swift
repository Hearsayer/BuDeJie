//
//  MeViewController.swift
//  BuDeJie
//
//  Created by he on 2017/6/15.
//  Copyright © 2017年 hezongjiang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import YYModel

fileprivate let cols: CGFloat = 4
fileprivate let margin: CGFloat = 1

class MeViewController: UIViewController {
    
    fileprivate lazy var dataSource = [SquareItem]()
    
    fileprivate lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
        let itemWH = (self.view.bounds.width - (cols - 1) * margin) / cols
        
        layout.itemSize = CGSize(width: itemWH, height: itemWH)
        layout.minimumLineSpacing = margin
        layout.minimumInteritemSpacing = margin
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.create(r: 240, g: 240, b: 240)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "SquareItemCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        return collectionView
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        
        let set = UIBarButtonItem(title: "", imageName: "mine-setting-icon", heightImageName: "mine-setting-icon-click", target: self, action: #selector(setting))
        let night = UIBarButtonItem(title: "  ", imageName: "mine-moon-icon", heightImageName: "mine-sun-icon-click", target: self, action: #selector(nightClick))
        
        navigationItem.rightBarButtonItems = [set, night]
        
        loadData()
    }
    
    private func loadData() {
        
        let parameters = ["a" : "square", "c" : "topic"]
        
        Alamofire.request("https://api.budejie.com/api/api_open.php", parameters: parameters).responseJSON { (response) in
            
            guard let value = response.result.value,
                let squareList = JSON(value)["square_list"].arrayObject,
                let items = NSArray.yy_modelArray(with: SquareItem.self, json: squareList) as? [SquareItem] else { return }
            
            self.dataSource = items
            self.collectionView.reloadData()
        }
    }
    
    @objc private func nightClick() {
        
    }
    
    @objc private func setting() {
     
        navigationController?.pushViewController(SettingViewController(), animated: true)
    }
}

extension MeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SquareItemCell
        cell.square = dataSource[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let urlString = dataSource[indexPath.row].url
        
        if !urlString.hasPrefix("http") { return }
        
        let vc = WebViewController()
        vc.urlString = urlString
        navigationController?.pushViewController(vc, animated: true)
    }
}
