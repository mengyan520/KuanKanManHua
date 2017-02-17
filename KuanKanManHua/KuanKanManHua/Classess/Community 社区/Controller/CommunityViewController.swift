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
    var since = 0
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
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadUser), name: NSNotification.Name.init(rawValue: "UserLogin"), object: nil)
        if MMUtils.userHasLogin() {
            backscrollView.addSubview(tableView)
            loadData()
            
        }else {
            backscrollView.addSubview(backLoginView)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - 网络请求
    //MARK: - 网络请求
    func loadData()  {
        
        MMUtils.showLoading()
        NetworkTools.shardTools.requestL(method: .get, URLString: "https://api.kkmh.com/v1/feeds/following/feed_lists?since=0", parameters: nil) { (response, error) in
            self.tableView.mj_header.endRefreshing()
           // print(response)
            MMUtils.hideLoading()
            if error == nil {
                guard let object = response as? [String: AnyObject] else {
                    print("格式错误")
                    return
                }
                 let model = Model.init(dict: object)
                if model.code == 200 {
                    self.tableView.dataArray = (model.data?.feeds)!
                    self.since = (model.data?.since)!
                    self.tableView.mj_footer.isHidden = false
                    self.tableView.reloadData()
                }

               
                
            }else {
                MMUtils.hideLoading()
                MMUtils.showError()
            }
        }
    }
    func loadMoreData()  {
       
        NetworkTools.shardTools.requestL(method: .get, URLString: "https://api.kkmh.com/v1/feeds/following/feed_lists?since=\(since)", parameters: nil) { (response, error) in
            self.tableView.mj_footer.endRefreshing()
            
            if error == nil {
                guard let object = response as? [String: AnyObject] else {
                    print("格式错误")
                    return
                }
                
                let model = Model.init(dict: object)
                self.tableView.dataArray =  (self.tableView.dataArray) + (model.data?.feeds)!
                
                self.since = (model.data?.since)!
                self.tableView.reloadData()
                
            }else {
               
                MMUtils.showError()
            }
        }
        
        
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
        let header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(self.loadData))
        
        view.mj_header = header
        let footer = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(self.loadMoreData))
        view.mj_footer = footer
        view.mj_footer.isHidden = true
        view.del = self
        return view
    }()
    fileprivate lazy var backLoginView:BackLoginView = {
        let view = BackLoginView.init(frame: CGRect.init(x: 0, y:0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-49-64))
        
        return view
    }()
}
// MARK: - 代理方法/自定义方法
extension CommunityViewController:UIScrollViewDelegate,NavTopDel,CommunityTableViewDel{
    func NavTopClick(sender: UISegmentedControl) {
        
        backscrollView.setContentOffset(CGPoint.init(x: SCREEN_WIDTH * CGFloat(sender.selectedSegmentIndex), y: 0), animated: true)
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let index = scrollView.contentOffset.x / scrollView.bounds.size.width
        topView.selectedSegmentIndex = Int(index)
        
        
    }
    func didSelectRowAtIndex(data: Feeds) {
        let controller = CommunityDetailController()
        
        
        controller.height = data.rowHeight
        
        controller.dataArray.append([data])
        controller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(controller, animated: true)
        
    }
    func reloadUser() {
        
        if tableView.dataArray.count == 0 {
            backLoginView.removeFromSuperview()
            backscrollView.addSubview(tableView)
            loadData()
        }else {
            tableView.removeFromSuperview()
            tableView.dataArray.removeAll()
            tableView.reloadData()
            backscrollView.insertSubview(backLoginView, at: 0)
        }
    }
}
