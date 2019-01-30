//
//  ZYDefineConstants.h
//  ZYAPPFramework
//
//  Created by szy on 2019/1/21.
//  Copyright © 2019 szy. All rights reserved.
//

#import "AFNetworking.h"

typedef enum : NSUInteger {
    KDRequestMethodPost = 0,
    KDRequestMethodGet,
    KDRequestMethodPatch,
    KDRequestMethodPut,
} KDRequestMethod;

NS_ASSUME_NONNULL_BEGIN

@interface ZYURLSessionManager : AFURLSessionManager


+ (instancetype)shared;

/**
 *  post请求
 
 *  @param request     请求对象（包含URL和参数）
 *  @param clazz       请求相应对象类名
 *  @param success     成功回调
 *  @param failure     失败回调
 */
- (void)post:(ZYRequest *)request responseClass:(Class)clazz success:(void(^)(ZYResponse *response))success failure:(void (^)(NSError *error))failure;

/**
 *  post请求
 
 *  @param request     请求对象（包含URL和参数）
 *  @param success     成功回调
 *  @param failure     失败回调
 */
- (void)post:(ZYRequest *)request success:(void(^)(id response))success failure:(void (^)(NSError *error))failure;

/**
 *  get请求
 
 *  @param request     请求对象（包含URL和参数）
 *  @param clazz       请求相应对象类名
 *  @param success     成功回调
 *  @param failure     失败回调
 */
- (void)get:(ZYRequest *)request responseClass:(Class)clazz success:(void(^)(ZYResponse *response))success failure:(void (^)(NSError *error))failure;

/**
 *  get请求
 
 *  @param request     请求对象（包含URL和参数）
 *  @param success     成功回调
 *  @param failure     失败回调
 */
- (void)get:(ZYRequest *)request success:(void(^)(id response))success failure:(void (^)(NSError *error))failure;

/**
 *  异步请求
 
 *  @param request     请求对象（包含URL和参数）
 *  @param method      请求方式
 *  @param clazz       请求相应对象类名
 *  @param success     成功回调
 *  @param failure     失败回调
 */
- (void)request:(ZYRequest *)request method:(KDRequestMethod)method responseClass:(Class)clazz success:(void(^)(ZYResponse *response))success failure:(void (^)(NSError *error))failure;

/**
 *  异步请求
 
 *  @param request     请求对象（包含URL和参数）
 *  @param method      请求方式
 *  @param success     成功回调
 *  @param failure     失败回调
 */
- (void)request:(ZYRequest *)request method:(KDRequestMethod)method success:(void(^)(id response))success failure:(void (^)(NSError *error))failure;

/**
 *  异步请求
 
 *  @param method      请求方式
 *  @param url         请求的url
 *  @param parameters  请求参数
 *  @param success     成功回调
 *  @param failure     失败回调
 */
- (void)requestWithMethod:(KDRequestMethod)method url:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id response))success failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
