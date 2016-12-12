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
    typealias MMRequestCallBack = (_ response:Any?,_ error:Error?)->()
    //单例
    static let shardTools :NetworkTools = NetworkTools()
}
// MARK: - 封装 Alamofire 网络方法
extension NetworkTools {
    
    func requestL(method: HTTPMethod, URLString: String, parameters: [String: AnyObject]?, finished: @escaping MMRequestCallBack) {
        
        // 显示网络指示菊花
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.request(URL.init(string: URLString)!, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            //            // 判断是否失败
            if response.result.isFailure {
                // 在开发网络应用的时候，错误不要提示给用户，但是错误一定要输出！
                finished(nil, response.result.error)
            }else if response.result.isSuccess {
            // 完成回调
            finished(response.result.value, response.result.error)
            }
        }
        
        
    }
    
}
