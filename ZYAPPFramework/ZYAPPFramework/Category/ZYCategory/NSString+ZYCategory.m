//
//  NSString+ZYCategory.m
//  ZYAPPFramework
//
//  Created by szy on 2019/1/21.
//  Copyright © 2019 szy. All rights reserved.
//

#import "NSString+ZYCategory.h"
#import "sys/utsname.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (ZYCategory)

/// 字符串是否为空
+ (BOOL)isEmpty:(NSString *)string {
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    
    if (!string || [string isKindOfClass:[NSNull class]] || string.length == 0 || [string isEqualToString:@""] || [string isEqualToString:@"null"] || [string isEqualToString:@"(null)"]) {
        return YES;
    } else {
        return NO;
    }
}

/// 文本大小
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    if ([NSString isEmpty:self]) {
        return CGSizeZero;
    }
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
}

/// 前缀
- (BOOL)hasPrefixes:(NSArray*)prefixes {
    if ([NSString isEmpty:self]) {
        return false;
    }
    for(NSString *prefix in prefixes) {
        if([self hasPrefix:prefix])
            return YES;
    }
    return NO;
}

/// 后缀
- (BOOL)hasSufixes:(NSArray *)sufixes {
    if ([NSString isEmpty:self]) {
        return false;
    }
    for (NSString *sufix in sufixes) {
        if([self hasSuffix:sufix]){
            return YES;
        }
    }
    return NO;
}

/// 是否为手机号码(模糊匹配)
- (BOOL)isPhone {
    if ([NSString isEmpty:self]) {
        return false;
    }
    NSString *phoneRegex = @"1[0-9][0-9]{9}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

/// 是否为邮箱
- (BOOL)isEmail {
    if ([NSString isEmpty:self]) {
        return false;
    }
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

/// 是否为身份证号码
- (BOOL)isIdCard {
    if ([NSString isEmpty:self]) {
        return false;
    }

    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}

/// 是否为纯数字
- (BOOL)isPureNumber {
    if ([NSString isEmpty:self]) {
        return false;
    }
    NSString *regex = @"[0-9]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}

/// 是否为纯字母
- (BOOL)isPureLetters {
    if ([NSString isEmpty:self]) {
        return false;
    }
    NSString *regex = @"[a-zA-Z]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}

/// 只包含数字和字母
- (BOOL)isPureNumberOrLetters {
    if ([NSString isEmpty:self]) {
        return false;
    }
    NSString *regex = @"[a-zA-Z0-9]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}

/// 只包含数字和.
- (BOOL)isPureNumbersOrPoint {
    if ([NSString isEmpty:self]) {
        return false;
    }
    NSString *regex = @"[0-9.]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}

/// n-m位数字和字母组合
- (BOOL)checkNumOrLetStrForN:(NSInteger)n toM:(NSInteger)m {
    if ([NSString isEmpty:self]) {
        return false;
    }
    if (n > m) {
        NSInteger temp = n;
        n = m;
        m = temp;
    }
    NSString *pattern = [NSString stringWithFormat: @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{%td,%td}",n,m];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

/// 是否包含中文
- (BOOL)isContainsChinese {
    if ([NSString isEmpty:self]) {
        return false;
    }
    for(int i = 0; i < self.length; i++){
        int a = [self characterAtIndex:i];
        if (a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

/// 是否包含表情
- (BOOL)isContainsEmoji {
    if ([NSString isEmpty:self]) {
        return false;
    }
    __block BOOL returnValue = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    returnValue = YES;
                }
            }
        } else if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3) {
                returnValue = YES;
            }
        } else {
            if (0x2100 <= hs && hs <= 0x27ff) {
                returnValue = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                returnValue = YES;
            }
        }
    }];
    
    return returnValue;
}

/// 去掉两端的空格
- (NSString *)stringByTrim {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

/// 千位分割
+ (NSString *)stringFormatterBehavior10_4:(NSInteger)number {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setFormatterBehavior: NSNumberFormatterBehavior10_4];
    [numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
    return [numberFormatter stringFromNumber:[NSNumber numberWithInteger:number]];
}

/// url中文及特殊字符转码
+ (NSString *)urlEncode:(NSString *)originalStr {
//    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)originalStr, (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",NULL,kCFStringEncodingUTF8));
    
    NSString *charactersToEscape = @"!$&'()*+,-./:;=?@_~%#[]";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *encodedString = [originalStr stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return encodedString;
}

/// 转换成二进制数据
- (NSData *)toData {
    if ([NSString isEmpty:self]) {
        return nil;
    }
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

/// base64加密
+ (NSString *)encodeForBase64:(NSString *)string {
    if ([NSString isEmpty:string]) {
        return nil;
    }
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [data base64EncodedStringWithOptions:0];
    return base64String;
}

/// base64解密
+ (NSString *)dencodeForBase64:(NSString *)base64String {
    if ([NSString isEmpty:base64String]) {
        return nil;
    }
    NSData *data = [[NSData alloc]initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    return string;
}

/// md5加密
- (NSString *)md5 {
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest ); // This is the md5 call --- 32位小写
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return  output;
}

/// 转拼音
- (NSString *)pinyin {
    NSMutableString *source = [self mutableCopy];
    //转化为带声调的拼音
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformMandarinLatin, NO);
    //转化为不带声调
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformStripCombiningMarks, NO);
    //去除空格
    return [source stringByReplacingOccurrencesOfString:@" " withString:@""];
}

/// 首字母
- (NSString *)firstLetter {
    NSString *pinyin = [self pinyin];
    if (![NSString isEmpty:pinyin]) {
        NSString *first = [pinyin substringWithRange:NSMakeRange(0, 1)];
        if ([first isPureLetters]) {
            return first.uppercaseString;
        }
        return @"#";
    }
    return @"#";
}

@end
