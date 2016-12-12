//
//  NSString+MMNStringExt.h
//  QQ聊天界面-01
//
//  Created by ma on 15/9/16.
//  Copyright (c) 2015年 ma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (MMNStringExt)
//类方法
+(CGSize)sizeWithtext:(NSString*)text font:(UIFont*)font maxSize:(CGSize)maxSize;
//对象方法
-(CGSize)sizeOftextFont:(UIFont*)font maxSize:(CGSize)maxSize;

@end
