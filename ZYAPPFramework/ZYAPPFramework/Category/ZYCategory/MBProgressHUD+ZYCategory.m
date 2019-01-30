//
//  MBProgressHUD+ZYCategory.m
//  ZYAPPFramework
//
//  Created by szy on 2019/1/30.
//  Copyright © 2019 szy. All rights reserved.
//

#import "MBProgressHUD+ZYCategory.h"

@implementation MBProgressHUD (ZYCategory)

+ (MBProgressHUD *)showLoading {
    return [self showLoading:nil];
}

+ (MBProgressHUD *)showLoading:(nullable NSString *)message {
    return [self showLoading:message toView:nil];
}

+ (BOOL)hiddenLoading {
    return [self hiddenFromView:nil];
}

+ (MBProgressHUD *)showLoading:(nullable NSString *)message toView:(nullable UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    hud.label.font = [UIFont systemFontOfSize:14];
    hud.removeFromSuperViewOnHide = YES;
//    hud.dimBackground = NO;
    return hud;
}

+ (BOOL)hiddenFromView:(nullable UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    return [MBProgressHUD hideHUDForView:view animated:YES];
}

/// 显示提示信息和icon
+ (void)showMessage:(nullable NSString *)text icon:(nullable NSString *)icon toView:(nullable UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:true afterDelay:2];
}

/// 显示提示信息和icon到keyWindow
+ (void)showMessage:(nullable NSString *)text icon:(nullable NSString *)icon {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.label.text = text;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:true afterDelay:2];
}

@end
