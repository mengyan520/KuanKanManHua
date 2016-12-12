//
//  UILabel+Label.m
//  OC-微博
//
//  Created by Apple on 15/11/10.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "UILabel+Label.h"

@implementation UILabel (Label)
/*
 //设置文字信息
 text = Labeltext
 textColor = Textcolor
 font = UIFont.systemFontOfSize(Labelfont)
 
 if screenInset == 0 {
 textAlignment = .Center
 }else {
 
 preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 2 * screenInset
 textAlignment = .Left
 
 }
 numberOfLines = 0

 */
+ (UILabel *)setLabelTitle:(NSString *)title textColor:(UIColor *)textColor labelFont:(CGFloat)labelFont screenInset:(CGFloat )screeenInset {
    UILabel *lbl = [self new];
    lbl.text = title;
    lbl.textColor = textColor;
    lbl.font = [UIFont systemFontOfSize:labelFont];;
    if (screeenInset == 0) {
        
        lbl.textAlignment = NSTextAlignmentCenter;
    }else {
        
        lbl.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 2*screeenInset;
        lbl.textAlignment = NSTextAlignmentLeft;
    }
 //lbl.lineBreakMode =  NSLineBreakByTruncatingMiddle;
    lbl.numberOfLines = 0;
    return  lbl;
   }
- (instancetype)initLabelTitle:(NSString *)title labelFont:(CGFloat)labelFont screenInset:(CGFloat)screeenInset
{
    self = [super init];
    if (self) {
        self.text = title;
        self.textColor = [UIColor darkGrayColor];
        self.font = [UIFont systemFontOfSize:labelFont];
        if (screeenInset == 0) {
            
            self.textAlignment = NSTextAlignmentCenter;
        }else {
            
        self.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 2*screeenInset;
            self.textAlignment = NSTextAlignmentLeft;
        }


    }
    return self;
}
@end
