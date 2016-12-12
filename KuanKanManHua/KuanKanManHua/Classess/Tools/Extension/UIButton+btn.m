//
//  UIButton+btn.m

//
//  Created by Apple on 15/11/9.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "UIButton+btn.h"

@implementation UIButton (btn)
+ (UIButton *)setBackImageName:(NSString *)BackimageName  ImageName:(NSString *)ImageName {
    UIButton *btn =[[self alloc]init];
    [btn  setImage:[UIImage imageNamed:ImageName] forState:UIControlStateNormal];
    [btn  setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",ImageName]] forState:UIControlStateHighlighted];
    if (BackimageName != nil && ![BackimageName isEqualToString:@""]) {
        
        [btn  setBackgroundImage:[UIImage imageNamed:BackimageName] forState:UIControlStateNormal];
        [btn  setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",BackimageName]] forState:UIControlStateHighlighted];
    }
    [btn sizeToFit];
    return  btn;
}
+ (UIButton *)setBackImageName:(NSString *)BackimageName title:(NSString *)title color:(UIColor *)color {
    UIButton *btn = [[self alloc]init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn  setBackgroundImage:[UIImage imageNamed:BackimageName] forState:UIControlStateNormal];
    [btn sizeToFit];
    return  btn;
}
+ (UIButton *)setimgName:(NSString *)imgName title:(NSString *)title color:(UIColor *)color {
    UIButton *btn = [[self alloc]init];
    if (title != nil && ![title isEqualToString:@""]) {
        
        [btn setTitle:title forState:UIControlStateNormal];
    }
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn  setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [btn sizeToFit];
    return  btn;
}
+ (UIButton *)setimgName:(NSString *)imgName title:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize backColor:(UIColor *)backColor {
    UIButton *btn = [[self alloc]init];
    if (title != nil && ![title isEqualToString:@""]) {
        
        [btn setTitle:title forState:UIControlStateNormal];
    }
    
    [btn setTitleColor:color forState:UIControlStateNormal];
    if (imgName != nil && ![imgName isEqualToString:@""]) {
        [btn  setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    }
    if (backColor != nil) {
        
        
        [btn setBackgroundColor:backColor];
    }
    
    btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [btn sizeToFit];
    return  btn;
}
+ (UIButton *)setimgName:(NSString *)imgName  SelectimgName:(NSString *)selectimgNmae title:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize backColor:(UIColor *)backColor {
    UIButton *btn = [[self alloc]init];
    // UIButton *btn = [self buttonWithType:UIButtonTypeCustom];
    if (title != nil && ![title isEqualToString:@""]) {
        
        [btn setTitle:title forState:UIControlStateNormal];
    }
    
    [btn setTitleColor:color forState:UIControlStateNormal];
    if (imgName != nil && ![imgName isEqualToString:@""]) {
        [btn  setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    }
    if (selectimgNmae != nil && ![selectimgNmae isEqualToString:@""]) {
        [btn  setImage:[UIImage imageNamed:selectimgNmae] forState:UIControlStateSelected];
    }
    if (backColor != nil) {
        
        
        [btn setBackgroundColor:backColor];
    }
    
    btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [btn sizeToFit];
    [btn setAdjustsImageWhenHighlighted:NO];
    
    return  btn;
}
+ (UIButton *)settitle:(NSString *)title Normalcolor:(UIColor *)color Selectedlcolor:(UIColor *)Selectedcolor BackImageName:(NSString *)BackimageName{
    UIButton *btn = [[self alloc]init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitleColor:Selectedcolor forState:UIControlStateSelected];
    [btn setBackgroundImage:[UIImage imageNamed:BackimageName] forState:UIControlStateHighlighted];
    return btn;
}
+ (UIButton *)settitle:(NSString *)title Normalcolor:(UIColor *)color Selectedlcolor:(UIColor *)Selectedcolor fontSize:(CGFloat)fontSize backColor:(UIColor *)backColor {
    UIButton *btn = [[self alloc]init];
    if (title != nil && ![title isEqualToString:@""]) {
        
        [btn setTitle:title forState:UIControlStateNormal];
    }
    [btn setTitleColor:color forState:UIControlStateNormal];
    if (backColor != nil) {
        
        
        [btn setBackgroundColor:backColor];
    }
    if ( Selectedcolor != nil) {
        [btn setTitleColor:Selectedcolor forState:UIControlStateSelected];
    }
    btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    return  btn;
    
    
}
//点击
+ (UIButton *)setBackImageName:(NSString *)BackimageName imgName:(NSString *)imgName title:(NSString *)title color:(UIColor *)color Selectedlcolor:(UIColor *)Selectedcolor action:(SEL)action Target:(id)target {
    UIButton *btn = [[self alloc]init];
    if (title != nil && ![title isEqualToString:@""]) {
        
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:Selectedcolor forState:UIControlStateSelected];
        [btn setTitleColor:color forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    if (BackimageName != nil && ![BackimageName isEqualToString:@""]) {
        
        [btn  setBackgroundImage:[UIImage imageNamed:BackimageName] forState:UIControlStateNormal];
        
    }

    
    if (imgName != nil && ![imgName isEqualToString:@""]) {
        [btn  setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    }
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    return  btn;
}

@end
