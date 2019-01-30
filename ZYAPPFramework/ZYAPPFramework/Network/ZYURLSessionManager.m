//
//  ZYDefineConstants.h
//  ZYAPPFramework
//
//  Created by szy on 2019/1/21.
//  Copyright © 2019 szy. All rights reserved.
//

#import "ZYURLSessionManager.h"

@interface ZYURLSessionManager ()

@end

@implementation ZYURLSessionManager

static ZYURLSessionManager * URLSessionManager = nil;

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        URLSessionManager = [[ZYURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    return URLSessionManager;
}

- (id)copyWithZone:(NSZone *)zone {
    return URLSessionManager;
}


+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    if (URLSessionManager == nil) {
        URLSessionManager = [super allocWithZone:zone];
        AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
        responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                     @"text/html",
                                                     @"text/json",
                                                     @"text/javascript",
                                                     @"text/plain",
                                                     nil];
        URLSessionManager.responseSerializer = responseSerializer;
    }
    return URLSessionManager;
}

/**
 *  异步请求
 
 *  @param method      请求方式
 *  @param url         请求url
 *  @param parameters  请求参数
 *  @param body        body数据
 *  @param success     成功回调
 *  @param failure     失败回调
 */
- (void)requestWithMethod:(KDRequestMethod)method url:(NSString *)url parameters:(NSDictionary *)parameters body:(NSData *)body success:(void(^)(id response))success failure:(void(^)(NSError *error))failure
{
    /// 转义URL中可能存在的中文字符
    url = [NSString urlEncode:url];
    NSString *httpMethod = @"";
    switch (method) {
        case KDRequestMethodPost:
            httpMethod = @"POST";
            break;
        case KDRequestMethodGet:
            httpMethod = @"GET";
            break;
        case KDRequestMethodPatch:
            httpMethod = @"PATCH";
            break;
        case KDRequestMethodPut:
            httpMethod = @"PUT";
            break;
        default:
            break;
    }
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:httpMethod URLString:url parameters:parameters error:nil];
    
    request.timeoutInterval= 30.f;
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:body];
    [self setRequestHeader:request];
    [[self dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                success(responseObject);
            }
            
        } else {
            failure(error);
            DEBUGLog(@"\n===========response===========\n%@:\n%@", url, error);
        }
    }] resume];
}

/**
 *  异步请求
 
 *  @param method      请求方式
 *  @param url         请求的url
 *  @param parameters  请求参数
 *  @param success     成功回调
 *  @param failure     失败回调
 */
- (void)requestWithMethod:(KDRequestMethod)method url:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id response))success failure:(void (^)(NSError *error))failure {
    [self requestWithMethod:method url:url parameters:parameters body:nil success:success failure:^(NSError *error) {
        failure(error);
        DEBUGLog(@"\n===========response===========\n%@\n%@\n%@", url,parameters, error);
    }];
}

/**
 *  异步请求
 
 *  @param request     请求对象（包含URL和参数）
 *  @param method      请求方式
 *  @param clazz       请求相应对象类名
 *  @param success     成功回调
 *  @param failure     失败回调
 */
- (void)request:(ZYRequest *)request method:(KDRequestMethod)method responseClass:(Class)clazz success:(void(^)(ZYResponse *response))success failure:(void (^)(NSError *error))failure {
    if (request.showLoading) {
        [MBProgressHUD showLoading:request.loadingMessage];
    }
    [self requestWithMethod:method url:request.url parameters:request.parameters success:^(id response) {
        if (request.showLoading) {
            [MBProgressHUD hiddenLoading];
        }
        if ([response isKindOfClass:[NSDictionary class]]) {
            ZYResponse *responseModel = [clazz mj_objectWithKeyValues:response];
            success(responseModel);
        }
    } failure:^(NSError *error) {
        if (request.showLoading) {
            [MBProgressHUD hiddenLoading];
        }
        failure(error);
    }];
}

/**
 *  异步请求
 
 *  @param request     请求对象（包含URL和参数）
 *  @param method      请求方式
 *  @param success     成功回调
 *  @param failure     失败回调
 */
- (void)request:(ZYRequest *)request method:(KDRequestMethod)method success:(void(^)(id response))success failure:(void (^)(NSError *error))failure {
    if (request.showLoading) {
        [MBProgressHUD showLoading:request.loadingMessage];
    }
    [self requestWithMethod:method url:request.url parameters:request.parameters success:^(ZYResponse *response) {
        if (request.showLoading) {
            [MBProgressHUD hiddenLoading];
        }
        success(response);
    } failure:^(NSError *error) {
        if (request.showLoading) {
            [MBProgressHUD hiddenLoading];
        }
        failure(error);
    }];
}

/**
 *  post请求
 
 *  @param request     请求对象（包含URL和参数）
 *  @param clazz       请求相应对象类名
 *  @param success     成功回调
 *  @param failure     失败回调
 */
- (void)post:(ZYRequest *)request responseClass:(Class)clazz success:(void(^)(ZYResponse *response))success failure:(void (^)(NSError *error))failure {
    [self request:request method:KDRequestMethodPost responseClass:clazz success:success failure:failure];
}

/**
 *  post请求
 
 *  @param request     请求对象（包含URL和参数）
 *  @param success     成功回调
 *  @param failure     失败回调
 */
- (void)post:(ZYRequest *)request success:(void(^)(id response))success failure:(void (^)(NSError *error))failure {
    [self request:request method:KDRequestMethodPost success:success failure:failure];
}

/**
 *  get请求
 
 *  @param request     请求对象（包含URL和参数）
 *  @param clazz       请求相应对象类名
 *  @param success     成功回调
 *  @param failure     失败回调
 */
- (void)get:(ZYRequest *)request responseClass:(Class)clazz success:(void (^)(ZYResponse * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    [self request:request method:KDRequestMethodGet responseClass:clazz success:success failure:failure];
}

/**
 *  get请求
 
 *  @param request     请求对象（包含URL和参数）
 *  @param success     成功回调
 *  @param failure     失败回调
 */
- (void)get:(ZYRequest *)request success:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    [self request:request method:KDRequestMethodGet success:success failure:failure];
}


/// 设置请求头
- (void)setRequestHeader:(NSMutableURLRequest *)request {
    NSString *token = @"";
    if (![NSString isEmpty:token]) {
        [request setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField: @"Authorization"];
    }
}
@end
