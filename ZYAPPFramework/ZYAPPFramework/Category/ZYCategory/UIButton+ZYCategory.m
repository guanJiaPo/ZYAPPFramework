//
//  UIButton+ZYCategory.m
//  ZYAPPFramework
//
//  Created by szy on 2019/1/31.
//  Copyright © 2019 szy. All rights reserved.
//

#import "UIButton+ZYCategory.h"

@implementation UIButton (ZYCategory)

/// 设置背景色
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    
    [self setBackgroundImage:[UIImage imageWithColor:backgroundColor] forState:state];
}

/**
 * 调整图片位置
 * 文字与图片的间距 5
 
 * @param style 图片位置
 */
- (void)adjustImagePosition:(ZYButtonImagePosition)style {
    [self adjustImagePosition:style space:5];
}

/**
 * 调整图片方向
 
 * @param style 图片位置
 * @param space 文字与图片的间距
 */
- (void)adjustImagePosition:(ZYButtonImagePosition)style space:(CGFloat)space {
    UIImageView *imageView = self.imageView;
    UILabel *label = self.titleLabel;
    CGFloat imageWidth = imageView.intrinsicContentSize.width;
    CGFloat imageHeight = imageView.intrinsicContentSize.height;
    CGFloat labelWidth = label.intrinsicContentSize.width;
    CGFloat labelHeight = label.intrinsicContentSize.height;
    
    switch (style) {
        case ZYButtonImagePositionTop:
            self.imageEdgeInsets = UIEdgeInsetsMake(-labelHeight - space/2, 0, 0, -labelWidth);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, -imageHeight - space/2, 0);
            break;
        case ZYButtonImagePositionLeft:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -space/2, 0, space/2);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, space/2, 0, -space/2);
            break;
        case ZYButtonImagePositionBottom:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight - space/2, -labelWidth);
            self.titleEdgeInsets = UIEdgeInsetsMake(-imageHeight - space/2, -imageWidth, 0, 0);
            break;
        case ZYButtonImagePositionRight:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + space/2, 0, -labelWidth - space/2);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth - space/2, 0, imageWidth + space/2);
            break;
        default:
            break;
    }
}


static const char * kHitEdgeInsets  = "hitEdgeInsets";

- (UIEdgeInsets)hitEdgeInsets {
    NSValue *value = objc_getAssociatedObject(self, kHitEdgeInsets);
    UIEdgeInsets edgeInsets;
    [value getValue:&edgeInsets];
    return value ? edgeInsets:UIEdgeInsetsZero;
}

- (void)setHitEdgeInsets:(UIEdgeInsets)hitEdgeInsets {
    NSValue *value = [NSValue value:&hitEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self,kHitEdgeInsets, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGRect)hitFrame {
    return CGRectMake(self.bounds.origin.x + self.hitEdgeInsets.left,
                      self.bounds.origin.y + self.hitEdgeInsets.top,
                      self.bounds.size.width - self.hitEdgeInsets.left - self.hitEdgeInsets.right,
                      self.bounds.size.height - self.hitEdgeInsets.top - self.hitEdgeInsets.bottom);
}

#pragma mark - override super method

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    //如果 button 边界值无变化  失效 隐藏 或者透明 直接返回
    if(!self.userInteractionEnabled || !self.enabled || self.hidden || self.alpha < 0.01) {
        return [super pointInside:point withEvent:event];
    } else {
        return CGRectContainsPoint([self hitFrame], point);
    }
}

@end
