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
        
        
        //        let cookies = NSKeyedUnarchiver.unarchiveObject(with: getObjectForKey(key: "Cookies") as! Data) as! [HTTPCookie]
        //        for cookie in cookies {
        //
        //            if cookie.name == "JSESSIONID"  {
        //
        //                if cookie.value == ( MMUtils.getObjectForKey(key: "JSESSIONID") as! String ){
        //                   return true
        //                }
        //            }
        //        }
        
        return true
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
            
        }
        self.setObject(data: cookiesData, key: "Cookies")
    }
    class func loadCookies() {
        if (getObjectForKey(key: "Cookies") == nil) {
            return
        }
        
        let cookies = NSKeyedUnarchiver.unarchiveObject(with: self.getObjectForKey(key: "Cookies") as! Data) as! [HTTPCookie]
        let cookieStorage = HTTPCookieStorage.shared
        for cookie in cookies {
            
            cookieStorage.setCookie(cookie)
        }
        
    }
    class func deleteCookies() {
        let cookieStorage = HTTPCookieStorage.shared
        for cookie in  HTTPCookieStorage.shared.cookies! {
            cookieStorage.deleteCookie(cookie)
        }
        
    }
    // MARK: - 断网视图
    typealias btnBlcok = (_ sender: UIButton) -> Void
  static  var block:btnBlcok?

    class func showNetFailureView(view:UIView) {
       
        let backView = UIView.init(frame: view.bounds)
        backView.tag = 100000
        backView.backgroundColor = WHITE_COLOR
        let imageView = UIImageView.init(frame: CGRect.init(x: (SCREEN_WIDTH-100)/2.0, y: 150, width: 100, height: 100))
        imageView.image = UIImage.init(named: "net_fail")
        backView.addSubview(imageView)
        let lbl = UILabel()
        lbl.text = "亲，现在网络不好..."
        lbl.textAlignment = .center
        lbl.font = Font(fontSize: 12)
        lbl.textColor = RGB(r: 40, g: 40, b: 40, a: 1.0)
        backView.addSubview(lbl)
        let btn = UIButton.init(title: "点击加载", color: RGB(r: 40, g: 40, b: 40, a: 1.0), fontSize: 12, target: self, actionName: #selector(self.btnClick(sender:)))
        btn.layer.cornerRadius = 11
        btn.clipsToBounds = true
        btn.layer.borderColor = RGB(r: 40, g: 40, b: 40, a: 1.0).cgColor
        btn.layer.borderWidth = 1
        backView.addSubview(btn)
        view.addSubview(backView)
        lbl.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(52)
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(20)
        }
        btn.snp.makeConstraints { (make) in
            make.top.equalTo(lbl.snp.bottom).offset(20)
            make.width.equalTo(75)
            make.height.equalTo(22)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
  class  func btnClickBlcok(btnblock:btnBlcok?) {
        block = btnblock
    }
   class func  btnClick(sender:UIButton)  {
        block?(sender)
    
    }
    class func hideNetFailureView(view:UIView) {
        let backView = view.viewWithTag(100000)
        for view in (backView?.subviews)! {
            view.removeFromSuperview()
        }
        backView?.removeFromSuperview()
        
    }
}
