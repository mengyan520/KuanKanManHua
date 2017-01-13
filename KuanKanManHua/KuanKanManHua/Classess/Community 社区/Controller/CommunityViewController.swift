//
//  CommunityViewController.swift
//  KuanKanManHua
//
//  Created by Youcai on 16/12/22.
//  Copyright © 2016年 mm. All rights reserved.
// 关注 https://api.kkmh.com/v1/feeds/following/feed_lists?sa_event=eyJldmVudCI6IlJlYWRWQ29tbXVuaXR5IiwicHJvcGVydGllcyI6eyJUcmlnZ2VyUGFnZSI6IlZDb21tdW5pdHlQYWdlIiwiJG9zX3ZlcnNpb24iOiIxMC4yIiwiJG9zIjoiaU9TIiwiVkNvbW11bml0eVRhYk5hbWUiOiLlhbPms6giLCIkc2NyZWVuX2hlaWdodCI6MTMzNCwiJGNhcnJpZXIiOiLkuK3lm73np7vliqgiLCIkbGliIjoiaU9TLW5ldCIsIiRtb2RlbCI6ImlQaG9uZSIsIiRzY3JlZW5fd2lkdGgiOjc1MCwiJHdpZmkiOnRydWUsIiRhcHBfdmVyc2lvbiI6IjMuNi4zIiwiJG1hbnVmYWN0dXJlciI6IkFwcGxlIiwiJG5ldHdvcmtfdHlwZSI6IldJRkkiLCJhYnRlc3RfZ3JvdXAiOjcwLCJGcm9tVkNvbW11bml0eVRhYk5hbWUiOiLlhbPms6gifSwicHJvamVjdCI6Imt1YWlrYW5fYXBwIiwiZGlzdGluY3RfaWQiOiI0NjkzODUwIiwidGltZSI6MTQ4NDIwNTUzMTUwMiwidHlwZSI6InRyYWNrIn0%3D&since=0
//https://api.kkmh.com/v1/feeds/following/feed_lists?since=67468472808407040
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
