//
//  CartoonDetailViewController.swift
//  KuanKanManHua
//
//  Created by Youcai on 16/12/29.
//  Copyright © 2016年 mm. All rights reserved.
///https://api.kkmh.com/v2/comic/19902
//https://api.kkmh.com/v1/comics/19902/hot_comments

import UIKit

class CartoonDetailViewController: BaseViewController,CartoonTableViewDel {
    var ID:Int = 0
    var name = "漫画内容"
    var topicID:String?
    var statusBarHidden = false
    // MARK: - 构造方法
    init(ID:Int,name:String) {
        super.init(nibName: nil, bundle: nil)
        self.ID = ID
        self.name = name
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = true
        
        view.addSubview(tableView)
        layoutNavigationBar()
        loadData()
        
    }
    // 设置导航栏
    func layoutNavigationBar() {
        title = name
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "ic_nav_second_back_normal_17x17_"), style: .plain, target: self, action: #selector(self.clickLeftButton(sender:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "全集", style:
            .plain, target: self, action: #selector(self.clickRightButton(sender:)))
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName:RGB(r: 255, g: 209, b: 10, a: 1.0)], for: .normal)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        // NotificationCenter.default.addObserver(self, selector: #selector(self.CaroonBtn(noti:)), name: NSNotification.Name.init(rawValue: "CartoonBtn"), object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - 网络请求
    func loadData() {
        print("https://api.kkmh.com/v2/comic/\(ID)?")
        MMUtils.showLoading()
        NetworkTools.shardTools.requestL(method: .get, URLString:"https://api.kkmh.com/v2/comic/\(ID)?", parameters: nil) {(result, error) in
             MMUtils.hideLoading()
            if error == nil {
            guard let object = result! as? [String: AnyObject] else {
                print("格式错误")
                return
            }
            let model = Model.init(dict: object)
            self.tableView.data = model.data
            self.title = model.data?.title
            self.tableView.imageInfo = (model.data?.image_infos)!
            self.tableView.imageArray = (model.data?.images)!
            self.loadCommentData()
            
            let data = Info.init(dict: nil)
            data.title = model.data?.topic!.title
            data.topic_id = (model.data?.topic!.id)!
            data.latest_comic_title = model.data?.title
            data.id = (model.data?.id)!
            data.cover_image_url = model.data?.topic!.cover_image_url
            data.old_comic_title = model.data?.title
            SQLiteManager.sharedManager.saveData(data: data, name: "history")
            }else {
              MMUtils.hideLoading()
                MMUtils.showError()
            }
        }
        
    }
    func loadCommentData()  {
        
        
        NetworkTools.shardTools.requestL(method: .get, URLString:"https://api.kkmh.com/v1/comics/\(ID)/hot_comments", parameters: nil) {(result, error) in
            
            guard let object = result! as? [String: AnyObject] else {
                print("格式错误")
                return
            }
            let model = Model.init(dict: object)
            self.tableView.commentsArray = (model.data?.comments)!
            
            self.tableView.reloadSections(IndexSet.init(integer: 1), with: .none)
        }
        
    }
    
    // MARK: - 事件
    
    func clickLeftButton(sender:UIBarButtonItem) {
        //let controller =  navigationController?.childViewControllers.first
        //      print(controller)
        
        //        if (controller?.isEqual( HomeTableViewController.self))! {
        //            _ =  navigationController?.popToViewController(controller!, animated: true)
        //        } else {
        _ =  navigationController?.popViewController(animated: true)
        //        }
        
        
    }
    func clickRightButton(sender:UIBarButtonItem) {
        
        let controller = WordDetailViewController.init(ID:topicID)
        navigationController?.pushViewController(controller, animated: true)
        
    }
    func didSelectedBtn(sender: UIButton, data: ModelData) {
        
        
        if sender.tag == 5 {//上一篇
            if data.previous_comic_id  != 0 {
                 //SQLiteManager.sharedManager.saveData(data:data.topic!, name: "history")
                let controller = CartoonDetailViewController.init(ID: data.previous_comic_id, name: "")
                
                controller.topicID = topicID
                navigationController?.pushViewController(controller, animated: true)
            }
        } else if sender.tag == 6 {//下一篇
            // SQLiteManager.sharedManager.saveData(data:data.topic!, name: "history")
            if data.next_comic_id  != 0 {
                
                let controller = CartoonDetailViewController.init(ID: data.next_comic_id, name: "")
                
                controller.topicID = topicID
                navigationController?.pushViewController(controller, animated: true)
            }
        }
        
    }
   
    
    deinit {
        print("deinit")
        NotificationCenter.default.removeObserver(self)
        
    }
    // MARK: - 懒加载
    private lazy var tableView:CartoonTableView = {
        let tableView = CartoonTableView.init(frame: self.view.bounds, style: .grouped)
        
        tableView.del = self
        
        return tableView
    }()
    
    
}
