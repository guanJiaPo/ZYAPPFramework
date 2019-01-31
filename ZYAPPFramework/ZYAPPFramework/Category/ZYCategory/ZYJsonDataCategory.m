//
//  ZYJsonDataCategory.m
//  ZYAPPFramework
//
//  Created by szy on 2019/1/31.
//  Copyright © 2019 szy. All rights reserved.
//

#import "ZYJsonDataCategory.h"

@implementation NSArray (ZYJson)

/// 转换成JSON串字符串
- (NSString *)toJSONString {
    NSData *data = [self toJSONData];
    
    if (data == nil) {
        return nil;
    }
    
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}

/// JSON字符串转成数组
+ (NSArray *)fromJSONString:(NSString *)jsonString {
    if ([NSString isEmpty:jsonString]) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    if (jsonData == nil) {
        return nil;
    }
    NSError *err;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if (err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return array;
}

/// 转换成二进制数据
- (NSData *)toJSONData {
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        return nil;
    }
    return data;
}

@end



@implementation NSDictionary (ZYJson)

/// 转成JSON字符串
- (NSString *)toJSONString {
    NSData *data = [self toJSONData];
    if (data == nil) {
        return nil;
    }
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}

/// JSON字符串转成字典
+ (NSDictionary *)fromJSONString:(NSString *)jsonString {
    if ([NSString isEmpty:jsonString]) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    if (jsonData == nil) {
        return nil;
    }
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if (err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

/// 转换成二进制数据
- (NSData *)toJSONData {
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        return nil;
    }
    return data;
}

@end
