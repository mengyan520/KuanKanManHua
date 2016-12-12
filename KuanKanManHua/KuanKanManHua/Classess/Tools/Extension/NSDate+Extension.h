//
//  NSDate+Extension.h
//  Easywork
//
//  Created by Kingxl on 1/5/15.
//  Copyright (c) 2015 Jin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

/** Time stamp */
+ (NSString *)ew_timeStamp;

/** current time - service time = ? */
+ (NSString *)ew_timeStringWithInterval:(NSTimeInterval) time;

/** time year-month-day */
+ (NSString *)ew_formatTimeWithInterval:(NSTimeInterval) time;

/** time year-month-dat hh mm*/
+ (NSString *)ew_formatAbsTimeWithInterval:(NSTimeInterval) time;
+ (NSString *)ew_formatAbssTimeWithInterval:(NSTimeInterval) time;
/**  */
- (NSDate *)ew_relativedDateWithInterval:(NSInteger)interval;
/**
 *  判断某个时间是否为今年
 */
- (BOOL)isThisYear;
/**
 *  判断某个时间是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  判断某个时间是否为今天
 */
- (BOOL)isToday;
@end
