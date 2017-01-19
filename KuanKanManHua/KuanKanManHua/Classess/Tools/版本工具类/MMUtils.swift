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
       
        if (getObjectForKey(key: "Cookies") == nil) {
            return false
        }
   
         
        let cookies = NSKeyedUnarchiver.unarchiveObject(with: getObjectForKey(key: "Cookies") as! Data) as! [HTTPCookie]
        for cookie in cookies {
           
            if cookie.name == "JSESSIONID"  {
                
                if cookie.value == ( MMUtils.getObjectForKey(key: "JSESSIONID") as! String ){
                   return true
                }
            }
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
    class  func setObject(data:Any?,key:String) {
        UserDefaults.standard.set(data, forKey: key)
    }
    class   func getObjectForKey(key:String)->AnyObject? {
        
        return  UserDefaults.standard.object(forKey: key) as AnyObject?
    }
    class   func deleteObject(key:String){
        return  UserDefaults.standard.removeObject(forKey: key)
    }
     // MARK: - cookies
    class func saveCookies() {
       
        let cookiesData = NSKeyedArchiver.archivedData(withRootObject: HTTPCookieStorage.shared.cookies as Any)
        for cookie in HTTPCookieStorage.shared.cookies! {
            self.setObject(data: cookie.value, key: cookie.name)
            print(cookie.value)
            print(cookie.name)
        }
        self.setObject(data: cookiesData, key: "Cookies")
    }
    class func loadCookies() {
        let cookies = NSKeyedUnarchiver.unarchiveObject(with: self.getObjectForKey(key: "Cookies") as! Data) as! [HTTPCookie]
        for cookie in cookies {
            HTTPCookieStorage.shared.setCookie(cookie)
        }
       
    }
    class func deleteCookies() {
        
        for cookie in  HTTPCookieStorage.shared.cookies! {
            HTTPCookieStorage.shared.deleteCookie(cookie)
        }
        
    }
        
    
}
