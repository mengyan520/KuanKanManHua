//
//  UIButton+btn.h
//  OC--新浪微博
//
//  Created by Apple on 15/11/9.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (btn)
+ (UIButton *)setBackImageName:(NSString *)BackimageName  ImageName:(NSString *)ImageName;
+ (UIButton *)setBackImageName:(NSString *)BackimageName title:(NSString *)title color:(UIColor *)color;
+ (UIButton *)setimgName:(NSString *)imgName title:(NSString *)title color:(UIColor *)color;
+ (UIButton *)setimgName:(NSString *)imgName title:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize backColor:(UIColor *)backColor;
+ (UIButton *)settitle:(NSString *)title Normalcolor:(UIColor *)color Selectedlcolor:(UIColor *)Selectedcolor BackImageName:(NSString *)BackimageName;
+ (UIButton *)setimgName:(NSString *)imgName  SelectimgName:(NSString *)selectimgNmae title:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize backColor:(UIColor *)backColor;
+ (UIButton *)settitle:(NSString *)title Normalcolor:(UIColor *)color Selectedlcolor:(UIColor *)Selectedcolor fontSize:(CGFloat)fontSize backColor:(UIColor *)backColor;
//点击
+ (UIButton *)setBackImageName:(NSString *)BackimageName imgName:(NSString *)imgName title:(NSString *)title color:(UIColor *)color Selectedlcolor:(UIColor *)Selectedcolor action:(SEL)action Target:(id)target;
@end
