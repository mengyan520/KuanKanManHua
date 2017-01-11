//
//  Date+Extension.swift
//  糗百
//
//  Created by Youcai on 16/11/14.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit

extension Date {
    func timeStringWithInterval(time:TimeInterval) -> String {
        
        let distance = Int(Date.init().timeIntervalSince1970 - time/1000)
       
        if distance < 1 {
            return "刚刚"
        } else if distance < 60 {
            return "\(distance)秒前"
        } else if distance < 3600 {
            return "\(distance / 60)分钟前"
        } else if distance < 86400 {
            return "\(distance / 3600)小时前"
        } else if distance < 604800 {
            return "\(distance / 86400)天前"
        } else if distance < 2419200 {
            return "\(distance / 604800)周前"
        }else {
            let dateFormatter = DateFormatter.init()
            
            return dateFormatter.string(from:  Date.init(timeIntervalSince1970: time) )
        }
        
    }
    
  
}
