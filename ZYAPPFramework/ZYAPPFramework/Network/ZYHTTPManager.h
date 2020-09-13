//
//  ZYDefineConstants.h
//  ZYAPPFramework
//
//  Created by szy on 2019/1/21.
//  Copyright © 2019 szy. All rights reserved.
//

/**********************请求参数不再body中*************************/

#import "AFNetworking.h"

@interface ZYHTTPManager : AFHTTPSessionManager

+ (instancetype)shared;

//MARK: post

- (void)post:(NSString *)api parameters:(NSDictionary *)parameters showLoading:(BOOL)showLoading success:(void(^)(id response))success failure:(void (^)(NSError *error))failure;

- (void)post:(NSString *)api params:(NSDictionary *)params responseClass:(Class)clazz showLoading:(BOOL)showLoading success:(void(^)(ZYResponse *response))success failure:(void (^)(NSError *error))failure;

/**
 *  post 请求
 *
 *  @param request     请求对象（包含URL和参数）
 *  @param clazz       请求相应对象类名
 *  @param success     请求成功的回调
 *  @param failure     请求失败的回调
 */
- (void)post:(ZYRequest *)request responseClass:(Class)clazz success:(void(^)(ZYResponse *response))success failure:(void (^)(NSError *error))failure;

- (void)post:(ZYRequest *)request success:(void(^)(id response))success failure:(void (^)(NSError *error))failure;

//MARK: get

/// get请求：无参数，响应：id类型
- (void)get:(NSString *)api showLoading:(BOOL)showLoading success:(void (^)(id))success failure:(void (^)(NSError *))failure;
/// get请求：有参数，响应：id类型
- (void)get:(NSString *)api parameters:(NSDictionary *)parameters showLoading:(BOOL)showLoading success:(void(^)(id response))success failure:(void (^)(NSError *error))failure;
/// get请求：无参数，响应：responseClass类型
- (void)get:(NSString *)api responseClass:(Class)clazz showLoading:(BOOL)showLoading success:(void(^)(ZYResponse *response))success failure:(void (^)(NSError *error))failure;
/// get请求：有参数，响应：responseClass类型
- (void)get:(NSString *)api params:(NSDictionary *)params responseClass:(Class)clazz showLoading:(BOOL)showLoading success:(void(^)(ZYResponse *response))success failure:(void (^)(NSError *error))failure;

/**
 *  get 请求
 *
 *  @param request     请求对象（包含URL和参数）
 *  @param clazz       请求相应对象类名
 *  @param success     请求成功的回调
 *  @param failure     请求失败的回调
 */
- (void)get:(ZYRequest *)request responseClass:(Class)clazz success:(void(^)(ZYResponse *response))success failure:(void (^)(NSError *error))failure;

- (void)get:(ZYRequest *)request success:(void(^)(id response))success failure:(void (^)(NSError *error))failure;

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
