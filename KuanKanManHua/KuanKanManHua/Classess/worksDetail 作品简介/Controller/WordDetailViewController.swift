//
//  WordDetailViewController.swift
//  KuanKanManHua
//
//  Created by Youcai on 16/12/28.
//  Copyright © 2016年 mm. All rights reserved.
//https://api.kkmh.com/v2/review/topic/911

//https://api.kkmh.com/v1/topics/918/fav 关注  post
//https://api.kkmh.com/v1/topics/363/fav?sa_event=eyJldmVudCI6IlJlbW92ZUZhdlRvcGljIiwicHJvcGVydGllcyI6eyJMaWtlTnVtYmVyIjo0MTExNzQ3MywiVG9waWNOYW1lIjoi6Zu25YiG5YG25YOPIiwiVG9waWNJRCI6MzYzLCIkc2NyZWVuX3dpZHRoIjo3NTAsIiRhcHBfdmVyc2lvbiI6IjMuOS4wIiwiVHJpZ2dlclBhZ2UiOiJUb3BpY1BhZ2UiLCIkbW9kZWwiOiJpUGhvbmUiLCIkbmV0d29ya190eXBlIjoiV0lGSSIsIkNvbW1lbnROdW1iZXIiOjE5MTg0OTMsIiRjYXJyaWVyIjoi5Lit5Zu956e75YqoIiwiJHdpZmkiOnRydWUsIkZhdk51bWJlciI6NzM3OTgyMSwiTmlja05hbWUiOiLpnZLluq0iLCJDb21pY09yZGVyTnVtYmVyIjowLCIkc2NyZWVuX2hlaWdodCI6MTMzNCwiQXV0aG9ySUQiOjQ1OTMyNywiYWJ0ZXN0X2dyb3VwIjo3MCwiJG9zX3ZlcnNpb24iOiIxMC4yLjEiLCIkbGliIjoiaU9TLW5ldCIsIiRtYW51ZmFjdHVyZXIiOiJBcHBsZSIsIiRvcyI6ImlPUyJ9LCJwcm9qZWN0Ijoia3VhaWthbl9hcHAiLCJkaXN0aW5jdF9pZCI6IjQ2OTM4NTAiLCJ0aW1lIjoxNDg4MjcyMTM2OTE1LCJ0eXBlIjoidHJhY2sifQ%3D%3D 取消关注 delete
import UIKit
import SVProgressHUD
class WordDetailViewController: BaseViewController,WordDetailTableViewDel {
    var workID:String?
    
