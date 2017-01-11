//
//  AllCommentTableViewController.swift
//  快看漫画
//
//  Created by Youcai on 16/7/26.
//  Copyright © 2016年 mm. All rights reserved.

//https://api.kkmh.com/v1/comments/feed/79332832778522624/order/time?offset=2147483647  左
//https://api.kkmh.com/v1/comments/feed/79332832778522624/order/time?offset=87638852
//https://api.kkmh.com/v1/comments/feed/79332832778522624/order/score?offset=0 右
//https://api.kkmh.com/v1/comments/feed/79332832778522624/order/score?offset=20
//首页
//https://api.kkmh.com/v1/comics/20133/comments/0?order=score
import UIKit
import MJRefresh
class AllCommentTableViewController: UITableViewController {
    lazy var leftArray = [Comments]()
    lazy var rightArray = [Comments]()
    var type:Int = 1
    var id:Int = 0
    var since:Int = 2147483647
    var first = 1
    var typeString:String = "time"
    var nickname = "df"
    init(feed_id:Int,type:Int) {
        
        super.init(style: .plain)
       
        id = feed_id
        self.type = type
        tableView.estimatedRowHeight = 200
        tableView.separatorStyle = .none
        tableView.register(CommentCell.self, forCellReuseIdentifier: "CommentCell")
        let header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(AllCommentTableViewController.loadData))
        tableView.mj_header = header
        let foot = MJRefreshAutoFooter.init(refreshingTarget: self, refreshingAction: #selector(AllCommentTableViewController.loadMoreData))
        tableView.mj_footer = foot
        tableView.mj_footer.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setUI()
        
        loadData()
    }
    
    //设置界面
    private func setUI() {
        
        
        navigationItem.titleView = topView
      //  navigationController?.navigationBar.addSubview(topView)
        topView.selectedSegmentIndex = 0
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "ic_nav_delete_normal_17x17_"), style: .plain, target: self, action: #selector(AllCommentTableViewController.clickLeftButton(sender:)))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if topView.selectedSegmentIndex == 1 {
            
            return rightArray.count
        }
        return  leftArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        if topView.selectedSegmentIndex == 1 {
            
            
            cell .data = rightArray[indexPath.row]
        }else {
            cell .data = leftArray[indexPath.row]
        }
        
        cell.nickname = nickname
        
        
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if topView.selectedSegmentIndex == 0 {
            
            return leftArray[indexPath.row].rowHeight
        }
        return rightArray[indexPath.row].rowHeight
    }
    
    
    
    
    // MARK: - 网络请求
    
    @objc
    private func loadData() {
        if topView.selectedSegmentIndex == 1 {
            typeString = "score"
            since = 0
        }else  {
            typeString = "time"
            since = 2147483647
            
        }
        let url = type == 0 ? "https://api.kkmh.com/v1/comics/\(id)/comments/0?order=\(typeString)" : "https://api.kkmh.com/v1/comments/feed/\(id)/order/\(typeString)?offset=\(since)"
       
        NetworkTools.shardTools.requestL(method: .get, URLString: url, parameters: nil) { (result, error) in
            // print(result)
            if error == nil {
                if self.first == 1 {
                    self.first = 2
                    //self.setUI()
                }
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.isHidden = false
                if error == nil {
                    guard let object = result! as? [String: AnyObject] else {
                        print("格式错误")
                        return
                    }
                    
                    let model = Model.init(dict: object)
                    self.since = (model.data?.since)!
                    if self.topView.selectedSegmentIndex == 1 {
                        
                        
                        
                        
                        self.rightArray = (model.data?.comments)!
                    } else {
                        self.leftArray = (model.data?.comments)!
                        
                    }
                    self.tableView.reloadData()
                    if self.leftArray.count > 0 && self.rightArray.count > 0 {
                    self.tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .none, animated: false)
                    }
                }
            }
        }
        
    }
    @objc
    private func loadMoreData() {
         let url = type == 0 ? "https://api.kkmh.com/v1/comics/\(id)/comments/0?order=\(typeString)" : "https://api.kkmh.com/v1/comments/feed/\(id)/order/\(typeString)?offset=\(since)"
        NetworkTools.shardTools.requestL(method: .get, URLString: url, parameters: nil) { (result, error) in
            if error == nil {
                self.tableView.mj_footer.endRefreshing()
                if error == nil {
                    guard let object = result! as? [String: AnyObject] else {
                        print("格式错误")
                        return
                    }
                    
                    let model = Model.init(dict: object)
                    self.since = (model.data?.since)!
                    if self.topView.selectedSegmentIndex == 0 {
                        
                        
                        
                        self.leftArray = (self.leftArray) + (model.data?.comments)!
                    } else {
                        self.rightArray = (self.rightArray) + (model.data?.comments)!
                        
                    }
                    self.tableView.reloadData()
                    
                }
            }
        }
        
    }
    
    // MARK: - 事件
    @objc
    private func segmentedSelected(sender:UISegmentedControl) {
        //
        
        loadData()
    }
    func clickLeftButton(sender:UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    // MARK: - 懒加载
    //头部视图
    private lazy var topView:UISegmentedControl = {
        let segmented = UISegmentedControl.init(items: ["最新评论","最热评论"])
        
        segmented.frame =  CGRect.init(x: (SCREEN_WIDTH-200)/2, y: 8, width: 200, height: 30)
        let att = [NSFontAttributeName:Font(fontSize: 16),NSForegroundColorAttributeName:WHITE_COLOR]
        segmented.setTitleTextAttributes(att, for: .selected)
        let attt = [NSFontAttributeName:Font(fontSize: 16),NSForegroundColorAttributeName:BLACK_COLOR]
        segmented.setTitleTextAttributes(attt, for: .normal)
        segmented.tintColor = GRAY_COLOR
        
        segmented.backgroundColor = WHITE_COLOR
        segmented.addTarget(self, action: #selector(AllCommentTableViewController.segmentedSelected(sender:)), for: .valueChanged)
        return segmented
    }()
    
}
