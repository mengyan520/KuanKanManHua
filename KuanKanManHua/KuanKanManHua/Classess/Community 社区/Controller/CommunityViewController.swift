//
//  CommunityViewController.swift
//  KuanKanManHua
//
//  Created by Youcai on 16/12/22.
//  Copyright © 2016年 mm. All rights reserved.

import UIKit
import MJRefresh
class CommunityViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         setTopView()
          topView.items = ["关注","广场"];
          topView.del = self
          topView.selectedSegmentIndex = 1
        view.addSubview(backscrollView)
        let vc = SquareViewController()
        addChildViewController(vc)
        vc.view.frame = CGRect.init(x: SCREEN_WIDTH, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64-49)
        backscrollView.addSubview(vc.view)
        backscrollView.setContentOffset(CGPoint.init(x: SCREEN_WIDTH, y: 0), animated: false)
       
        
        backscrollView.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - 网络请求
    func loadData()  {
       // tableView.mj_header.endRefreshing()
    }


    fileprivate lazy var backscrollView:UIScrollView = {
        let view = UIScrollView.init(frame: CGRect.init(x: 0, y:64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64-49))
        view.delegate = self
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.isPagingEnabled = true;
        view.bounces = false
        view.contentSize = CGSize.init(width: SCREEN_WIDTH * 2, height: 0)
        return view
    }()
    fileprivate lazy var tableView:CommunityTableView = {
        let view = CommunityTableView()
         view.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64-49)
        //let header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(self.loadData))
        
      //  view.mj_header = header
       
        return view
    }()
}
// MARK: - 代理方法/自定义方法
extension CommunityViewController:UIScrollViewDelegate,NavTopDel{
    func NavTopClick(sender: UISegmentedControl) {
        
        backscrollView.setContentOffset(CGPoint.init(x: SCREEN_WIDTH * CGFloat(sender.selectedSegmentIndex), y: 0), animated: true)
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let index = scrollView.contentOffset.x / scrollView.bounds.size.width
        topView.selectedSegmentIndex = Int(index)
        
        
    }
    
}
