//
//  NetworkTools.swift

//
//  Created by Youcai on 16/3/4.
//  Copyright © 2016年 mm. All rights reserved.


import Foundation

import Alamofire

//MARK:-网络工具

enum MMRequestMethod:String {
    case GET = "GET"
    case POST = "POST"
}
class NetworkTools {
    //定义回调
    typealias MMRequestCallBack = (_ response:Any?,_ error:NSError?)->()
    //单例
    
    static let shardTools :NetworkTools = NetworkTools()
}
// MARK: - 封装 Alamofire 网络方法
extension NetworkTools {
    
    func requestL(method: HTTPMethod, URLString: String, parameters: [String: Any]?, finished: @escaping MMRequestCallBack) {
        
        // 显示网络指示菊花
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        
        
        if (URLString.range(of: "?sort=") != nil) && MMUtils.userHasLogin() {
            
            let JSESSIONID = MMUtils.getObjectForKey(key: "JSESSIONID")
            let session = MMUtils.getObjectForKey(key: "session")
            let headers = ["Cookie":"JSESSIONID=\(JSESSIONID!),session=\(session!)"]
            
            let request = Alamofire.request(URLString, method: method, parameters: parameters, encoding:  URLEncoding.default, headers: headers)
            
            request.responseJSON(completionHandler: { (response) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                // 判断是否失败
                
                if response.result.isFailure {
                    // 在开发网络应用的时候，错误不要提示给用户，但是错误一定要输出！
                    finished(nil, response.result.error as NSError?)
                }else if response.result.isSuccess {
                    if method == .post {
                        MMUtils.saveCookies()
                    }
                    
                    // 完成回调
                    finished(response.result.value, response.result.error as NSError?)
                }
                
            })
        }else{
            Alamofire.request(URLString, method: method, parameters: parameters).responseJSON(completionHandler: { (response) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                // 判断是否失败
                
                if response.result.isFailure {
                    // 在开发网络应用的时候，错误不要提示给用户，但是错误一定要输出！
                    finished(nil, response.result.error as NSError?)
                }else if response.result.isSuccess {
                    if method == .post {
                        MMUtils.saveCookies()
                    }
                    
                    // 完成回调
                    finished(response.result.value, response.result.error as NSError?)
                }
                
            })
        }
        
        
    }
    
}
