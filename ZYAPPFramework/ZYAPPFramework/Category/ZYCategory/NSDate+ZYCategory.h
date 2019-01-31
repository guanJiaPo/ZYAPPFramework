//
//  NSDate+ZYCategory.h
//  ZYAPPFramework
//
//  Created by szy on 2019/1/31.
//  Copyright © 2019 szy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (ZYCategory)

/// 年
- (NSInteger)year;
/// 月
- (NSInteger)month;
/// 日
- (NSInteger)day;
/// 时
- (NSInteger)hour;
/// 分
- (NSInteger)minute;
/// 秒
- (NSInteger)second;

/// 星期几（1 ~ 7）
- (NSInteger)weekDay;
///周几（周一 ~ 周日）
- (NSString *)weekDayString;

/// 是否为今天
- (BOOL)isToday;
/// 是否为昨天
- (BOOL)isYesterday;
/// 是否为今年
- (BOOL)isThisYear;

/// 格式化字符串
- (NSString *)stringWithFormat:(NSString *)format;

/**
 根据格式化字符串返回日期
 
 @param string 字符串
 @param format 格式化规则
 @return 日期
 */
+ (NSDate *)dateFromString:(NSString *)string format:(NSString *)format;

/**
 格式化日期
 * 当天 HH:mm
 * 昨天 昨天 HH:mm
 * 当年 MM月dd日
 * 其他 yyyy年MM月dd日
 @return 格式化日期
 */
- (NSString *)formatDateString;

/**
 两个时间的间隔(s)
 
 @param lastTime 时间1
 @param currentTime 时间2
 @return 时间间隔(s)
 */
+ (NSInteger)timeInterval:(NSDate *)lastTime currentTime:(NSDate *)currentTime;

/**
 格式化时间间隔
 
 * 小于1分钟 刚刚
 * 小于1小时 n分钟前
 * 小于1天   n小时前
 * 当年     MM月dd日
 * 其他     YYYY年MM月dd日
 
 @return 格式化后的时间间隔
 */
- (NSString *)formateForTimeInterval;

@end

NS_ASSUME_NONNULL_END
