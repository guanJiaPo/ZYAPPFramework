//
//  NSDate+ZYCategory.m
//  ZYAPPFramework
//
//  Created by szy on 2019/1/31.
//  Copyright © 2019 szy. All rights reserved.
//

#import "NSDate+ZYCategory.h"

@implementation NSDate (ZYCategory)


static NSDateComponents *_zyComponents = nil;
static NSDateFormatter *_displayFormatter = nil;

#pragma mark private

+ (NSDateFormatter *)sharedFormatter {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_displayFormatter == nil) {
            _displayFormatter = [[NSDateFormatter alloc] init];
        }
    });
    return _displayFormatter;
}

- (NSDateComponents *)components {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_zyComponents == nil) {
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday;
            _zyComponents = [calendar components:unitFlags fromDate:self];
        }
    });
    return _zyComponents;
}

#pragma mark public

/// 格式化字符串
- (NSString *)stringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [NSDate sharedFormatter];
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}

/// 年
- (NSInteger)year {
    return self.components.year;
}

/// 月
- (NSInteger)month {
    return self.components.month;
}

/// 日
- (NSInteger)day {
    return self.components.day;
}

/// 时
- (NSInteger)hour {
    return self.components.hour;
}

/// 分
- (NSInteger)minute {
    return self.components.day;
}

/// 秒
- (NSInteger)second {
    return self.components.day;
}

/// 星期几（1 ~ 7）
- (NSInteger)weekDay {
    return self.components.weekday;
}

///周几（周一 ~ 周日）
- (NSString *)weekDayString {
    NSString *week = @"";
    switch (self.weekDay) {
        case 1:
            week = @"周一";
            break;
        case 2:
            week = @"周二";
            break;
        case 3:
            week = @"周三";
            break;
        case 4:
            week = @"周四";
            break;
        case 5:
            week = @"周五";
            break;
        case 6:
            week = @"周六";
            break;
        case 7:
            week = @"周日";
            break;
        default:
            break;
    }
    return week;
}

/// 是否为今天
- (BOOL)isToday {
    NSDate *date = [NSDate date];
    if (self.components.year == date.components.year && self.components.month == date.components.month && self.components.day == date.components.day) {
        return true;
    }
    return false;
}

/// 是否为昨天
- (BOOL)isYesterday {
    NSDate *date = [NSDate date];
    if (self.components.year == date.components.year && self.components.month == date.components.month && self.components.day == date.components.day - 1) {
        return true;
    }
    return false;
}

/// 是否为今年
- (BOOL)isThisYear {
    NSDate *date = [NSDate date];
    if (self.components.year == date.components.year) {
        return true;
    }
    return false;
}

/**
 根据格式化字符串返回日期

 @param string 字符串
 @param format 格式化规则
 @return 日期
 */
+ (NSDate *)dateFromString:(NSString *)string format:(NSString *)format {
    NSDateFormatter *inputFormatter = [NSDate sharedFormatter];
    [inputFormatter setDateFormat:format];
    NSDate *date = [inputFormatter dateFromString:string];
    inputFormatter=nil;
    return date;
}

/**
 格式化日期
 * 当天 HH:mm
 * 昨天 昨天 HH:mm
 * 当年 MM月dd日
 * 其他 yyyy年MM月dd日
 @return 格式化日期
 */
- (NSString *)formatDateString {
    NSDateFormatter *formatter = [NSDate sharedFormatter];
    
    if ([self isToday]) {
        formatter.dateFormat = @"HH:mm";
        return [formatter stringFromDate:self];
    } else if ([self isYesterday]) {
        formatter.dateFormat = @"昨天 HH:mm";
        return [formatter stringFromDate:self];
    } else if ([self isThisYear]) {
        formatter.dateFormat = @"MM月dd日";
        return [formatter stringFromDate:self];
    } else {
        formatter.dateFormat = @"yyyy年MM月dd日";
        return [formatter stringFromDate:self];
    }
}

/**
 两个时间的间隔(s)
 
 @param lastTime 时间1
 @param currentTime 时间2
 @return 时间间隔(s)
 */
+ (NSInteger)timeInterval:(NSDate *)lastTime currentTime:(NSDate *)currentTime {
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    //上次时间
    NSDate *lastDate = [lastTime dateByAddingTimeInterval:[timeZone secondsFromGMTForDate:lastTime]];
    //当前时间
    NSDate *currentDate = [currentTime dateByAddingTimeInterval:[timeZone secondsFromGMTForDate:currentTime]];
    //时间间隔
    NSInteger intevalTime = [currentDate timeIntervalSinceReferenceDate] - [lastDate timeIntervalSinceReferenceDate];
    return intevalTime;
}

/**
 格式化时间间隔
 
 * 小于1分钟 刚刚
 * 小于1小时 n分钟前
 * 小于1天   n小时前
 * 当年     MM月dd日
 * 其他     YYYY年MM月dd日
 
 @return 格式化后的时间间隔
 */
- (NSString *)formateForTimeInterval {
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    //上次时间
    NSDate *lastDate = [self dateByAddingTimeInterval:[timeZone secondsFromGMTForDate:self]];
    //当前时间
    NSDate *now = [NSDate date];
    NSDate *currentDate = [now dateByAddingTimeInterval:[timeZone secondsFromGMTForDate:now]];
    //时间间隔
    NSInteger intevalTime = [currentDate timeIntervalSinceReferenceDate] - [lastDate timeIntervalSinceReferenceDate];
    
    //秒、分、小时、天、月、年
    NSInteger minutes = intevalTime / 60;
    NSInteger hours = intevalTime / 60 / 60;
    
    if (minutes <= 1) {
        return  @"刚刚";
    } else if (minutes < 60) {
        return [NSString stringWithFormat: @"%ld分钟前",(long)minutes];
    } else if (hours < 24) {
        return [NSString stringWithFormat: @"%ld小时前",(long)hours];
    } else if ([self isThisYear]) {
        NSDateFormatter * df = [NSDate sharedFormatter];
        df.dateFormat = @"MM月dd日";
        NSString * time = [df stringFromDate:lastDate];
        return time;
    } else {
        NSDateFormatter * df = [NSDate sharedFormatter];
        df.dateFormat = @"YYYY年MM月dd日";
        NSString * time = [df stringFromDate:lastDate];
        return time;
    }
}

@end
