//
//  UILabel+Label.h
//  OC-微博
//
//  Created by Apple on 15/11/10.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Label)
+ (UILabel *)setLabelTitle:(NSString *)title textColor:(UIColor *)textColor labelFont:(CGFloat)labelFont screenInset:(CGFloat )screeenInset;
- (instancetype)initLabelTitle:(NSString *)title labelFont:(CGFloat )labelFont screenInset:(CGFloat)screeenInset;
@end
