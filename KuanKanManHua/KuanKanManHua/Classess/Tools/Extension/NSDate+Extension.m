//
//  NSDate+Extension.m
//  Easywork
//
//  Created by Kingxl on 1/5/15.
//  Copyright (c) 2015 Jin. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

+ (NSString *)ew_timeStamp
{
    return [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970] * 1000];
}


+ (NSString *)ew_timeStringWithInterval:(NSTimeInterval)time
{
//    DBLog(@"time===%@",@(time));
    NSInteger distance = [[NSDate date] timeIntervalSince1970] - time;
    NSString *string;
    if (distance < 1){//avoid 0 seconds
        string = @"刚刚";
    }
    else if (distance < 60) {
        string = [NSString stringWithFormat:@"%@秒前", @(distance)];
    }
    else if (distance < 3600) {//60 * 60
        distance = distance / 60;
        string = [NSString stringWithFormat:@"%@分钟前", @(distance)];
    }
    else if (distance < 86400) {//60 * 60 * 24
        distance = distance / 3600;
        string = [NSString stringWithFormat:@"%@小时前", @(distance)];
    }
    else if (distance < 604800) {//60 * 60 * 24 * 7
        distance = distance / 86400;
        string = [NSString stringWithFormat:@"%@天前", @(distance)];
    }
    else if (distance < 2419200) {//60 * 60 * 24 * 7 * 4
        distance = distance / 604800;
        string = [NSString stringWithFormat:@"%@周前", @(distance)];
    }
    else {
        NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        }
        string = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:(time)]];
        
    }
    return string;
}

+ (NSString *)ew_formatTimeWithInterval:(NSTimeInterval) time
{
    NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    NSString * string = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:(time/1000)]];
    return string;
}
+ (NSString *)ew_formatAbsTimeWithInterval:(NSTimeInterval) time
{
    NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    }
    NSString * string = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:(time/1000)]];
    return string;
}
+ (NSString *)ew_formatAbssTimeWithInterval:(NSTimeInterval) time
{//yyyy-MM-dd HH:
    NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm"];
    }
    NSString * string = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:(time)]];
    return string;
}

- (NSDate *)ew_relativedDateWithInterval:(NSInteger)interval
{
    
    return nil;
}
/**
 *  判断某个时间是否为今年
 */
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 获得某个时间的年月日时分秒
    NSDateComponents *dateCmps = [calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *nowCmps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    return dateCmps.year == nowCmps.year;
}

/**
 *  判断某个时间是否为昨天
 */
- (BOOL)isYesterday
{
    NSDate *now = [NSDate date];
    
    // date ==  2014-04-30 10:05:28 --> 2014-04-30 00:00:00
    // now == 2014-05-01 09:22:10 --> 2014-05-01 00:00:00
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    // 2014-04-30
    NSString *dateStr = [fmt stringFromDate:self];
    // 2014-10-18
    NSString *nowStr = [fmt stringFromDate:now];
    
    // 2014-10-30 00:00:00
    NSDate *date = [fmt dateFromString:dateStr];
    // 2014-10-18 00:00:00
    now = [fmt dateFromString:nowStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}

/**
 *  判断某个时间是否为今天
 */
- (BOOL)isToday
{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    
    return [dateStr isEqualToString:nowStr];
}

@end
