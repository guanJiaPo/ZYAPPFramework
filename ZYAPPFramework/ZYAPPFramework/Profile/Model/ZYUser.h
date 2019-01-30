//
//  ZYUser.h
//  ZYAPPFramework
//
//  Created by szy on 2019/1/21.
//  Copyright © 2019 szy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYUser : JKDBModel

@property (nonatomic, copy  ) NSString *userid;

/// 当前登录的用户信息
+ (ZYUser *)loginUser;

/// 用户是否登录
+ (BOOL)isLogining;

/// 保存或更新数据库的用户信息
- (void)saveOrUpdateUser;


@end

NS_ASSUME_NONNULL_END
