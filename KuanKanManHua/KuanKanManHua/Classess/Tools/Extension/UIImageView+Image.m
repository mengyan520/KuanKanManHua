//
//  UIImageView+Image.m
//  OC-微博
//
//  Created by Apple on 15/11/10.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "UIImageView+Image.h"

@implementation UIImageView (Image)

+ (UIImageView *)setImageName:(NSString *)ImageName {
 
   return [[self alloc]initWithImage:[UIImage imageNamed:ImageName]];
    
}
+ (UIImageView *)setImagName:(NSString *)ImagName {
    UIImageView *img = [self new];
    img.image = [UIImage imageNamed:ImagName];
    img.layer.cornerRadius  = 25;
    img.layer.masksToBounds = YES;
    return img;
}
@end
