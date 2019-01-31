//
//  UIImage+ZYCategory.h
//  ZYAPPFramework
//
//  Created by szy on 2019/1/31.
//  Copyright © 2019 szy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ZYCategory)

/// 根据颜色生成image
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/// 设置图片颜色
- (UIImage *)setTintColor:(UIColor *)tintColor;

/// 更改图片尺寸
- (UIImage *)resizeToSize:(CGSize)size;

/// 图片裁剪
- (UIImage *)cropToRect:(CGRect)rect;

///设置圆角
- (UIImage *)setCornerRadius:(CGFloat)radius;

/**
 设置圆角、边框
 
 @param radius 圆角值
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 @return 带圆角和边框的image
 */
- (UIImage *)setCornerRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 设置圆角、边框
 
 @param radius 圆角值
 @param corners 圆角位置
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 @return 带圆角和边框的image
 */
- (UIImage *)setCornerRadius:(CGFloat)radius corners:(UIRectCorner)corners borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 设置圆角、边框
 
 @param radius 圆角值
 @param corners 圆角位置
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 @param borderLineJoin 路径的连接点形状
 @return 带圆角和边框的image
 */
- (UIImage *)setCornerRadius:(CGFloat)radius corners:(UIRectCorner)corners borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor borderLineJoin:(CGLineJoin)borderLineJoin;

@end

NS_ASSUME_NONNULL_END
