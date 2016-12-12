//
//  Utils.swift
//  高仿闲鱼
//
//  Created by Youcai on 16/7/19.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit
class MMUtils: NSObject {
     
   //判断是否登录
   class func userHasLogin() -> Bool {
        let flag =  getObjectForKey(key: USERLOGIN) as! NSInteger
        if flag  == 1 {
            return true
        }
        return false
    }
    //保存 字典
    class func saveUserData(data:[String:AnyObject]) {
        for (key,value) in data {
            setObject(data: value, key: key)
        }
    }
    //判断版本号
  class  func isNewVersion() -> Bool {
      //  var flag = false
        //已经存储的
        let currentVersion = bundleVersion()
        let version = Double(currentVersion)!
        //比较两个版本
    
        let sandboxVersionKey = "sandboxVersionKey"
    let sandboxVersion = UserDefaults.standard.double(forKey: sandboxVersionKey)
    
    UserDefaults.standard.set(version, forKey: sandboxVersionKey)
    
    return version > sandboxVersion
    }
    //获取版本号
   class  func bundleVersion() -> String {
        
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    //MARK:- UserDefault
  class  func setObject(data:AnyObject?,key:String) {
        UserDefaults.standard.set(data, forKey: key)
    }
 class   func getObjectForKey(key:String)->AnyObject? {
 
        return  UserDefaults.standard.object(forKey: key) as AnyObject?
    }
    class   func deleteObject(key:String){
        return  UserDefaults.standard.removeObject(forKey: key)
    }
}
