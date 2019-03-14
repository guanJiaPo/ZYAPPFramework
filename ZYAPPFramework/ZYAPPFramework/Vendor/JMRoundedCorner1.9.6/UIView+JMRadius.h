//
//  UIView+RoundedCorner.h
//  UIImageRoundedCornerDemo
//
//  Created by jm on 16/2/25.
//  Copyright © 2016年 Jim. All rights reserved.
//
//使用这个类就可以了

#import <UIKit/UIKit.h>
#import "UIImage+JMRadius.h"

@interface UIView (RoundedCorner)

typedef void (^JMRoundedCornerCompletionBlock)(UIImage * image);

#pragma mark UIView
/**设置圆角背景图，默认 UIViewContentModeScaleAspectFill 模式*/
- (void)jm_setImageWithCornerRadius:(CGFloat)radius
                              image:(UIImage *)image;

/**设置圆角背景图，默认 UIViewContentModeScaleAspectFill 模式*/
- (void)jm_setImageWithJMRadius:(JMRadius)radius
                          image:(UIImage *)image;

/**设置 contentMode 模式的圆角背景图*/
- (void)jm_setImageWithCornerRadius:(CGFloat)radius
                              image:(UIImage *)image
                        contentMode:(UIViewContentMode)contentMode;

/**设置 contentMode 模式的圆角背景图*/
- (void)jm_setImageWithJMRadius:(JMRadius)radius
                          image:(UIImage *)image
                    contentMode:(UIViewContentMode)contentMode;

/**设置圆角边框*/
- (void)jm_setImageWithCornerRadius:(CGFloat)radius
                        borderColor:(UIColor *)borderColor
                        borderWidth:(CGFloat)borderWidth
                    backgroundColor:(UIColor *)backgroundColor;

/**设置圆角边框*/
- (void)jm_setImageWithJMRadius:(JMRadius)radius
                    borderColor:(UIColor *)borderColor
                    borderWidth:(CGFloat)borderWidth
                backgroundColor:(UIColor *)backgroundColor;

/**配置所有属性配置圆角背景图*/
- (void)jm_setImageWithJMRadius:(JMRadius)radius
                          image:(UIImage *)image
                    borderColor:(UIColor *)borderColor
                    borderWidth:(CGFloat)borderWidth
                backgroundColor:(UIColor *)backgroundColor
                    contentMode:(UIViewContentMode)contentMode;


/**配置所有属性配置圆角背景图*/
- (void)jm_setImageWithJMRadius:(JMRadius)radius
                          image:(UIImage *)image
                    borderColor:(UIColor *)borderColor
                    borderWidth:(CGFloat)borderWidth
                backgroundColor:(UIColor *)backgroundColor
                    contentMode:(UIViewContentMode)contentMode
                           size:(CGSize)size
                     completion:(JMRoundedCornerCompletionBlock)completion;

#pragma mark UIButton

- (void)jm_setCornerRadius:(CGFloat)radius backgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
- (void)jm_setJMRadius:(JMRadius)radius backgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
- (void)jm_setCornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
- (void)jm_setJMRadius:(JMRadius)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
- (void)jm_setJMRadius:(JMRadius)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor size:(CGSize)size forState:(UIControlState)state;


- (void)jm_setImageWithCornerRadius:(CGFloat)radius image:(UIImage *)image forState:(UIControlState)state;
- (void)jm_setBackgroundImageWithCornerRadius:(CGFloat)radius image:(UIImage *)image forState:(UIControlState)state;

- (void)jm_setImageWithJMRadius:(JMRadius)radius image:(UIImage *)image forState:(UIControlState)state;
- (void)jm_setBackgroundImageWithJMRadius:(JMRadius)radius image:(UIImage *)image forState:(UIControlState)state;

- (void)jm_setImageWithCornerRadius:(CGFloat)radius image:(UIImage *)image contentMode:(UIViewContentMode)contentMode forState:(UIControlState)state;
- (void)jm_setBackgroundImageWithCornerRadius:(CGFloat)radius image:(UIImage *)image contentMode:(UIViewContentMode)contentMode forState:(UIControlState)state;

- (void)jm_setImageWithCornerRadius:(CGFloat)radius image:(UIImage *)image borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
- (void)jm_setBackgroundImageWithCornerRadius:(CGFloat)radius image:(UIImage *)image borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

- (void)jm_setImageWithJMRadius:(JMRadius)radius image:(UIImage *)image borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
- (void)jm_setBackgroundImageWithJMRadius:(JMRadius)radius image:(UIImage *)image borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

- (void)jm_setImageWithJMRadius:(JMRadius)radius image:(UIImage *)image borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor contentMode:(UIViewContentMode)contentMode size:(CGSize)size forState:(UIControlState)state;
- (void)jm_setBackgroundImageWithJMRadius:(JMRadius)radius image:(UIImage *)image borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor contentMode:(UIViewContentMode)contentMode size:(CGSize)size forState:(UIControlState)state;

- (void)jm_setImageWithJMRadius:(JMRadius)radius image:(UIImage *)image borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor contentMode:(UIViewContentMode)contentMode size:(CGSize)size forState:(UIControlState)state  completion:(JMRoundedCornerCompletionBlock)completion;
- (void)jm_setBackgorundImageWithJMRadius:(JMRadius)radius image:(UIImage *)image borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor contentMode:(UIViewContentMode)contentMode size:(CGSize)size forState:(UIControlState)state completion:(JMRoundedCornerCompletionBlock)completion;

@end
