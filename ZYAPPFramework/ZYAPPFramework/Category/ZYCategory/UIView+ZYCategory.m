//
//  UIView+ZYCategory.m
//  ZYAPPFramework
//
//  Created by szy on 2019/1/31.
//  Copyright © 2019 szy. All rights reserved.
//

#import "UIView+ZYCategory.h"

@implementation UIView (ZYCategory)

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

/// 当前试图所在的控制器
- (UIViewController *)controller {
    for (UIView *next = [self superview]; next; next = next.superview)
    {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

/******************** 分割线 ************************/

- (void)addTopBorder:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = borderColor.CGColor;
    border.frame = CGRectMake(0, 0, self.frame.size.width, borderWidth);
    [self.layer addSublayer:border];
}

- (void)addLeftBorder:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = borderColor.CGColor;
    border.frame = CGRectMake(0, 0, borderWidth, self.frame.size.height);
    [self.layer addSublayer:border];
}

- (void)addBottomBorder:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = borderColor.CGColor;
    border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, borderWidth);
    [self.layer addSublayer:border];
}

- (void)addRightBorder:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = borderColor.CGColor;
    border.frame = CGRectMake(self.frame.size.width - borderWidth, 0, borderWidth, self.frame.size.height);
    [self.layer addSublayer:border];
}

- (void)addCenterXBorder:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = borderColor.CGColor;
    border.frame = CGRectMake(0, (self.frame.size.height - 0.5) * 0.5, self.frame.size.width, borderWidth);
    [self.layer addSublayer:border];
}

- (void)addCenterYBorder:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = borderColor.CGColor;
    border.frame = CGRectMake((self.frame.size.width - 0.5) * 0.5, self.frame.size.height - borderWidth, self.frame.size.width, borderWidth);
    [self.layer addSublayer:border];
}

- (void)addBorder:(UIColor *)borderColor borderFrame:(CGRect)borderFrame {
    CALayer *border = [CALayer layer];
    border.backgroundColor = borderColor.CGColor;
    border.frame = borderFrame;
    [self.layer addSublayer:border];
}


/**
 * 设置全部圆角
 * view.frame不能为CGRectZero
 
 * @param cornerRadius 圆角值
 */
- (void)setCornerRadius:(CGFloat)cornerRadius {
    [self setCornerRadius:cornerRadius size:self.frame.size];
}

/**
 设置全部圆角
 
 @param cornerRadius 圆角值
 @param size 按钮尺寸
 */
- (void)setCornerRadius:(CGFloat)cornerRadius size:(CGSize)size {
    [self setCornerRadius:cornerRadius roundingCorner:UIRectCornerAllCorners size:size];
}

/**
 * 设置部分圆角
 * view.frame不能为CGRectZero
 
 @param cornerRadius 圆角值
 @param corner 圆角位置
 */
- (void)setCornerRadius:(CGFloat)cornerRadius roundingCorner:(UIRectCorner)corner {
    [self setCornerRadius:cornerRadius roundingCorner:corner size:self.frame.size];
}

/**
 设置部分圆角
 
 @param cornerRadius 圆角值
 @param corner 圆角位置
 @param size 按钮尺寸
 */
- (void)setCornerRadius:(CGFloat)cornerRadius roundingCorner:(UIRectCorner)corner size:(CGSize)size {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) byRoundingCorners:corner cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, size.width, size.height);
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

@end
