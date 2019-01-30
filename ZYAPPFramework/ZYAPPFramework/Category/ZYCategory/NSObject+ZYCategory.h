//
//  NSObject+ZYCategory.h
//  ZYAPPFramework
//
//  Created by szy on 2019/1/30.
//  Copyright © 2019 szy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (ZYCategory)

@end

@interface NSObject (ZYController)

/// 获取当前选中的导航控制器最顶层控制器
- (UIViewController*)topController;

/// 获取当前显示的ViewController
- (UIViewController*)appearController;

/// 设备安全区
+ (UIEdgeInsets)safeAreaInsets;

/// 设备虚拟home键高度
+ (CGFloat)safeAreaBottom;

@end

@interface NSObject (ZYShowTip)

/// 显示提示信息
- (void)showTip:(NSString *)text;

/// 网络请求失败
- (void)showNetworkFailed;

@end


NS_ASSUME_NONNULL_END
