//
//  AllViewController.swift
//  BuDeJie
//
//  Created by he on 2017/8/22.
//  Copyright © 2017年 hezongjiang. All rights reserved.
//

import UIKit

class AllViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        tableView.contentInset = UIEdgeInsets(top: 64 + 35, left: 0, bottom: tabBarController!.tabBar.bounds.height, right: 0)
//        tableView.contentOffset.x = 64 + 35
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 30
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = "\(indexPath)"

        return cell
    }
    
}
