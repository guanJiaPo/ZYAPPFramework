//
//  ZYNetworkManager+ZYCategory.m
//  SuiTong
//
//  Created by 石志愿 on 2020/9/13.
//  Copyright © 2020 石志愿. All rights reserved.
//

#import "ZYNetworkManager+ZYCategory.h"

@implementation ZYNetworkManager (ZYCategory)

- (void)post:(ZYRequest *)request responseClass:(Class)clazz success:(void(^)(ZYResponse *response))success failure:(void (^)(NSError *error))failure {
    [self post:request.api parameters:request.parameters showLoading:request.showLoading loadingMessage:request.loadingMessage openLog: request.openLog success:^(id response) {
        if ([response isKindOfClass:[NSDictionary class]]) {
            ZYResponse *responseModel = [clazz mj_objectWithKeyValues:response];
            success(responseModel);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)post:(ZYRequest *)request success:(void(^)(id response))success failure:(void (^)(NSError *error))failure {
    [self post:request.api parameters:request.parameters showLoading:request.showLoading loadingMessage:request.loadingMessage openLog: request.openLog success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)get:(ZYRequest *)request responseClass:(Class)clazz success:(void(^)(ZYResponse *response))success failure:(void (^)(NSError *error))failure {
    [self get:request.api parameters:request.parameters showLoading:request.showLoading loadingMessage:request.loadingMessage openLog: request.openLog success:^(id response) {
        if ([response isKindOfClass:[NSDictionary class]]) {
            ZYResponse *responseModel = [clazz mj_objectWithKeyValues:response];
            success(responseModel);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)get:(ZYRequest *)request success:(void(^)(id response))success failure:(void (^)(NSError *error))failure {
    [self get:request.api parameters:request.parameters showLoading:request.showLoading loadingMessage:request.loadingMessage openLog: request.openLog success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
