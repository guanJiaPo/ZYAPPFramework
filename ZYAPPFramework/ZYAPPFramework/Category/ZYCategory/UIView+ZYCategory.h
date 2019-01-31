//
//  UIView+ZYCategory.h
//  ZYAPPFramework
//
//  Created by szy on 2019/1/31.
//  Copyright © 2019 szy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ZYCategory)

@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize  size;

/// 当前试图所在的控制器
- (UIViewController *)controller;

/******************** 分割线 ************************/

- (void)addTopBorder:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

- (void)addBottomBorder:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

- (void)addLeftBorder:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

- (void)addRightBorder:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

- (void)addCenterXBorder:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

- (void)addCenterYBorder:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

- (void)addBorder:(UIColor *)borderColor borderFrame:(CGRect)borderFrame;

/******************** 圆角 ************************/

/**
 * 设置全部圆角
 * view.frame不能为CGRectZero
 
 * @param cornerRadius 圆角值
 */
- (void)setCornerRadius:(CGFloat)cornerRadius;

/**
 设置全部圆角
 
 @param cornerRadius 圆角值
 @param size 按钮尺寸
 */
- (void)setCornerRadius:(CGFloat)cornerRadius size:(CGSize)size;

/**
 * 设置部分圆角
 * view.frame不能为CGRectZero
 
 @param cornerRadius 圆角值
 @param corner 圆角位置
 */
- (void)setCornerRadius:(CGFloat)cornerRadius roundingCorner:(UIRectCorner)corner;

/**
 设置部分圆角
 
 @param cornerRadius 圆角值
 @param corner 圆角位置
 @param size 按钮尺寸
 */
- (void)setCornerRadius:(CGFloat)cornerRadius roundingCorner:(UIRectCorner)corner size:(CGSize)size;

- (void)setCornerRadius:(CGFloat)cornerRadius roundingCorner:(UIRectCorner)corner size:(CGSize)size borderColor:(UIColor *)borderColor;

@end

NS_ASSUME_NONNULL_END
