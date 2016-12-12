//
//  Common.swift
//  youCai
//
//  Created by Youcai on 16/3/4.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit
import SnapKit
//MARK:- 颜色
let BLACK_COLOR      = UIColor.black
let DARKGRAY_COLOR   = UIColor.darkGray
let LIGHTGRAY_COLOR  = UIColor.lightGray
let WHITE_COLOR      = UIColor.white
let CLEAR_COLOR      = UIColor.clear
let RED_COLOR        = UIColor.red
let GRAY_COLOR       = UIColor.gray
let HEADER_HEIGHT =  440/2.0+10
let HEADERHEIGHT:CGFloat = 335
let ITEMWIDTH:CGFloat = 290/2.0
let ITEMHEIGHT:CGFloat = ((232+146)/2.0)
let WHcolor = UIColor(white: 0.95, alpha: 1.0)

let LINECOLOR = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
//主题色
let mainColor = RGB(r: 253, g: 142, b: 20, a: 1.0) 

func RGB(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) ->UIColor{
    if #available(iOS 10.0, *) {
        return  UIColor.init(displayP3Red: r/255.0, green:  g/255.0, blue: b/255.0, alpha: a)
    }         // Fallback on earlier versions
    
  return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}
//MARK:- Size
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT =  UIScreen.main.bounds.size.height
//MARK:- Font
func Font(fontSize:CGFloat) ->UIFont  {

  return UIFont.systemFont(ofSize: fontSize)
}
//粗体
func BFont(fontSize:CGFloat) ->UIFont  {
    
    return UIFont.boldSystemFont(ofSize: fontSize)
}
//MARK:- 价格下划线
func PriceString(string:String,subString:String) ->NSMutableAttributedString{
    
    let attributeString = NSMutableAttributedString(string:string )
    let range = (string as NSString) .range(of: subString)
    
    attributeString.addAttributes([NSStrikethroughStyleAttributeName:"1",NSStrikethroughColorAttributeName:RGB(r: 200, g: 200, b: 200, a: 1.0),NSForegroundColorAttributeName:RGB(r: 200, g: 200, b: 200, a: 1.0),NSFontAttributeName:Font(fontSize: 12)], range: range)
    return attributeString
}
//MARK:- 路径
let PATH = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last
let DouPATH = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last
// 下载文件的总文件夹
let BASEFile = "MMDownLoad"
// 完整文件路径
let TARGET = "CacheList"
// 临时文件夹名称
let TEMP = "Temp"
// 临时文件夹的路径
let TEMP_FOLDER = PATH! + "/" + BASEFile + "/" + TEMP

// 下载文件夹路径
let FILE_FOLDER = PATH! + "/" + BASEFile + "/" + TARGET
// 文件信息的Plist路径
let PLIST_PATH = PATH! + "/" + BASEFile + "/FinishedPlist.plist"
func MMPlayerSrcName(file:String)->String {
    // [@"ZFPlayer.bundle" stringByAppendingPathComponent:file]
    
return  ("MMPlayer.bundle" as NSString).appendingPathComponent(file)
}
func MMPlayerImage(file:String)->UIImage {
    return ((UIImage.init(named: MMPlayerSrcName(file: file)) != nil) ? UIImage.init(named: MMPlayerSrcName(file: file)):UIImage.init(named: MMPlayerFrameworkSrcName(file: file)))!
}
func MMPlayerFrameworkSrcName(file:String)->String {
    return ("Frameworks/MMPlayer.framework/MMPlayer.bundle" as NSString).appendingPathComponent(file)
}

//MARK:- 常用宏
//登录
let USERLOGIN       = "login"
let Key_Window = UIApplication.shared.keyWindow
// MARK: - 通知
func POSTNOTIFICATION(name:String,data:AnyObject?) {
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: name), object: data)

}
func REMOVENOTIFICATION(sender:AnyObject) {
    NotificationCenter.default.removeObserver(sender)
    
}
