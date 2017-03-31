//
//  AuthorViewController.swift
//  KuanKanManHua
//
//  Created by Youcai on 17/2/20.
//  Copyright © 2017年 mm. All rights reserved.
//https://api.kkmh.com/v1/users/1 个人界面 资料
//https://api.kkmh.com/v1/feeds/feed_lists?catalog_type=3&page_num=1&since=0&uid=1 个人界面 动态

import UIKit
import SVProgressHUD
class AuthorViewController: BaseViewController,AuthorTableViewDel {
    var since = 0
    var uid = 0
    init(uid:Int) {
        super.init(nibName: nil, bundle: nil)
        self.uid = uid
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(headerView)
        loadUserData()
        loadData()
        
        headerView.btnClickBlcok {[weak self] (sender) in
            if sender.tag == 1 {
                self?.clickLeftButton()
            }else {
                
                
                self?.addfollow(author_id:"\(self!.uid)",isRelation: sender.isSelected ? 0 : 1)
                
            }
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    // MARK: - 网络请求
    func loadData()  {
        print("https://api.kkmh.com/v1/feeds/feed_lists?catalog_type=3&page_num=1&since=0&uid=\(uid)")
        
        NetworkTools.shardTools.requestL(method: .get, URLString: "https://api.kkmh.com/v1/feeds/feed_lists?catalog_type=3&page_num=1&since=0&uid=\(uid)", parameters: nil) { (response, error) in
            
            //  print(response)
            
            if error == nil {
                guard let object = response as? [String: AnyObject] else {
                    print("格式错误")
                    return
                }
                let model = Model.init(dict: object)
                if model.code == 200 {
                    let model = Model.init(dict: object)
                    
                    self.tableView.dataArray = (model.data?.feeds)!
                    self.tableView.reloadData()
                }
                
                
                
                
            }else {
                
            }
        }
    }
    func loadUserData()  {
        print("https://api.kkmh.com/v1/users/\(uid)")
        
        NetworkTools.shardTools.requestL(method: .get, URLString: "https://api.kkmh.com/v1/users/\(uid)", parameters: nil) { (response, error) in
            
            //  print(response)
            
            if error == nil {
                guard let object = response as? [String: AnyObject] else {
                    print("格式错误")
                    return
                }
                let model = Model.init(dict: object)
                
                self.headerView.data = model.data
                self.tableView.data = model.data
                self.tableView.leftArray = (model.data?.topics)!
            }
        }
    }
    func addfollow(author_id:String,isRelation:Int)  {
        
        let parameters = ["author_id":author_id,"relation":"\(isRelation)","uid":MMUtils.getObjectForKey(key: "uid") ?? ""] as [String : Any]
        NetworkTools.shardTools.requestL(method: .post, URLString: "https://api.kkmh.com/v1/feeds/update_following_author", parameters: parameters) { (response, error) in
            //  print(response)
            if error == nil {
                guard let object = response as? [String: AnyObject] else {
                    print("格式错误")
                    return
                }
                let model = Model.init(dict: object)
                if model.code == 200 {
                    if isRelation == 1 {
                        JGPHUD.showSuccessWithStatus(status: "关注成功", view: self.view)
                        self.headerView.isfollow = true
                    }else {
                        JGPHUD.showSuccessWithStatus(status: "取消关注", view: self.view)
                        self.headerView.isfollow = false
                    }
                    
                }else {
                    JGPHUD.showErrorWithStatus(status: model.message!, view: self.view)
                    
                }
                
                
            }
        }
        
    }
    
    // MARK: - 事件
    
    func clickLeftButton() {
        
        _ = navigationController?.popViewController(animated: true)
    }
    // MARK: - 代理方法
    func didSelectRithtRowAtIndex(data: Feeds) {
        let controller = CommunityDetailController()
        
        
        controller.height = data.rowHeight
        
        controller.dataArray.append([data])
        controller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(controller, animated: true)
    }
    func didSelectLeftRowAtIndex(ID: Int) {
        let controller = WordDetailViewController.init(ID:"\(ID)")
        controller.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(controller, animated: true)
    }
    // MARK: - 懒加载
    private lazy var tableView:AuthorTableView = {
        let tableView = AuthorTableView()
        tableView.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        tableView.contentInset = UIEdgeInsets.init(top: 260, left: 0, bottom: 0, right: 0)
        tableView.tableHeaderView = self.TableheaderView
        tableView.del = self
        return tableView;
    }()
    private lazy var headerView:AuthorHeaderView = {
        let view = AuthorHeaderView.init(frame:CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height:260),scrollView:self.tableView)
        return view
    }()
    private lazy var TableheaderView:wordTableHeadView = {
        let view = wordTableHeadView.init(frame:CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 44))
        view.leftBtn.setTitle("资料", for: .normal)
        view.rightBtn.setTitle("动态", for: .normal)
        
        view.btnClickBlcok(btnblock: {[weak self] (sender) in
            
            self!.tableView.isleft = (sender.tag == 1) ? true:false
            
            self!.tableView.reloadData()
        })
        
        return view
    }()
}