    init(ID:String?) {
        super.init(nibName: nil, bundle: nil)
        workID = ID
        view.backgroundColor = WHITE_COLOR
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        view.addSubview(headerView)
        view.addSubview(bottomView)
        bottomView.btnClickBlcok {[weak self] (data) in
            if ((SQLiteManager.sharedManager.checkData(name: "history", topic_id: (data.topic_id))?.count)! > 0) {
                let data =   SQLiteManager.sharedManager.checkData(name: "history", topic_id: (data.topic_id))!.first
                self?.didSelectRowAtIndex(ID: (data?.id)!, name: (data?.old_comic_title!)!)
            }else {
                self?.didSelectRowAtIndex(ID: data.id, name: data.title!)
            }
            
            
            
            
        }
        headerView.btnClickBlcok {[weak self] (sender) in
            if sender.tag == 1 {
                self?.clickLeftButton()
            }else {
                
                
                self?.addfollow(id: (self?.workID!)!,isfollow: sender.isSelected ? true : false)
                
            }
        }
        loadData(sort: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(self.sort(noti:)), name: NSNotification.Name.init(rawValue: "sort"), object: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        if self.tableView.rightArray.count > 0 {
            
            self.bottomView.data =
                self.tableView.rightArray.last
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: -   网络方法
    func loadData(sort:NSInteger) {
        
        NetworkTools.shardTools.requestL(method: .get, URLString:"http://api.kuaikanmanhua.com/v1/topics/\(workID!)?sort=\(sort)", parameters:nil) {(result, error) in
            // print(result)
            if (error == nil) {
                guard let object = result! as? [String: AnyObject] else {
                    print("格式错误")
                    return
                }
                let model = Model.init(dict: object)
                if model.code == 200 {
                    self.headerView.data = model.data
                    self.tableView.rightArray = (model.data?.comics)!
                    if sort == 0 {
                        self.bottomView.data =
                            self.tableView.rightArray.last
                    }
                    self.tableView.data = model.data
                    self.tableView.reloadData()
                }
                
            }else {
                
                MMUtils.showNetFailureView(view: self.view)
                JGPHUD.showErrorWithStatus(status: "无网络连接", view: self.view)
                MMUtils.btnClickBlcok(btnblock: {[weak self] (sender) in
                    MMUtils.hideNetFailureView(view: (self?.view)!)
                    self?.loadData(sort: 0)
                })
            }
        }
    }
    func addfollow(id:String,isfollow:Bool)  {
        
        
        NetworkTools.shardTools.requestL(method: isfollow ? .delete : .post, URLString: "https://api.kkmh.com/v1/topics/\(id)/fav", parameters: nil) { (response, error) in
            //  print(response)
            if error == nil {
                guard let object = response as? [String: AnyObject] else {
                    print("格式错误")
                    return
                }
                let model = Model.init(dict: object)
                if model.code == 200 {
                    
                    if !isfollow  {
                        JGPHUD.showSuccessWithStatus(status: "关注成功", view: self.view)
                        
                        self.headerView.isfollow = true
                    }else {
                        JGPHUD.showSuccessWithStatus(status: "取消关注", view: self.view)
                        self.headerView.isfollow = false
                    }                }
                
                
            }
        }
        
    }
    
    // MARK: - 事件
    func didSelectRowAtIndex(ID: Int,name:String) {
        let controller = CartoonDetailViewController.init(ID: ID, name: name)
        controller.isWorkDetail = true
        controller.topicID = workID
        navigationController?.pushViewController(controller, animated: true)
    }
    func clickLeftButton() {
        
        _ = navigationController?.popViewController(animated: true)
    }
    deinit {
        print("deinit")
        NotificationCenter.default.removeObserver(self)
    }
    //通知方法
    func sort(noti:NSNotification)  {
        let sender = noti.userInfo!["data"] as! UIButton
        sender.isSelected = !sender.isSelected
        sender.isSelected == true ? loadData(sort: 1) : loadData(sort: 0)
    }
    // MARK: - 懒加载
    private lazy var tableView:WordDetailTableView = {
        let tableView = WordDetailTableView.init()
        tableView.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-49)
        tableView.contentInset = UIEdgeInsets.init(top: 200, left: 0, bottom: 0, right: 0)
        tableView.tableHeaderView = self.TableheaderView
        tableView.del = self
        return tableView;
    }()
    private lazy var headerView:wordsHeadView = {
        let view = wordsHeadView.init(frame:CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height:200),scrollView:self.tableView)
        
        return view
    }()
    private lazy var TableheaderView:wordTableHeadView = {
        let view = wordTableHeadView.init(frame:CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 44))
        view.btnClickBlcok(btnblock: {[weak self] (sender) in
            
            self!.tableView.isleft = (sender.tag == 1) ? true:false
            
            self!.tableView.reloadData()
        })
        
        return view
    }()
    private lazy var bottomView:BottomView = {
        let view = BottomView.init(frame:CGRect.init(x: 0, y:SCREEN_HEIGHT - 49, width: SCREEN_WIDTH, height: 49))
        
        return view
    }()
}
fileprivate class BottomView: UIView {
    var data:Comics? {
        didSet {
            if ((SQLiteManager.sharedManager.checkData(name: "history", topic_id: (data?.topic_id)!)?.count)! > 0) {
                rightBtn.setTitle("继续阅读", for: .normal)
                leftlbl.text = SQLiteManager.sharedManager.checkData(name: "history", topic_id: (data?.topic_id)!)?.first?.old_comic_title
            }else {
                leftlbl.text = data?.title
            }
        }
    }
    typealias btnBlcok = (_ data: Comics) -> Void
    var block:btnBlcok?
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(leftlbl)
        addSubview(rightBtn)
        rightBtn.snp.makeConstraints { (make) in
            make.right.top.bottom.equalTo(self)
            make.width.equalTo(100)
        }
        leftlbl.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(self)
            make.right.equalTo(rightBtn.snp.left).offset(-10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func btnClickBlcok(btnblock:btnBlcok?) {
        block = btnblock
    }
    func  btnClick(sender:UIButton)  {
        block?(data!)
        
    }
    private lazy var leftlbl:UILabel = {
        
        let lbl =  UILabel.init(title: "昵称", fontSize: 12, color: LIGHTGRAY_COLOR, screenInset: 0)
        lbl.numberOfLines = 1
        return lbl
    }()
    private lazy var rightBtn:UIButton = {
        let btn = UIButton.init(title: "开始阅读", color:BLACK_COLOR  , fontSize: 12, target: self, actionName: #selector(self.btnClick(sender:)))
        btn.backgroundColor = RGB(r: 255, g: 209, b: 10, a: 1.0)
        
        
        return btn
    }()
}
