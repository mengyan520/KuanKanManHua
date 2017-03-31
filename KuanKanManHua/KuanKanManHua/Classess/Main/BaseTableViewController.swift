//
//  BaseTableViewController.swift
//  起点阅读
//
//  Created by Youcai on 16/9/22.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = WHITE_COLOR
        automaticallyAdjustsScrollViewInsets = false
        
        tableView.separatorStyle = .none
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "ic_discover_nav_search_normal"), style: .plain, target: self, action: nil)
        
    }
    func setNavTitle(titleString:String) {
        self.title = titleString;
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:WHITE_COLOR]
    }
    func setNavButton(right:String?,leftTile:String?,left:String?,target: Any?, action: Selector?) {
        if (left != nil)  {
            
            navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: left!), style: .plain, target: nil, action: nil)
        }else
            if (leftTile != nil) {
                navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: leftTile,style: .plain, target: target, action: action)
                navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName:WHITE_COLOR], for: .normal)
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: right!), style: .plain, target: target, action: action)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - 懒加载
    
}
