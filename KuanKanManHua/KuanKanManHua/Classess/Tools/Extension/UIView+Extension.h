//
//  UIView+Extension.h
//  MyVillage
//
//  Created by 金学利 on 1/29/15.
//  Copyright (c) 2015 Kingxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

- (id)subviewWithTag:(NSInteger)tag;
- (void)removeAllSubViews;

- (UIViewController*)viewController;
@end
