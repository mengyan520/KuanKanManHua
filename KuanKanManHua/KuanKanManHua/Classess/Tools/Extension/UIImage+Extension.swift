//
//  UIImage+Extension.swift

//
//  Created by male on 15/10/26.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit

extension UIImage {
    
    /// 将图像缩放到指定`宽度`
    ///
    /// - parameter width: 目标宽度
    ///
    /// - returns: 如果给定的图片宽度小于指定宽度，直接返回
    func scaleToWith(width: CGFloat) -> UIImage {
     
        // 1. 判断宽度
        if width > size.width {
            return self
        }
        
        // 2. 计算比例
        let height = size.height * width / size.width
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        
        // 3. 使用核心绘图绘制新的图像
        // 1> 开启上下文
        UIGraphicsBeginImageContext(rect.size)
        
        // 2> 绘图 - 在指定区域拉伸绘制
        self.draw(in: rect)
        
        // 3> 取结果
        let result = UIGraphicsGetImageFromCurrentImageContext()
        
        // 4> 关闭上下文
        UIGraphicsEndImageContext()
        
        // 5> 返回结果
        return result!
    }
    func ImageWithColor(color:UIColor)-> UIImage {
        
        let rect = CGRect.init(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
      return result!
    }
    func drawRectWithRoundCornor(radius: CGFloat, size: CGSize, backColor: UIColor = UIColor.white, lineWith: CGFloat = 1, lineColor: UIColor = UIColor.darkGray) -> UIImage? {
        let rect = CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
       
        let bezier = UIBezierPath.init(roundedRect: rect, byRoundingCorners: UIRectCorner.allCorners, cornerRadii: CGSize.init(width: radius, height: radius))
        backColor.setFill()
        UIRectFill(rect)
        
        bezier.addClip()
        draw(in:rect)
        
        bezier.lineWidth = 0
        lineColor.setStroke()
        bezier.stroke()
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    
}
