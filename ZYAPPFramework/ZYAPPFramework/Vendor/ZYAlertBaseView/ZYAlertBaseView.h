//
//  ZYAlertBaseView.h
//  PE
//
//  Created by sogubaby on 2018/11/8.
//  Copyright © 2018年 zhupeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    /// 弹框在底部
    ZYAlertViewStyleBottom = 0,
    /// 弹框在中间
    ZYAlertViewStyleCenter,
} ZYAlertViewStyle;

@interface ZYAlertBaseView : UIView

/// 子视图需要放到contentView上
@property (nonatomic, weak, readonly) UIView *contentView;

@property (nonatomic, assign, readonly) ZYAlertViewStyle style;

/// 点击空白区域隐藏试图，默认 true
@property (nonatomic, assign) BOOL bgCancel;

/// contentView 水平方向左右间距 默认0
@property (nonatomic, assign) NSInteger horizontalSpace;

/// 添加到keyWindow，动画弹出
- (void)presentToWindow;

/// 添加到父视图，动画弹出
- (void)presentToView:(UIView *)superView;

/// 动画弹出(已经添加到父视图)
- (void)showView;

/// 动画消失 不从父视图移除
- (void)hiddenView;
/// 动画消失 不从父视图移除
- (void)hiddenViewCompletion:(void(^ __nullable)(void))completion;

/// 动画消失 从父视图移除
- (void)dismissView;

/// 动画消失 先调用completion再从父视图移除
- (void)dismissViewCompletion:(void(^ __nullable)(void))completion;

/// contentHeight: 内容高度 style: 弹窗显示位置
- (instancetype)initWithContentHeight:(CGFloat)contentHeight style:(ZYAlertViewStyle)style;

@end
