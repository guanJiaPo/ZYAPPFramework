//
//  NSObject+ZYCategory.m
//  ZYAPPFramework
//
//  Created by szy on 2019/1/30.
//  Copyright © 2019 szy. All rights reserved.
//

#import "NSObject+ZYCategory.h"

@implementation NSObject (ZYCategory)

@end


@implementation NSObject (ZYController)

/// 获取当前选中的导航控制器最顶层控制器
- (UIViewController*)topController {
    
    ZYTabBarController *rootVC = (ZYTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    ZYNavigationController *naVC = (ZYNavigationController *)rootVC.selectedViewController;
    return naVC.topViewController;
}

/// 获取当前显示的ViewController
- (UIViewController*)appearController {
    //获得当前活动窗口的根视图
    UIViewController* currentController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1) {
        //根据不同的页面切换方式，逐步取得最上层的viewController
        if ([currentController isKindOfClass:[UITabBarController class]]) {
            currentController = ((UITabBarController*)currentController).selectedViewController;
        }
        if ([currentController isKindOfClass:[UINavigationController class]]) {
            currentController = ((UINavigationController*)currentController).visibleViewController;
        }
        if (currentController.presentedViewController) {
            currentController = currentController.presentedViewController;
        } else {
            break;
        }
    }
    return currentController;
}

/// 设备安全区
+ (UIEdgeInsets)safeAreaInsets {
    if (@available(iOS 11.0, *)) {
        return [UIApplication sharedApplication].keyWindow.safeAreaInsets;
    } else {
        return UIEdgeInsetsZero;
    }
}

/// 设备虚拟home键高度
+ (CGFloat)safeAreaBottom {
    if (@available(iOS 11.0, *)) {
        return [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;
    } else {
        return 0;
    }
}

@end


@implementation NSObject (ZYShowTip)

/// 显示提示信息
- (void)showTip:(NSString *)text {
    if ([NSString isEmpty:text]) {
        return;
    }
    [SVProgressHUD setOffsetFromCenter:UIOffsetMake(0, 0)];
    [SVProgressHUD setFont:[UIFont systemFontOfSize:16]];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.7]];
    [SVProgressHUD setForegroundColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]];
    [SVProgressHUD setCornerRadius:5];
    //        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setMinimumDismissTimeInterval:2];
    [SVProgressHUD showImage:nil status:text];
}

/// 网络请求失败
- (void)showNetworkFailed {
    [self showTip:@"网络请求失败"];
}

@end
