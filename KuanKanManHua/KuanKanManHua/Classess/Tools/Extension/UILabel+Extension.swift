//
//  UILabel+Extension.swift
//  Weibo10
//
//  Created by male on 15/10/15.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit

extension UILabel {
    
    /// 便利构造函数
    ///
    /// - parameter title:          title
    /// - parameter fontSize:       fontSize，默认 14 号字
    /// - parameter color:          color，默认深灰色
    /// - parameter screenInset:    相对与屏幕左右的缩紧，默认为0，局中显示，如果设置，则左对齐
    ///
    /// - returns: UILabel
    /// 参数后面的值是参数的默认值，如果不传递，就使用默认值
    convenience init(title: String,
        fontSize: CGFloat = 14,
        color: UIColor = UIColor.darkGray,
        
        screenInset: CGFloat = 0) {
            
        self.init()
        
            text = title
            textColor = color
            font = UIFont.systemFont(ofSize: fontSize)
            
            numberOfLines = 0
           
            if screenInset == 0 {
                textAlignment = .center
            } else {
                // 设置换行宽度
                preferredMaxLayoutWidth = UIScreen.main.bounds.width - 2 * screenInset
                textAlignment = .left
            }
            
            sizeToFit()
    }
}
