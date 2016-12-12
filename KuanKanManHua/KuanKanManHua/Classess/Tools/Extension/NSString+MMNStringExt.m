//
//  NSString+MMNStringExt.m
//  QQ聊天界面-01
//
//  Created by ma on 15/9/16.
//  Copyright (c) 2015年 ma. All rights reserved.
//

#import "NSString+MMNStringExt.h"

@implementation NSString (MMNStringExt)
+(CGSize)sizeWithtext:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary*dict=@{NSFontAttributeName:font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;


}
-(CGSize)sizeOftextFont:(UIFont *)font maxSize:(CGSize)maxSize{
    return  [NSString sizeWithtext:self font:font maxSize:maxSize];


}



@end
