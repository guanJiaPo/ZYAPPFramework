//
//  MBProgressHUD+ZYCategory.h
//  ZYAPPFramework
//
//  Created by szy on 2019/1/30.
//  Copyright © 2019 szy. All rights reserved.
//

#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (ZYCategory)

/// 显示loading到keyWindow
+ (MBProgressHUD *)showLoading;
/// 显示loading信息到keyWindow
+ (MBProgressHUD *)showLoading:(nullable NSString *)message;
/// 显示loading信息
+ (MBProgressHUD *)showLoading:(nullable NSString *)message toView:(nullable UIView *)view;

/// 隐藏loading
+ (BOOL)hiddenLoading;
/// 隐藏loading
+ (BOOL)hiddenFromView:(nullable UIView *)view;

/// 显示提示信息和icon到keyWindow
+ (void)showMessage:(nullable NSString *)text icon:(nullable NSString *)icon;
/// 显示提示信息和icon
+ (void)showMessage:(nullable NSString *)text icon:(nullable NSString *)icon toView:(nullable UIView *)view;

@end

NS_ASSUME_NONNULL_END
