//
//  ZYNetworkManager+ZYCategory.h
//  SuiTong
//
//  Created by 石志愿 on 2020/9/13.
//  Copyright © 2020 石志愿. All rights reserved.
//

#import "ZYNetworkManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZYNetworkManager (ZYCategory)


- (void)post:(ZYRequest *)request responseClass:(Class)clazz success:(void(^)(ZYResponse *response))success failure:(void (^)(NSError *error))failure;

- (void)post:(ZYRequest *)request success:(void(^)(id response))success failure:(void (^)(NSError *error))failure;


- (void)get:(ZYRequest *)request responseClass:(Class)clazz success:(void(^)(ZYResponse *response))success failure:(void (^)(NSError *error))failure;

- (void)get:(ZYRequest *)request success:(void(^)(id response))success failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
