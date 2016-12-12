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
class HomeTableViewController: UITableViewController {
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
       
        cell.selectionStyle = .none
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataArray[indexPath.row].rowHeight
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
                let model = HomeModel.init(dict: object)
                self.dataArray = model.data!.comics!
                self.tableView.reloadData()
            }
        }
    }
}
