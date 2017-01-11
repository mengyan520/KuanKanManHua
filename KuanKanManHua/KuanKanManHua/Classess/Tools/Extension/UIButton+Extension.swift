//
//  UIButton+Extension.swift
//  Weibo10
//
//  Created by male on 15/10/14.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit

extension UIButton {
    
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
    convenience init(title: String, color: UIColor,SelectedColor: UIColor?,imageName: String?,SelectedImageName: String?,fontSize: CGFloat,target: AnyObject?, actionName: Selector?) {
        self.init()
        if let imageName = imageName {
            setImage(UIImage(named: imageName), for: .normal)
        }
        if let SelectedImageName = SelectedImageName  {
            
            setImage(UIImage(named: SelectedImageName), for: .selected)
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
    //图片在上,文字在下
    convenience init(title: String, color: UIColor,imageName: String?,SelectedImageName: String?,fontSize: CGFloat,target: AnyObject?, actionName: Selector?) {
        self.init()
        if let imageName = imageName {
            setImage(UIImage(named: imageName), for: .normal)
        }
        if let SelectedImageName = SelectedImageName  {
            
            setImage(UIImage(named: SelectedImageName), for: .selected)
        }
        
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        if let actionName = actionName {
            self.addTarget(target, action: actionName, for: .touchUpInside)
        }
        
        let  spacing:CGFloat = 7.0
        let  imageSize = self.imageView!.image!.size;
        self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, -(imageSize.height + spacing), 0.0)
        let titleSize = ((self.titleLabel?.text)! as NSString).size(attributes: [NSFontAttributeName:self.titleLabel!.font])
        self.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing), 0.0, 0.0, -titleSize.width)
        sizeToFit()
    }
    
}
