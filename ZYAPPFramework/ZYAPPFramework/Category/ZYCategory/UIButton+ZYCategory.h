//
//  UIButton+ZYCategory.h
//  ZYAPPFramework
//
//  Created by szy on 2019/1/31.
//  Copyright © 2019 szy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ZYButtonImagePosition) {
    /// 左图右字
    ZYButtonImagePositionLeft = 0,
    /// 右图左字
    ZYButtonImagePositionRight,
    /// 上图下字
    ZYButtonImagePositionTop,
    /// 下图上字
    ZYButtonImagePositionBottom,
};

@interface UIButton (ZYCategory)

/// 设置背景色
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

/**
 * 调整图片位置
 * 文字与图片的间距 5
 
 * @param style 图片位置
 */
- (void)adjustImagePosition:(ZYButtonImagePosition)style;

/**
 * 调整图片方向

 * @param style 图片位置
 * @param space 文字与图片的间距
 */
- (void)adjustImagePosition:(ZYButtonImagePosition)style space:(CGFloat)space;

/**
 * 自定义响应边界
 * 如：UIEdgeInsetsMake(-3, -4, -5, -6) 表示扩大点击范围
 */
@property(nonatomic, assign) UIEdgeInsets hitEdgeInsets;

/// 有效点击范围
- (CGRect)hitFrame;

@end

NS_ASSUME_NONNULL_END
