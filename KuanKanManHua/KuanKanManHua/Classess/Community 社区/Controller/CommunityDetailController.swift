//
//  CommentTableViewController.swift
//  快看漫画
//
//  Created by Youcai on 16/7/26.
//  Copyright © 2016年 mm. All rights reserved.

//https://api.kkmh.com/v1/comments/feed/79332832778522624/order/time?offset=2147483647
import UIKit

class CommunityDetailController: UITableViewController {
    lazy  var dataArray = [[AnyObject]]()
    var height:CGFloat = 0
    init() {
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        
        loadData()
        
    }
    //设置TableView
    func setTableView() {
        tableView.estimatedRowHeight = 200
        tableView.register(CommunityTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.register(CommentCell.self, forCellReuseIdentifier: "CommentCell")
        tableView.register(CommentSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: "header")

        tableView.separatorStyle = .none
        tableView.tableFooterView = footView
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        title = "动态正文"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "ic_nav_second_back_normal_17x17_"), style: .plain, target: self, action: #selector(self.clickLeftButton(sender:)))
    }
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        tableView.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-49)
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataArray[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
            (cell as! CommunityTableViewCell).data = dataArray[indexPath.section][indexPath.row] as? Feeds
            cell.selectionStyle = .none
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath)
            
            (cell as! CommentCell).data = dataArray[indexPath.section][indexPath.row] as? Comments
            let feeds = dataArray[0][0] as! Feeds
            (cell as! CommentCell).nickname = feeds.user!.nickname
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return height
        }
        
        return (dataArray[indexPath.section][indexPath.row] as? Comments)!.rowHeight
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! CommentSectionHeaderView
            
            view.name = "最新评论"
            return view
        }
        return nil
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return  section == 1 ? 30:0.1
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    func footViewTap() {
         let data = dataArray[0][0] as! Feeds
        let controller = AllCommentTableViewController.init(feed_id: data.feed_id,type:1)
        controller.nickname = (data.user?.nickname)!
        controller.hidesBottomBarWhenPushed = true
        let nav = UINavigationController.init(rootViewController:controller)
        self.present(nav, animated: true, completion: nil)
    }
    
    // MARK: - 网络请求
    private func loadData() {
        let feeds = dataArray[0][0] as! Feeds
        // print("http://api.kuaikanmanhua.com/v1/comments/feed/\(feeds.feed_id)/order/time?offset=2147483647")
        NetworkTools.shardTools.requestL(method: .get, URLString: "https://api.kkmh.com/v1/comments/feed/\(feeds.feed_id)/order/time?offset=2147483647", parameters: nil) { (result, error) in
            
            if error == nil {
            guard let object = result! as? [String: AnyObject] else {
                print("格式错误")
                return
            }
            let model = Model.init(dict: object)
            self.dataArray.append((model.data?.comments)!)
            
            self.tableView.reloadData()
            }else {
             JGPHUD.showErrorWithStatus(status: "无网络连接", view: self.view)
            }
        }
    }
    
    // MARK: -方法
    func clickLeftButton(sender:UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    // MARK: - 懒加载
    private lazy var footView:CommentFootView = {
        let view = CommentFootView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height:40))
        view.backgroundColor = WHITE_COLOR
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.footViewTap))
        view.addGestureRecognizer(tap)
        return view
    }()
//    private lazy var bottomView:BottomCommentView = {
//        let view = BottomCommentView.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT-49, width: SCREEN_WIDTH, height:49))
//        view.backgroundColor = RED_COLOR
//        
//       
//        return view
//    }()
}
