//
//  HomeTableViewController.swift
//  kuaikan
//
//  Created by 马鸣 on 2016/12/4.
//  Copyright © 2016年 马鸣. All rights reserved.


import UIKit
import MJRefresh
import Alamofire
let cellID = "Homecell"
class HomeTableViewController: UITableViewController,HomeTableViewCellDel {
    var time:String = "0"
    private var dataArray:[Comics] = [Comics].init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(self.loadData))
        
        tableView.mj_header = header
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 200
        loadData()
        tableView.backgroundColor = WHITE_COLOR
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! HomeTableViewCell
        
        cell.data = dataArray[indexPath.row]
        cell.del = self
        cell.selectionStyle = .none
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataArray[indexPath.row].rowHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let data = Info.init(dict: nil)
//        data.title = dataArray[indexPath.row].topic!.title
//        data.topic_id = dataArray[indexPath.row].topic!.id
//        data.latest_comic_title = dataArray[indexPath.row].title
//        data.id = dataArray[indexPath.row].id
//        data.cover_image_url = dataArray[indexPath.row].topic!.cover_image_url
//        data.old_comic_title = dataArray[indexPath.row].title
//        SQLiteManager.sharedManager.saveData(data: data, name: "history")
        let controller = CartoonDetailViewController.init(ID: dataArray[indexPath.row].id, name: dataArray[indexPath.row].title!)
        
        controller.topicID = "\(dataArray[indexPath.row].topic!.id)"
        controller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(controller, animated: true)
    }
    func didClickTopView(id: Int) {
        let controller = WordDetailViewController.init(ID:"\(id)")
        controller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(controller, animated: true)
    }
    func didBtnClick(sender: UIButton, data: Comics) {
        if sender.tag == 2 {
            let controller = AllCommentTableViewController.init(feed_id: data.id,type:0)
            
            controller.nickname = (data.topic?.user?.nickname)!
            controller.hidesBottomBarWhenPushed = true
            let nav = UINavigationController.init(rootViewController:controller)
            self.present(nav, animated: true, completion: nil)
        } else {
            
            sender.isSelected = !sender.isSelected
            
        }
    }
    //MARK: - 网络请求
    func loadData()  {
        
        NetworkTools.shardTools.requestL(method: .get, URLString: "https://api.kkmh.com/v1/daily/comic_lists/\(time)", parameters: nil) { (response, error) in
            self.tableView?.mj_header.endRefreshing()
            if error == nil {
                guard let object = response as? [String: AnyObject] else {
                    print("格式错误")
                    return
                }
                let model = Model.init(dict: object)
                self.dataArray = model.data!.comics!
                self.tableView.reloadData()
            }
        }
    }
}
