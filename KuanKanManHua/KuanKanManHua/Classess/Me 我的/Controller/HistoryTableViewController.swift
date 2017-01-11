//
//  HistoryTableViewController.swift
//  KuanKanManHua
//
//  Created by Youcai on 17/1/6.
//  Copyright © 2017年 mm. All rights reserved.
//https://api.kkmh.com/v1/topic_new/check_update?topic_ids=178%2C970
//https://api.kkmh.com/v1/topic_new/check_update?topic_ids=775%2C178%2C970
import UIKit
private let ID = "cell"
class HistoryTableViewController: UITableViewController {
    var dataArray = [Info]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "浏览历史"
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: ID)
        tableView.estimatedRowHeight = 200
        
        tableView.separatorStyle = .none
        dataArray = SQLiteManager.sharedManager.checkAllData(name: "history")!
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "清空", style:
            .plain, target: self, action: #selector(self.clickRightButton(sender:)))
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName:RGB(r: 255, g: 209, b: 10, a: 1.0)], for: .normal)
        loadData()
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
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.5//dataArray[indexPath.row].rowHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ID, for: indexPath) as! HistoryTableViewCell
        cell.data = dataArray[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = CartoonDetailViewController.init(ID: dataArray[indexPath.row].id, name: dataArray[indexPath.row].title!)
        
        controller.topicID = "\(dataArray[indexPath.row].topic_id)"
        controller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK: - 网络请求
    func loadData()  {
        let  ids = NSMutableArray()
        for data in dataArray {
            ids.add(data.topic_id)
        }
      
        
        NetworkTools.shardTools.requestL(method: .get, URLString: "https://api.kkmh.com/v1/topic_new/check_update?topic_ids=\(ids.componentsJoined(by: "%2C"))", parameters: nil) { (response, error) in
            
            //print(response)
            if error == nil {
                guard let object = response as? [String: AnyObject] else {
                    print("格式错误")
                    return
                }
                let model = Model.init(dict: object)
                
                for data in (model.data?.info)! {
                    SQLiteManager.sharedManager.updateData(name: "history", topic_id: data.topic_id, latest_comic_title: data.latest_comic_title!)
                    
                }
                self.dataArray = SQLiteManager.sharedManager.checkAllData(name: "history")!
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: -  方法
    func clickRightButton(sender:UIBarButtonItem) {
        let alert = UIAlertController.init(title: "清空浏览记录吗？", message: nil, preferredStyle: .alert)
        let action1 = UIAlertAction.init(title: "取消", style: .default, handler: nil)
        let action2 = UIAlertAction.init(title: "清空", style: .default) {[weak self] (action) in
            SQLiteManager.sharedManager.deleteTable(name: "history")
            self?.dataArray.removeAll()
            self?.tableView.reloadData()
        }
        alert.addAction(action1)
        alert.addAction(action2)
        present(alert, animated: true, completion: nil)
        
    }
}
