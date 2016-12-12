//
//  UIImageView+Extension.swift
//  Weibo10
//
//  Created by male on 15/10/15.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit

extension UIImageView {
    
    /// 便利构造函数
    ///
    /// - parameter imageName: imageName
    ///
    /// - returns: UIImageView
    convenience init(imageName: String) {
        self.init(image: UIImage(named: imageName))
    }
   
    func addCorner(radius: CGFloat) {
        self.image = self.image?.drawRectWithRoundCornor(radius: radius, size: self.bounds.size)
    }
}
