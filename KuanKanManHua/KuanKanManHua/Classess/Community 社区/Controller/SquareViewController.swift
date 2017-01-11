//
//  SquareViewController.swift
//  KuanKanManHua
//
//  Created by Youcai on 16/12/26.
//  Copyright © 2016年 mm. All rights reserved.
//https://api.kkmh.com/v1/feeds/feed_lists?catalog_type=2&page_num=1 热门
//https://api.kkmh.com/v1/feeds/feed_lists?catalog_type=1&page_num=1 最新
//https://api.kkmh.com/v1/feeds/feed_lists?catalog_type=1&page_num=3
import MJRefresh
class SquareViewController: BaseViewController {
    var since = 0
    var page_num = 1
    var type = 2
    var currentTableView:CommunityTableView?
    override func viewDidLoad() {
        super.viewDidLoad()
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
        NotificationCenter.default.addObserver(self, selector: #selector(self.comment(noti:)), name: NSNotification.Name(rawValue: "comment"), object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
        if self.currentTableView?.tag != 100 {
            type = 1
        }
        NetworkTools.shardTools.requestL(method: .get, URLString: "https://api.kkmh.com/v1/feeds/feed_lists?catalog_type=\(type)&page_num=1", parameters: nil) { (response, error) in
            self.currentTableView?.mj_header.endRefreshing()
            if error == nil {
                guard let object = response as? [String: AnyObject] else {
                    print("格式错误")
                    return
                }
                
                let model = Model.init(dict: object)
                self.currentTableView?.dataArray = (model.data?.feeds)!
                self.since = (model.data?.since)!
                self.currentTableView?.mj_footer.isHidden = false
                self.currentTableView?.reloadData()
            }
        }
    }
    func loadMoreData()  {
        
        page_num = page_num + 1
        if self.currentTableView?.tag != 100 {
            type = 1
        }
        print("https://api.kkmh.com/v1/feeds/feed_lists?catalog_type=\(type)&page_num=\(page_num)&since=\(since)")
        NetworkTools.shardTools.requestL(method: .get, URLString: "https://api.kkmh.com/v1/feeds/feed_lists?catalog_type=\(type)&page_num=\(page_num)&since=\(since)", parameters: nil) { (response, error) in
            self.currentTableView?.mj_footer.endRefreshing()
            if error == nil {
                guard let object = response as? [String: AnyObject] else {
                    print("格式错误")
                    return
                }
                
                let model = Model.init(dict: object)
                self.currentTableView?.dataArray =  (self.currentTableView?.dataArray)! + (model.data?.feeds)!
                
                self.since = (model.data?.since)!
                self.currentTableView?.reloadData()
                
            }
        }
        
    }
    
    // MARK: - 懒加载
    
    fileprivate lazy var scrollView:UIScrollView = {
        let view = UIScrollView.init(frame: CGRect.init(x: 0, y:40, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64-49-40))
        view.delegate = self
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.isPagingEnabled = true;
        view.bounces = false
        view.contentSize = CGSize.init(width: SCREEN_WIDTH * 2, height: 0)
        return view
    }()
    fileprivate lazy var Titleview:UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y:0, width: SCREEN_WIDTH, height: 40))
        let titles = ["热门","最新"]
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
        let view = UIView.init()
        view.backgroundColor = mainColor
        return view
    }()
    fileprivate lazy var currentBtn:UIButton = {
        let btn = UIButton.init()
        
        return btn
    }()
    
}
// MARK: - 代理方法/自定义方法
extension SquareViewController : UIScrollViewDelegate,CommunityTableViewDel {
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
    // MARK: - 通知方法
    
    func comment(noti:NSNotification) {
        
        let data = noti.userInfo!["data"] as! Feeds
        let controller = AllCommentTableViewController.init(feed_id: data.feed_id,type:1)
        controller.nickname = (data.user?.nickname)!
        controller.hidesBottomBarWhenPushed = true
        let nav = UINavigationController.init(rootViewController:controller)
        self.present(nav, animated: true, completion: nil)
        
    }
    
    
}
