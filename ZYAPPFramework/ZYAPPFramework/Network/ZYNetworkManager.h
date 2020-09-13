//
//  ZYNetworkManager.h
//  SuiTong
//
//  Created by 石志愿 on 2020/9/13.
//  Copyright © 2020 石志愿. All rights reserved.
//

/**********************请求参数在body中*************************/

#import "AFNetworking.h"

typedef enum : NSUInteger {
    ZYRequestMethodPost = 0,
    ZYRequestMethodGet,
    ZYRequestMethodPatch,
    ZYRequestMethodPut,
} ZYRequestMethod;

@interface ZYNetworkManager : AFHTTPSessionManager

+ (instancetype)shared;

//MARK: post(请求参数在body中)

/// respSuccess: 接口请求成功，即code=200
- (void)post:(NSString *)api params:(NSDictionary *)params responseClass:(Class)clazz showLoading:(BOOL)showLoading respSuccess:(void(^)(ZYResponse *response))respSuccess;
- (void)post:(NSString *)api parameters:(NSDictionary *)parameters showLoading:(BOOL)showLoading success:(void(^)(id response))success failure:(void (^)(NSError *error))failure;

- (void)post:(NSString *)api params:(NSDictionary *)params responseClass:(Class)clazz showLoading:(BOOL)showLoading success:(void(^)(ZYResponse *response))success failure:(void (^)(NSError *error))failure;

- (void)post:(NSString *)api parameters:(NSDictionary *)parameters showLoading:(BOOL)showLoading loadingMessage:(NSString *)loadingMessage openLog: (BOOL)openLog success:(void(^)(id response))success failure:(void (^)(NSError *error))failure;


//MARK: get (请求参数不在body中)

/// 有参数 respSuccess: 接口请求成功，即code=200
- (void)get:(NSString *)api params:(NSDictionary *)params responseClass:(Class)clazz showLoading:(BOOL)showLoading respSuccess:(void(^)(ZYResponse *response))respSuccess;
/// 无参数 respSuccess: 接口请求成功，即code=200
- (void)get:(NSString *)api responseClass:(Class)clazz showLoading:(BOOL)showLoading respSuccess:(void(^)(ZYResponse *response))respSuccess;

/// get请求：无参数，响应：id类型
- (void)get:(NSString *)api showLoading:(BOOL)showLoading success:(void (^)(id))success failure:(void (^)(NSError *))failure;
/// get请求：有参数，响应：id类型
- (void)get:(NSString *)api parameters:(NSDictionary *)parameters showLoading:(BOOL)showLoading success:(void(^)(id response))success failure:(void (^)(NSError *error))failure;
/// get请求：无参数，响应：responseClass类型
- (void)get:(NSString *)api responseClass:(Class)clazz showLoading:(BOOL)showLoading success:(void(^)(ZYResponse *response))success failure:(void (^)(NSError *error))failure;
/// get请求：有参数，响应：responseClass类型
- (void)get:(NSString *)api params:(NSDictionary *)params responseClass:(Class)clazz showLoading:(BOOL)showLoading success:(void(^)(ZYResponse *response))success failure:(void (^)(NSError *error))failure;

- (void)get:(NSString *)api parameters:(NSDictionary *)parameters showLoading:(BOOL)showLoading loadingMessage:(NSString *)loadingMessage openLog: (BOOL)openLog success:(void(^)(id response))success failure:(void (^)(NSError *error))failure;

/// 请求参数放在body中
- (void)request:(ZYRequestMethod)method api:(NSString *)api parameters:(NSDictionary *)parameters showLoading:(BOOL)showLoading loadingMessage:(NSString *)loadingMessage openLog: (BOOL)openLog success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

/**
 *  上传文件
 *
 *  @param api        路径
 *  @param parameters 参数
 *  @param datas       二进制文件
 *  @param fileKey    上传到服务器，接受此文件的字段名
 *  @param fileName   文件名称
 *  @param mimeType   文件类型
 *  @param success    成功回调
 *  @param failure    失败回调
 *  @param progress   上传进度
 */

- (void)uploadData:(NSString *)api parameters:(NSDictionary *)parameters datas:(NSArray *)datas fileKey:(NSString *)fileKey fileName:(NSString *)fileName mimeType:(NSString *)mimeType showLoading:(BOOL)showLoading loadingMessage:(NSString *)loadingMessage openLog: (BOOL)openLog  progress:(void (^)(NSProgress *uploadProgress))progress success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

- (void)uploadData:(ZYRequest *)request responseClass:(Class)clazz data:(NSData *)data fileKey:(NSString *)fileKey fileName:(NSString *)fileName mimeType:(NSString *)mimeType progress:(void (^)(NSProgress *uploadProgress))progress success:(void(^)(ZYResponse *response))success failure:(void (^)(NSError *error))failure;

- (void)uploadData:(ZYRequest *)request data:(NSData *)data fileKey:(NSString *)fileKey fileName:(NSString *)fileName mimeType:(NSString *)mimeType progress:(void (^)(NSProgress *uploadProgress))progress success:(void(^)(id response))success failure:(void (^)(NSError *error))failure;

/**
 *  上传图片
 *
 *  @param image    图片
 *  @param url      路径
 *  @param fileKey  上传到服务器，接受此图片的字段名
 *  @param fileName 图片名称
 *  @param success  成功回调
 *  @param failure  失败回调
 *  @param progress 上传进度
 */
- (void)uploadImage:(UIImage *)image url:(NSString *)url parameters:(NSDictionary *)parameters fileKey:(NSString *)fileKey fileName:(NSString *)fileName showLoading:(BOOL)showLoading loadingMessage:(NSString *)loadingMessage progerss:(void (^)(NSProgress *progressValue))progress success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

- (void)uploadImage:(ZYRequest *)request responseClass:(Class)clazz image:(UIImage *)image fileKey:(NSString *)fileKey fileName:(NSString *)fileName progerss:(void (^)(NSProgress *progressValue))progress success:(void(^)(ZYResponse *response))success failure:(void (^)(NSError *error))failure;

- (void)uploadImage:(ZYRequest *)request image:(UIImage *)image fileKey:(NSString *)fileKey fileName:(NSString *)fileName progerss:(void (^)(NSProgress *progressValue))progress success:(void(^)(id response))success failure:(void (^)(NSError *error))failure;

@end
