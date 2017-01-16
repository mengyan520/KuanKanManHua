//
//  FollowingViewController.swift
//  KuanKanManHua
//
//  Created by Youcai on 17/1/16.
//  Copyright © 2017年 mm. All rights reserved.
//我的关注
//https://api.kkmh.com/v1/fav/topics?limit=20&offset=0&sa_event=eyJldmVudCI6IlJlYWRNeUZhdlRvcGljIiwicHJvcGVydGllcyI6eyJUcmlnZ2VyUGFnZSI6Ik15SG9tZVBhZ2UiLCIkb3NfdmVyc2lvbiI6IjEwLjIiLCIkY2FycmllciI6IuS4reWbveenu-WKqCIsIiRvcyI6ImlPUyIsIiRzY3JlZW5faGVpZ2h0IjoxMzM0LCIkc2NyZWVuX3dpZHRoIjo3NTAsIiRtb2RlbCI6ImlQaG9uZSIsIkZhdlRhYk5hbWUiOiLkvZzlk4EiLCIkd2lmaSI6dHJ1ZSwiJGFwcF92ZXJzaW9uIjoiMy43LjAiLCIkbWFudWZhY3R1cmVyIjoiQXBwbGUiLCIkbGliIjoiaU9TLW5ldCIsIiRuZXR3b3JrX3R5cGUiOiJXSUZJIiwiYWJ0ZXN0X2dyb3VwIjo3MH0sInByb2plY3QiOiJrdWFpa2FuX2FwcCIsImRpc3RpbmN0X2lkIjoiNDY5Mzg1MCIsInRpbWUiOjE0ODQ1NTE3ODY2MzAsInR5cGUiOiJ0cmFjayJ9 //作品
//https://api.kkmh.com/v1/feeds/following_author_list?sa_event=eyJldmVudCI6IlJlYWRNeUZhdlRvcGljIiwicHJvcGVydGllcyI6eyJUcmlnZ2VyUGFnZSI6Ik15SG9tZVBhZ2UiLCIkb3NfdmVyc2lvbiI6IjEwLjIiLCIkY2FycmllciI6IuS4reWbveenu-WKqCIsIiRvcyI6ImlPUyIsIiRzY3JlZW5faGVpZ2h0IjoxMzM0LCIkc2NyZWVuX3dpZHRoIjo3NTAsIiRtb2RlbCI6ImlQaG9uZSIsIkZhdlRhYk5hbWUiOiLkvZzlk4EiLCIkd2lmaSI6dHJ1ZSwiJGFwcF92ZXJzaW9uIjoiMy43LjAiLCIkbWFudWZhY3R1cmVyIjoiQXBwbGUiLCIkbGliIjoiaU9TLW5ldCIsIiRuZXR3b3JrX3R5cGUiOiJXSUZJIiwiYWJ0ZXN0X2dyb3VwIjo3MH0sInByb2plY3QiOiJrdWFpa2FuX2FwcCIsImRpc3RpbmN0X2lkIjoiNDY5Mzg1MCIsInRpbWUiOjE0ODQ1NTE3ODY2NTcsInR5cGUiOiJ0cmFjayJ9&since=0&uid=4693850 // 作者

import UIKit
import MJRefresh
class FollowingViewController: BaseViewController {
    var since = 0
    
    var currentTableView:CommunityTableView?
    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "我的关注"
        view.addSubview(scrollView)
        view.addSubview(Titleview)
        let Tableview = CommunityTableView()
        Tableview.tag = 100
        refresh(tableView: Tableview)
        
        
        let vcW = scrollView.frame.size.width
        let vcH = scrollView.frame.size.height
        
        Tableview.frame =  CGRect.init(x: 0 , y: 0, width: vcW, height: vcH)
        
        scrollView.addSubview(Tableview)
        loadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
         navigationItem.rightBarButtonItem = UIBarButtonItem()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func refresh(tableView:CommunityTableView) {
        let header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(self.loadData))
        
