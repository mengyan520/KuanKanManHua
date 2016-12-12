//
//  UIImage+img.m
//  照片选择器OC
//
//  Created by Apple on 15/11/17.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "UIImage+img.h"

@implementation UIImage (img)
- (UIImage *)scaleImage:(CGFloat)width {
    //1.判断高度
//    if (width > self.size.width) {
//        return self;
//    }
    //2.计算比例
    CGFloat heigth = self.size.height * width / self.size.width;
    CGRect rect = CGRectMake(0, 0, width, heigth);
    //3.开始图形上下文
    UIGraphicsBeginImageContext(rect.size);
    //4.绘图
    [self drawInRect:rect];
    //[self drawInRect:<#(CGRect)#> blendMode:<#(CGBlendMode)#> alpha:<#(CGFloat)#>]
    //5.取图
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    //6.关闭上下文
    UIGraphicsEndImageContext();
    
    //7.返回结果
    return img;
}
+(UIImage *)setImageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
-(UIImage *)setImageWithColor:(UIColor *)color {
   
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
