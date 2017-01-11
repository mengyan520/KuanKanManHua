//
//  WeekDay.swift
//  快看漫画
//
//  Created by Youcai on 16/5/19.
//  Copyright © 2016年 mm. All rights reserved.

import UIKit

class WeekTools: NSObject {
    // static let weekDay = WeekTools.init()
    class  func getWeek() -> Int {
        
        let calendar = NSCalendar.init(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let date = Date.init()
        var comps = NSDateComponents.init()
        let unitFlags = NSCalendar.Unit.weekday
        comps = (calendar?.components(unitFlags, from: date ))! as NSDateComponents
        
        return comps.weekday - 1
        
    }
    class func weekArray(day:Int) -> [String] {
        let weekArray = ["周日", "周一", "周二", "周三", "周四", "周五", "周六"]
        var arr = [String]()
        var Newday = 0
        for index in ((1 + 1)...6).reversed() {
            Newday = day - index
            if Newday < 0  {
                Newday = 7 + Newday
            }
            arr.append(weekArray[Newday])
        }
        arr.append("昨天")
        arr.append("今天")
        return arr
    }
    //获取时间戳
  class  func timeStampWithDate(day:Int) -> String {
        let unit:NSCalendar.Unit = [NSCalendar.Unit.year , NSCalendar.Unit.month , NSCalendar.Unit.day]
        let calendar = NSCalendar.init(identifier: NSCalendar.Identifier.gregorian)
        
        var dateComponents = DateComponents.init()
        dateComponents.day = day
        let newDate = calendar?.date(byAdding: dateComponents, to: (calendar?.date(from:  (calendar?.components(unit, from: Date.init()))!))!, options: NSCalendar.Options(rawValue: 0))
        
        return "\(newDate!.timeIntervalSince1970)"
    }
}
