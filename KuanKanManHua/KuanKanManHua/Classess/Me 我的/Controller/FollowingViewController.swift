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
    var leftArray = [Topics]()
    var rightArray = [Author_list]()
    var isleft = true
    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "我的关注"
        view.addSubview(scrollView)
        view.addSubview(Titleview)
        
        scrollView.addSubview(leftTableView)
       
        loadData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - 网络请求
    func loadData()  {
        var  url = "https://api.kkmh.com/v1/fav/topics?limit=20&offset=0"
        
        if !isleft {
            url = "https://api.kkmh.com/v1/feeds/following_author_list?sa_event=eyJldmVudCI6IlJlYWRNeUZhdlRvcGljIiwicHJvcGVydGllcyI6eyJUcmlnZ2VyUGFnZSI6Ik15SG9tZVBhZ2UiLCIkb3NfdmVyc2lvbiI6IjEwLjIiLCIkY2FycmllciI6IuS4reWbveenu-WKqCIsIiRvcyI6ImlPUyIsIiRzY3JlZW5faGVpZ2h0IjoxMzM0LCIkc2NyZWVuX3dpZHRoIjo3NTAsIiRtb2RlbCI6ImlQaG9uZSIsIkZhdlRhYk5hbWUiOiLkvZzlk4EiLCIkd2lmaSI6dHJ1ZSwiJGFwcF92ZXJzaW9uIjoiMy43LjAiLCIkbWFudWZhY3R1cmVyIjoiQXBwbGUiLCIkbGliIjoiaU9TLW5ldCIsIiRuZXR3b3JrX3R5cGUiOiJXSUZJIiwiYWJ0ZXN0X2dyb3VwIjo3MH0sInByb2plY3QiOiJrdWFpa2FuX2FwcCIsImRpc3RpbmN0X2lkIjoiNDY5Mzg1MCIsInRpbWUiOjE0ODQ1NTE3ODY2NTcsInR5cGUiOiJ0cmFjayJ9&since=0&uid=\(MMUtils.getObjectForKey(key: "uid")!)"
        }
        
        NetworkTools.shardTools.requestL(method: .get, URLString: url, parameters: nil) { (response, error) in
            if self.isleft {
                self.leftTableView.mj_header.endRefreshing()
                
            }else {
                self.rightTableView.mj_header.endRefreshing()
            }
            // print(response)
            if error == nil {
                guard let object = response as? [String: AnyObject] else {
                    print("格式错误")
                    return
                }
                let model = Model.init(dict: object)
                if model.code == 200 {
                    if self.isleft {
                        self.leftArray = (model.data?.topics)!
                        
                        self.leftTableView.reloadData()
                    }else {
                        self.rightArray = (model.data?.author_list)!
                        
                        self.rightTableView.reloadData()
                    }
                }
                
                
                
            }
        }
        
    }
    func loadMoreData()  {
        
    }
    // MARK: - 懒加载
    
    fileprivate lazy var scrollView:UIScrollView = {
        let view = UIScrollView.init(frame: CGRect.init(x: 0, y:40+64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64-40))
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
        self.bottomView.frame = CGRect.init(x: 0, y: 39.5, width: SCREEN_WIDTH, height: 0.5)
        view.addSubview(self.yellowView)
        view.addSubview(self.bottomView)
        return view
    }()
    fileprivate lazy var yellowView:UIView = {
        let view = UIView()
        view.backgroundColor = mainColor
        return view
    }()
    fileprivate lazy var bottomView:UIView = {
        let view = UIView()
        view.backgroundColor = WHcolor
        return view
    }()
    fileprivate lazy var currentBtn:UIButton = {
        let btn = UIButton()
        
        return btn
    }()
    fileprivate lazy var leftTableView:UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64-40), style: .plain)
        tableView.delegate = self
        
        tableView.dataSource = self
        tableView.register(LeftTableViewCell.self, forCellReuseIdentifier: "left")
        let header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(self.loadData))
        
        tableView.mj_header = header
        let footer = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(self.loadMoreData))
        tableView.mj_footer = footer
        tableView.mj_footer.isHidden = true
        
        tableView.estimatedRowHeight = 200
        
        tableView.separatorStyle = .none
        tableView.tag = 0
        return tableView
    }()
    fileprivate lazy var rightTableView:UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: SCREEN_WIDTH, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64-40), style: .plain)
        tableView.register(RightTableViewCell.self, forCellReuseIdentifier: "right")
        let header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(self.loadData))
        
        tableView.mj_header = header
        let footer = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(self.loadMoreData))
        tableView.mj_footer = footer
        tableView.mj_footer.isHidden = true
        tableView.delegate = self
        
        tableView.dataSource = self
        tableView.estimatedRowHeight = 200
        
        tableView.separatorStyle = .none
         tableView.tag = 1
        return tableView
    }()
}
// MARK: - 代理方法/自定义方法
extension FollowingViewController : UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == rightTableView {
            return rightArray.count
        }
        return leftArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == leftTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "left", for: indexPath) as! LeftTableViewCell
            cell.data = leftArray[indexPath.row];
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "right", for: indexPath) as! RightTableViewCell
        cell.data = rightArray[indexPath.row];
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == rightTableView {
            return 60.5
        }
        
        return 100.5
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == leftTableView {
            let controller = WordDetailViewController.init(ID:"\(leftArray[indexPath.row].id)")
            
            
            navigationController?.pushViewController(controller, animated: true)
        }else {
            let controller = AuthorViewController.init(uid: rightArray[indexPath.row].id)
            
            
            navigationController?.pushViewController(controller, animated: true)
            
        }
    }
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
    func addChildView(index:CGFloat)  {
        
        let  view = scrollView.viewWithTag(Int(index))
     
        if (view != nil) {
            return
        }
        scrollView.addSubview(rightTableView)
        isleft = false
        loadData()
    }

    func topBtnClick(sender: UIButton) {
        
        let offsetX = CGFloat(sender.tag) * SCREEN_WIDTH
        
        scrollView.setContentOffset(CGPoint.init(x: offsetX, y: 0), animated: true)
        
    }
    
    func topViewOffset(sender:UIButton) {
        currentBtn.isSelected = false
        currentBtn = sender
        sender.isSelected = true
        if sender.tag == 0 {
            isleft = true
        }else {
            isleft = false
        }
    }
    
    
}
