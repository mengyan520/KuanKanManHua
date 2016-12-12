//
//  UIFont+Extension.m
//  MyVillage
//
//  Created by 金学利 on 3/9/15.
//  Copyright (c) 2015 Kingxl. All rights reserved.
//

#import "UIFont+Extension.h"

@implementation UIFont (Extension)

- (CGFloat)ew_lineHeight
{
    return (self.ascender - self.descender);
}


@end