        tableView.mj_header = header
        let footer = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(self.loadMoreData))
        tableView.mj_footer = footer
        tableView.mj_footer.isHidden = true
        tableView.del = self
        currentTableView = tableView
    }
    //MARK: - 网络请求
    func loadData()  {
        var url = "https://api.kkmh.com/v1/fav/topics?limit=20&offset=0&sa_event=eyJldmVudCI6IlJlYWRNeUZhdlRvcGljIiwicHJvcGVydGllcyI6eyJUcmlnZ2VyUGFnZSI6Ik15SG9tZVBhZ2UiLCIkb3NfdmVyc2lvbiI6IjEwLjIiLCIkY2FycmllciI6IuS4reWbveenu-WKqCIsIiRvcyI6ImlPUyIsIiRzY3JlZW5faGVpZ2h0IjoxMzM0LCIkc2NyZWVuX3dpZHRoIjo3NTAsIiRtb2RlbCI6ImlQaG9uZSIsIkZhdlRhYk5hbWUiOiLkvZzlk4EiLCIkd2lmaSI6dHJ1ZSwiJGFwcF92ZXJzaW9uIjoiMy43LjAiLCIkbWFudWZhY3R1cmVyIjoiQXBwbGUiLCIkbGliIjoiaU9TLW5ldCIsIiRuZXR3b3JrX3R5cGUiOiJXSUZJIiwiYWJ0ZXN0X2dyb3VwIjo3MH0sInByb2plY3QiOiJrdWFpa2FuX2FwcCIsImRpc3RpbmN0X2lkIjoiNDY5Mzg1MCIsInRpbWUiOjE0ODQ1NTE3ODY2MzAsInR5cGUiOiJ0cmFjayJ9"
        if self.currentTableView?.tag != 100 {
            url = "https://api.kkmh.com/v1/feeds/following_author_list?sa_event=eyJldmVudCI6IlJlYWRNeUZhdlRvcGljIiwicHJvcGVydGllcyI6eyJUcmlnZ2VyUGFnZSI6Ik15SG9tZVBhZ2UiLCIkb3NfdmVyc2lvbiI6IjEwLjIiLCIkY2FycmllciI6IuS4reWbveenu-WKqCIsIiRvcyI6ImlPUyIsIiRzY3JlZW5faGVpZ2h0IjoxMzM0LCIkc2NyZWVuX3dpZHRoIjo3NTAsIiRtb2RlbCI6ImlQaG9uZSIsIkZhdlRhYk5hbWUiOiLkvZzlk4EiLCIkd2lmaSI6dHJ1ZSwiJGFwcF92ZXJzaW9uIjoiMy43LjAiLCIkbWFudWZhY3R1cmVyIjoiQXBwbGUiLCIkbGliIjoiaU9TLW5ldCIsIiRuZXR3b3JrX3R5cGUiOiJXSUZJIiwiYWJ0ZXN0X2dyb3VwIjo3MH0sInByb2plY3QiOiJrdWFpa2FuX2FwcCIsImRpc3RpbmN0X2lkIjoiNDY5Mzg1MCIsInRpbWUiOjE0ODQ1NTE3ODY2NTcsInR5cGUiOiJ0cmFjayJ9&since=0&uid=\(MMUtils.getObjectForKey(key: "uid")!)"
        }
       
        NetworkTools.shardTools.requestL(method: .get, URLString: url, parameters: nil) { (response, error) in
            self.currentTableView?.mj_header.endRefreshing()
        print(response)
            if error == nil {
                guard let object = response as? [String: AnyObject] else {
                    print("格式错误")
                    return
                }
                
//                let model = Model.init(dict: object)
//                self.currentTableView?.dataArray = (model.data?.feeds)!
//                self.since = (model.data?.since)!
//                self.currentTableView?.mj_footer.isHidden = false
//                self.currentTableView?.reloadData()
            }
        }

    }
    func loadMoreData()  {
        
    }
    // MARK: - 懒加载
    
    fileprivate lazy var scrollView:UIScrollView = {
        let view = UIScrollView.init(frame: CGRect.init(x: 0, y:40+64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64-49-40))
        view.delegate = self
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.isPagingEnabled = true;
        view.bounces = false
        view.contentSize = CGSize.init(width: SCREEN_WIDTH * 2, height: 0)
        return view
    }()
    fileprivate lazy var Titleview:UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y:64, width: SCREEN_WIDTH, height: 40))
        let titles = ["作品","作者"]
        for i in 0..<2 {
            
            let btn = UIButton.init(title: titles[i], color: BLACK_COLOR, fontSize: 14, target: self, actionName:#selector(self.topBtnClick(sender:)))
            
            btn.frame = CGRect.init(x: CGFloat(i) * (SCREEN_WIDTH/2.0), y: 0, width:SCREEN_WIDTH/2.0, height: 40)
            btn.setTitleColor(mainColor, for: .selected)
            view.addSubview(btn)
            
            btn.tag = i
            if i == 0 {
                btn.isSelected = true
                self.currentBtn = btn
                
            }
            
        }
        self.yellowView.frame = CGRect.init(x: SCREEN_WIDTH/8.0, y: 38, width: SCREEN_WIDTH/4.0, height: 2)
        view.addSubview(self.yellowView)
        
        return view
    }()
    fileprivate lazy var yellowView:UIView = {
        let view = UIView()
        view.backgroundColor = mainColor
        return view
    }()
    fileprivate lazy var currentBtn:UIButton = {
        let btn = UIButton()
        
        return btn
    }()
    
}
// MARK: - 代理方法/自定义方法
extension FollowingViewController : UIScrollViewDelegate,CommunityTableViewDel {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == self.scrollView {
            let  offsetX = (SCREEN_WIDTH/2 +  SCREEN_WIDTH/8.0 )/(SCREEN_WIDTH )
            if scrollView.contentOffset.x * offsetX <= SCREEN_WIDTH/8.0 {
                yellowView.x =
                    SCREEN_WIDTH/8.0
                return
            }
            
