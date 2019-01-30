//
//  ZYUser.m
//  ZYAPPFramework
//
//  Created by szy on 2019/1/21.
//  Copyright © 2019 szy. All rights reserved.
//

#import "ZYUser.h"

@implementation ZYUser

#pragma mark public

+ (ZYUser *)loginUser {
    
    
    return nil;
}

+ (BOOL)isLogining {
    return false;
}

- (void)saveOrUpdateUser {
    ZYUser *user = [ZYUser findFirstWithFormat:@"WHERE userid = %@",self.userid];
    if (user) {
        /// 数据库已存在此用户，更新用户信息
        self.pk = user.pk;
    }
    [self saveOrUpdate];
}


@end
