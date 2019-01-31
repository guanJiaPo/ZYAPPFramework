//
//  UINavigationBar+ZYCategory.m
//  ZYAPPFramework
//
//  Created by szy on 2019/1/31.
//  Copyright © 2019 szy. All rights reserved.
//

#import "UINavigationBar+ZYCategory.h"

@implementation UINavigationBar (ZYCategory)

/// 修改BarButtonItems点击范围
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 11.0) {
        return [super hitTest:point withEvent:event];
    }
    
    UIView *view = [super hitTest:point withEvent:event];
    if (point.x<= [UIScreen  mainScreen].bounds.size.width * 0.5) {
        for (UIBarButtonItem *buttonItem in self.topItem.leftBarButtonItems) {
            if (buttonItem.customView == nil) { continue; }
            UIButton *itemBtn = nil;
            if ([buttonItem.customView isKindOfClass:[UIButton class]]) {
                itemBtn = (UIButton *)buttonItem.customView;
            } else if ([buttonItem.customView isKindOfClass:[UIView class]]) {
                itemBtn = (UIButton *)buttonItem.customView.subviews.lastObject;
            }
            
            CGRect newRect = [itemBtn convertRect:[itemBtn hitFrame] toView:self];
            if (CGRectContainsPoint(newRect, point)) {
                view = itemBtn;
                break;
            }
        }
    } else {
        for (UIBarButtonItem *buttonItem in self.topItem.rightBarButtonItems) {
            if (buttonItem.customView == nil) { continue; }
            UIButton *itemBtn = nil;
            if ([buttonItem.customView isKindOfClass:[UIButton class]]) {
                itemBtn = (UIButton *)buttonItem.customView;
            } else if ([buttonItem.customView isKindOfClass:[UIView class]]) {
                itemBtn = (UIButton *)buttonItem.customView.subviews.lastObject;
            }
            CGRect newRect = [itemBtn convertRect:[itemBtn hitFrame] toView:self];
            if (CGRectContainsPoint(newRect, point)) {
                view = itemBtn;
                break;
            }
        }
    }
    return view;
}

@end
