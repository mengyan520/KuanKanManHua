//
//  SearchTableViewController.swift
//  KuanKanManHua
//
//  Created by Youcai on 17/3/2.
//  Copyright © 2017年 mm. All rights reserved.
//https://api.kkmh.com/v2/topic/search/hot_word?since=0  搜索热词
//https://api.kkmh.com/v1/topics/search?keyword=%E6%83%85%E4%BA%BA&limit=20&offset=0 搜索漫画
// https://api.kkmh.com/v1/authors/search?keyword=%E5%A5%B3&limit=20&offset=0 搜索作者

import UIKit

class SearchTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = WHcolor
        loadHotWord()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "取消", style: .plain, target: self, action: #selector(self.clickRightButton))
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName:BLACK_COLOR,NSFontAttributeName:Font(fontSize: 17)], for: .normal)
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "", style: .plain, target: self, action: nil)
        navigationItem.titleView = searchBar
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    // MARK: - 网络请求
    func loadHotWord()  {
        NetworkTools.shardTools.requestL(method: .get, URLString: "https://api.kkmh.com/v2/topic/search/hot_word?since=0", parameters: nil) { (response, error) in
            
            print(response)
            
            if error == nil {
                guard let object = response as? [String: AnyObject] else {
                    print("格式错误")
                    return
                }
                let model = Model.init(dict: object)
                if model.code == 200 {
                    
                }
                
            }
        }
        
    }
    // MARK: - 事件
    func clickRightButton() {
        
        _ = navigationController?.popViewController(animated: false)
    }
    // MARK: - 懒加载
    private lazy var searchBar:UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "请输入关键字"
        return view
    }()
}
