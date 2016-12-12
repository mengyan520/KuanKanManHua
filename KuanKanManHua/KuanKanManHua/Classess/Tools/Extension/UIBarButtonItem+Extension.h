//
//  UIBarButtonItem+Extension.h
//  彩票
//
//  Created by ma on 15/10/7.
//  Copyright (c) 2015年 ma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+(UIBarButtonItem*)itemWithTitle:(NSString*)title norImage:(NSString*)norImage higImage:(NSString*)higImage target:(id)target action:(SEL)action;
@end
