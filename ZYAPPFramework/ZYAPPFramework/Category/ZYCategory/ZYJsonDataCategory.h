//
//  ZYJsonDataCategory.h
//  ZYAPPFramework
//
//  Created by szy on 2019/1/31.
//  Copyright © 2019 szy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface NSArray (ZYJson)

/// 转换成JSON串字符串
- (NSString *)toJSONString;

/// JSON字符串转成数组
+ (NSArray *)fromJSONString:(NSString *)jsonString;

/// 转换成二进制数据
- (NSData *)toJSONData;

@end

@interface NSDictionary (ZYJson)

/// 转换成JSON串字符串
- (NSString *)toJSONString;

/// JSON字符串转成字典
+ (NSDictionary *)fromJSONString:(NSString *)jsonString;

/// 转换成二进制数据
- (NSData *)toJSONData;

@end

NS_ASSUME_NONNULL_END
