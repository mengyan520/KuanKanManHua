//
//  DiscoverViewController.swift
//  KuanKanManHua
//
//  Created by Youcai on 16/12/14.
//  Copyright © 2016年 mm. All rights reserved.
//https://api.kkmh.com/v1/topic_new/discovery_list

//https://api.kkmh.com/v1/topic_new/discovery_list?sa_event=eyJldmVudCI6IlJlYWRGaW5kUGFnZSIsInByb3BlcnRpZXMiOnsiVHJpZ2dlclBhZ2UiOiJGaW5kUGFnZSIsIiRvc192ZXJzaW9uIjoiMTAuMS4xIiwiJGNhcnJpZXIiOiLkuK3lm73np7vliqgiLCIkb3MiOiJpT1MiLCIkc2NyZWVuX2hlaWdodCI6MTMzNCwiJHNjcmVlbl93aWR0aCI6NzUwLCIkbW9kZWwiOiJpUGhvbmUiLCIkd2lmaSI6dHJ1ZSwiJGxpYiI6ImlPUy1uZXQiLCIkYXBwX3ZlcnNpb24iOiIzLjUuMSIsIiRtYW51ZmFjdHVyZXIiOiJBcHBsZSIsIiRuZXR3b3JrX3R5cGUiOiJXSUZJIiwiYWJ0ZXN0X2dyb3VwIjowLCJGaW5kVGFiTmFtZSI6IuaOqOiNkCJ9LCJwcm9qZWN0Ijoia3VhaWthbl9hcHAiLCJkaXN0aW5jdF9pZCI6Imk6M0Y0NDlEQjYtNTNGNS00OTNDLTlERTUtN0U3MUNGRDkzNkQ4IiwidGltZSI6MTQ4MTcxMjAxMTcyMiwidHlwZSI6InRyYWNrIn0%3D
//https://api.kkmh.com/v1/topic_new/discovery_list?sa_event=eyJldmVudCI6IlJlYWRGaW5kUGFnZSIsInByb3BlcnRpZXMiOnsiVHJpZ2dlclBhZ2UiOiJGaW5kUGFnZSIsIiRvc192ZXJzaW9uIjoiMTAuMS4xIiwiJGNhcnJpZXIiOiLkuK3lm73np7vliqgiLCIkb3MiOiJpT1MiLCIkc2NyZWVuX2hlaWdodCI6MTMzNCwiJHNjcmVlbl93aWR0aCI6NzUwLCIkbW9kZWwiOiJpUGhvbmUiLCIkd2lmaSI6dHJ1ZSwiJGxpYiI6ImlPUy1uZXQiLCIkYXBwX3ZlcnNpb24iOiIzLjUuMSIsIiRtYW51ZmFjdHVyZXIiOiJBcHBsZSIsIiRuZXR3b3JrX3R5cGUiOiJXSUZJIiwiYWJ0ZXN0X2dyb3VwIjowLCJGaW5kVGFiTmFtZSI6IuaOqOiNkCJ9LCJwcm9qZWN0Ijoia3VhaWthbl9hcHAiLCJkaXN0aW5jdF9pZCI6Imk6M0Y0NDlEQjYtNTNGNS00OTNDLTlERTUtN0U3MUNGRDkzNkQ4IiwidGltZSI6MTQ4MTcxMjAzMjYwOCwidHlwZSI6InRyYWNrIn0%3D
//https://api.kkmh.com/v1/topic_new/lists/get_by_tag?count=20&since=0&tag=0
//https://api.kkmh.com/v1/topic_new/lists/get_by_tag?count=20&since=0&tag=20
//https://api.kkmh.com/v1/topic_new/lists/get_by_tag?count=20&since=0&tag=36
//https://api.kkmh.com/v1/topic_new/lists/get_by_tag?count=20&since=0&tag=46
//https://api.kkmh.com/v1/topic_new/lists/get_by_tag?count=20&since=0&tag=24
//https://api.kkmh.com/v1/topic_new/lists/get_by_tag?count=20&since=0&tag=22
import UIKit
import MJRefresh
class DiscoverViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTopView()
        topView.items = ["推荐","分类"];
        topView.del = self
        view.addSubview(backscrollView)
        backscrollView.addSubview(RecommendView)
     //   backscrollView.addSubview(categoryView)
       let vc = CategoryViewController()
        addChildViewController(vc)
        vc.view.frame = CGRect.init(x: SCREEN_WIDTH, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64-49)
        backscrollView.addSubview(vc.view)
        loadData()
         NotificationCenter.default.addObserver(self, selector: #selector(DiscoverViewController.workDetail(noti:)), name: NSNotification.Name(rawValue: "wordDetail"), object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - 网络请求
    func loadData()  {
        
        NetworkTools.shardTools.requestL(method: .get, URLString: "https://api.kkmh.com/v1/topic_new/discovery_list", parameters: nil) { (response, error) in
            self.RecommendView.mj_header.endRefreshing()
            if error == nil {
                guard let object = response as? [String: AnyObject] else {
                    print("格式错误")
                    return
                }
                
                let model = Model.init(dict: object)
                self.RecommendView.dataArray = (model.data?.infos)!
                self.RecommendView.dataArray.remove(at: 0)
                self.RecommendView.reloadData()
                self.RecommendView.bannerArray = (model.data?.infos?[0].banners)!
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
    
    fileprivate lazy var RecommendView:RecommendTableView = {
        
        let tableView = RecommendTableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64-49), style: .grouped)
        
        let header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(DiscoverViewController.loadData))
        header?.ignoredScrollViewContentInsetTop = SCREEN_WIDTH/(1280/600);
        tableView.mj_header = header
        
        return tableView
        
        
    }()
    
}
// MARK: - 代理方法/自定义方法
extension DiscoverViewController:UIScrollViewDelegate,NavTopDel{
    func NavTopClick(sender: UISegmentedControl) {
        
        backscrollView.setContentOffset(CGPoint.init(x: SCREEN_WIDTH * CGFloat(sender.selectedSegmentIndex), y: 0), animated: true)
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let index = scrollView.contentOffset.x / scrollView.bounds.size.width
        topView.selectedSegmentIndex = Int(index)
        
        
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if scrollView == backscrollView {
            
            return
        }
        
        
    }
    // MARK: - 通知方法
    
     func workDetail(noti:NSNotification) {
        
       let data = noti.userInfo!["data"] as! Topics
       
        let controller = WordDetailViewController.init(ID:"\(data.target_id)")
        controller.hidesBottomBarWhenPushed = true
       
        navigationController?.pushViewController(controller, animated: true)
    }

    
}

