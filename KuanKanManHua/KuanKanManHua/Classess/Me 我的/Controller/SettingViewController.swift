//
//  SettingViewController.swift
//  仿漫漫
//
//  Created by Youcai on 16/5/18.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit
import SVProgressHUD
class SettingViewController: UITableViewController {
    let ID:String = "cell"
    var arrayM = [[String]]()
    var cache:Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "设置"
        arrayM = [["赏个好评","意见反馈","推荐给朋友"],["清理缓存","帮助中心","关于快看","用户协议"]]
        cache = FileTool .folderSize(path: PATH!)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return arrayM.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayM[section].count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if (cell == nil) {
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: ID)
        }
        let arr = arrayM[indexPath.section]
        cell!.textLabel?.text = arr[indexPath.row]
        if indexPath.section == 1 && indexPath.row == 0 {
            cell?.detailTextLabel?.text = String(format: "%.2lfM",cache!)
            cell?.accessoryType = .none
        }else {
            cell?.accessoryType = .disclosureIndicator
        }
        return cell!
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 && indexPath.row == 0 {
            
            
            FileTool .cleanFolder(path: PATH!) {
                
                self.cache = FileTool .folderSize(path: PATH!)
                tableView.reloadRows(at: [indexPath], with:.none)
                SVProgressHUD .showSuccess(withStatus: "清除成功")
            }
        }else {
            loginOut()
        }
    }
    // MARK: - 退出登录
    func loginOut()  {
        let parameters = ["alias_id" : "0","muid": "c1a27d6050e13d62f507191b81e76a5a","partner_id":"1","platform":"2","register_id":"171976fa8a8f5582962","tags":"not_login"
        ];
        
        NetworkTools.shardTools.requestL(method: .post, URLString: "https://api.kkmh.com/v1/device/push_info", parameters: parameters) { (response, error) in
            //  print(response)
            if error == nil {
                guard let object = response as? [String: AnyObject] else {
                    print("格式错误")
                    return
                }
                let model = Model.init(dict: object)
                if model.code == 200 {
                    SVProgressHUD.showSuccess(withStatus: "退出成功")
                    MMUtils.deleteObject(key: "Cookies")
                    MMUtils.deleteObject(key: "avatar_url")
                    MMUtils.deleteObject(key: "nickname")
                    MMUtils.deleteObject(key: "JSESSIONID")
                    MMUtils.deleteObject(key: "session")
                    POSTNOTIFICATION(name: "UserLogin", data: nil)
                    MMUtils.deleteCookies()
                   
                }
                
            }
            
            
            
        }
        
    }
}

