//
//  BaseViewController.swift
//  仿漫漫
//
//  Created by Youcai on 16/5/18.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WHITE_COLOR
        automaticallyAdjustsScrollViewInsets = false
        
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "ic_discover_nav_search_normal"), style: .plain, target: self, action: #selector(self.clickRightButton))
       

        }
    func setTopView()  {
        navigationItem.titleView = topView
       // navigationController?.navigationBar.addSubview(topView)
    }
    func clickRightButton() {
        let controller = SearchTableViewController()
        controller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(controller, animated: false)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - 懒加载
    lazy var topView:NavTopView = {
        let view = NavTopView.init()
        return view
    }()
    
    
}
