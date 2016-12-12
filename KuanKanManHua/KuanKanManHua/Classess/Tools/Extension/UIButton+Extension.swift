//
//  UIButton+Extension.swift
//  Weibo10
//
//  Created by male on 15/10/14.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit

extension UIButton {
    
    /// 便利构造函数
    ///
    /// - parameter imageName:     图像名称
    /// - parameter backImageName: 背景图像名称
    ///
    /// - returns: UIButton
    /// - 备注：如果图像名称使用 "" 会抱错误 CUICatalog: Invalid asset name supplied:
    convenience init(imageName: String, backImageName: String?,SelectedImageName: String?,target: AnyObject?, actionName: Selector?) {
        self.init()
        
        setImage(UIImage(named: imageName), for: .normal)
        //setImage(UIImage(named: imageName), for: .highlighted)
        
        if let backImageName = backImageName {
            setBackgroundImage(UIImage(named: backImageName), for: .normal)
           // setBackgroundImage(UIImage(named: backImageName), for: .highlighted)
        }
        if let SelectedImageName = SelectedImageName  {
            //setBackgroundImage(UIImage(named: backImageName), for: .normal)
           setImage(UIImage(named: SelectedImageName), for: .selected)
        }
        if let actionName = actionName {
            self.addTarget(target, action: actionName, for: .touchUpInside)
        }
        // 会根据背景图片的大小调整尺寸
        sizeToFit()
    }
    
    /// 便利构造函数
    ///
    /// - parameter title:          title
    /// - parameter color:          color
    /// - parameter backImageName:  背景图像
    ///
    /// - returns: UIButton
    convenience init(title: String, color: UIColor,fontSize: CGFloat,target: AnyObject?, actionName: Selector?) {
        self.init()
        
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
       titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        if let actionName = actionName {
            self.addTarget(target, action: actionName, for: .touchUpInside)
        }
        sizeToFit()
    }
    
    /// 便利构造函数
    ///
    /// - parameter title:     title
    /// - parameter color:     color
    /// - parameter fontSize:  字体大小
    /// - parameter imageName: 图像名称
    /// - parameter backColor: 背景颜色（默认为nil）
    ///
    /// - returns: UIButton
    convenience init(title: String, fontSize: CGFloat, color: UIColor, imageName: String?, backColor: UIColor? = nil) {
        self.init()
        
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        
        if let imageName = imageName {
            setImage(UIImage(named: imageName), for: .normal)
        }
        
        // 设置背景颜色
        backgroundColor = backColor
        
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        
        sizeToFit()
    }
    convenience init(title: String, color: UIColor,SelectedColor: UIColor?,imageName: String?,fontSize: CGFloat,target: AnyObject?, actionName: Selector?) {
        self.init()
        if let imageName = imageName {
            setImage(UIImage(named: imageName), for: .normal)
        }
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        if let color = SelectedColor {
            setTitleColor(color, for: .selected)
        }
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        if let actionName = actionName {
            self.addTarget(target, action: actionName, for: .touchUpInside)
        }
        sizeToFit()
    }

}
