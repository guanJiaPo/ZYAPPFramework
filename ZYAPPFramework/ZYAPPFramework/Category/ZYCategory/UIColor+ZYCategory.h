//
//  UIColor+ZYCategory.h
//  ZYAPPFramework
//
//  Created by szy on 2019/1/31.
//  Copyright © 2019 szy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (ZYCategory)

/// 如：0xaabbcc
+ (UIColor *)colorWithRGB:(uint32_t)rgbValue;

/// 如：0xaabbccdd
+ (UIColor *)colorWithRGBA:(uint32_t)rgbaValue;

/// 如：0xaabbcc 0.5
+ (UIColor *)colorWithRGB:(uint32_t)rgbValue alpha:(CGFloat)alpha;

/// 如：F0F, FF00FF, FF00FF33, 0xF0F, 0xFF00FF, 0xFF00FF33, #F0F, #FF00FF, #FF00FF33
+ (UIColor *)colorWithHexString:(NSString *)hexStr;

@end

NS_ASSUME_NONNULL_END
