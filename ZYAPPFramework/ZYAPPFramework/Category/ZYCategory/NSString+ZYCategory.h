//
//  NSString+ZYCategory.h
//  ZYAPPFramework
//
//  Created by szy on 2019/1/21.
//  Copyright © 2019 szy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (ZYCategory)

/// 字符串是否为空
+ (BOOL)isEmpty:(NSString *)string;

/// 文本大小
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

/// 前缀
- (BOOL)hasPrefixes:(NSArray*)prefixes;

/// 后缀
- (BOOL)hasSufixes:(NSArray *)sufixes;

/// 是否为手机号码(模糊匹配)
- (BOOL)isPhone;
/// 是否为邮箱
- (BOOL)isEmail;

/// 是否为身份证号码
- (BOOL)isIdCard;

/// 是否为纯数字
- (BOOL)isPureNumber;

/// 是否为纯字母
- (BOOL)isPureLetters;
/// 只包含数字和字母
- (BOOL)isPureNumberOrLetters;

/// 只包含数字和 .
- (BOOL)isPureNumbersOrPoint;

/// 正则匹配用户密码6-18位数字和字母组合
- (BOOL)checkPasswordFor6_18;

/// 是否包含表情
- (BOOL)isContainsEmoji;

/// 千位分割
+ (NSString *)stringFormatterBehavior10_4:(NSInteger)number;

/// base64加密
+ (NSString *)encodeForBase64:(NSString *)string;

/// base64解密
+ (NSString *)dencodeForBase64:(NSString *)base64String;

/// url中文及特殊字符转码
+ (NSString *)urlEncode:(NSString *)originalStr;

/// 转拼音
- (NSString *)pinyin;
/// 首字母
- (NSString *)firstLetter;

/// md5加密
- (NSString *)md5;

@end

NS_ASSUME_NONNULL_END
