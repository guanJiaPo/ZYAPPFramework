//
//  ZYSystem.h
//  ZYAPPFramework
//
//  Created by szy on 2019/1/31.
//  Copyright © 2019 szy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYSystem : NSObject

/// app版本(appstore展示的版本号)
+ (NSString *)appVersion;

/// app build版本
- (NSString *)appBuildVersion;

/// 系统版本
+ (NSString *)systemVersion;

/// 手机型号
+ (NSString *)currentDevice;

/// bundle id
+ (NSString *)bundleIdentifier;

/// 系统名称
+ (NSString *)systemName;

/// 手机品牌规则：手机型号_系统版本##手机品牌(iPhone 6 plus_9.3.2##iPhone)
+ (NSString *)pbrand;

/// 获取设备mac物理地址(比较耗时)
+ (NSString *)getMacAddress;
/// 设备物理地址（随机生成）
+ (NSString *)macArcAddress;

/// 获取设备当前网络IP地址
+ (NSString *)getIPAddress:(BOOL)preferIPv4;

/// iOS 8 以上是否开启通知
+ (BOOL)isAllowedRemoteNotification;

/// idfv (uuid)
+ (NSString *)idfvString;

/// 相机是否权限
+ (BOOL)cameraAccessAuthorized;

/// 照片(相册)是否权限
+ (BOOL)photoLibraryAccessAuthorized;

/// 发短信权限
+ (BOOL)canSendSMS;

/// 打电话权限
+ (BOOL)canMakePhoneCall;

/// 调用打电话功能（此种方法会直接进行拨打电话,电话结束后会留在电话界面）
+ (void)openTelphone:(NSString *)phone;

/// 调用打电话功能（此种方法会询问是否拨打电话,电话结束后会返回到应用界面,但是有上架App Store被拒的案例）
+ (void)openTelpromptPhone:(NSString *)phone;

/// 调用发短信功能（此种方法会直接跳转到给指定号码发送短信,短信结束后会留在短信界面）
+ (void)openSendSMSWithPhone:(NSString *)phone;

/// 跳转到定位服务
+ (void)openLocationService;

/*********************** 沙盒路径 **********************/

+ (NSString *)documentsPath;
+ (NSURL *)documentsURL;

+ (NSString *)cachesPath;
+ (NSURL *)cachesURL;

+ (NSString *)libraryPath;
+ (NSURL *)libraryURL;


@end

NS_ASSUME_NONNULL_END
