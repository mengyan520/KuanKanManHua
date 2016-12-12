//
//  UIBarButtonItem+Extension.m
//  彩票
//
//  Created by ma on 15/10/7.
//  Copyright (c) 2015年 ma. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
+(UIBarButtonItem*)itemWithTitle:(NSString*)title norImage:(NSString*)norImage higImage:(NSString*)higImage target:(id)target action:(SEL)action
{
    //1.创建按钮
    UIButton*btn=[[UIButton alloc]init];
    //2.设置图片
    if (norImage !=nil && ![norImage isEqualToString:@""]) {
        [btn setImage:[UIImage imageNamed:norImage] forState:UIControlStateNormal];
    }
    if (higImage !=nil && ![higImage isEqualToString:@""]) {
        [btn setImage:[UIImage imageNamed:higImage] forState:UIControlStateHighlighted];
        
    }
    //3.设置标题
    if (title !=nil && ![title isEqualToString:@""]) {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    
    //4.自动设置控件的frame
    [btn sizeToFit];
    //5.监听按钮点击事件
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
    
}

@end
