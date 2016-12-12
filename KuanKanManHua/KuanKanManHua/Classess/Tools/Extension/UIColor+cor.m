//
//  UIColor+cor.m
//  OC-微博
//
//  Created by Apple on 15/11/18.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "UIColor+cor.h"

@implementation UIColor (cor)
+ (UIColor *)random {
    
    CGFloat r = (random() % 256) / 255.0;
    CGFloat g = (random() % 256) / 255.0;
    CGFloat b = (random() % 256) / 255.0;
    return [[UIColor alloc]initWithRed:r green:g blue:b alpha:1.0];
}
@end
