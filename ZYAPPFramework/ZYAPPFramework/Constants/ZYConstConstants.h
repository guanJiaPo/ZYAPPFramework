//
//  ZYConstConstants.h
//  ZYAPPFramework
//
//  Created by szy on 2019/1/21.
//  Copyright © 2019 szy. All rights reserved.
//

/*************************** 静态常量 ***********************************/

#ifndef ZYConstConstants_h
#define ZYConstConstants_h

/********************* NSUserDefaults key ****************************/

/// 保存当前登录的用户名和密码 用于自动登录
static NSString *const kLoginAccountKey = @"kLoginAccountKey";
static NSString *const kLoginPassworkKey = @"kLoginPassworkKey";


/********************** Notification key **************************/

/// 登录
static NSString *const kLoginInNotification = @"kLoginInNotification";
/// 退出登录
static NSString *const kLoginOutNotification = @"kLoginOutNotification";


/********************** 常量 **************************/


#endif /* ZYConstConstants_h */