            yellowView.x = scrollView.contentOffset.x * offsetX
            
        }
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            scrollViewDidEndScrollingAnimation(scrollView)
        }
        
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / scrollView.bounds.size.width
        let btn = (Titleview.subviews[NSInteger(index)] as! UIButton)
        addChildView(index: index)
        topViewOffset(sender: btn)
        
        
    }
    func topBtnClick(sender: UIButton) {
        
        let offsetX = CGFloat(sender.tag) * SCREEN_WIDTH
        
        scrollView.setContentOffset(CGPoint.init(x: offsetX, y: 0), animated: true)
        
    }
    func addChildView(index:CGFloat)  {
        var Tableview = view.viewWithTag(100 + Int(index))
        
        if (Tableview  != nil) {
            currentTableView = Tableview as! CommunityTableView?
            return
        }
        Tableview = CommunityTableView()
        Tableview?.tag = 100 + Int(index)
        refresh(tableView: Tableview as! CommunityTableView)
        let vcW = scrollView.frame.size.width
        let vcH = scrollView.frame.size.height
        let vcY:CGFloat = 0
        let vcX = index * vcW
        Tableview?.frame = CGRect.init(x: vcX, y: vcY, width: vcW, height: vcH)
        scrollView.addSubview(Tableview!)
        currentTableView?.mj_header.beginRefreshing()
    }
    func topViewOffset(sender:UIButton) {
        currentBtn.isSelected = false
        currentBtn = sender
        sender.isSelected = true
        
        
        
    }
    func didSelectRowAtIndex(data: Feeds) {
        let controller = CommunityDetailController()
        
        
        controller.height = data.rowHeight
        
        controller.dataArray.append([data])
        controller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    
}
