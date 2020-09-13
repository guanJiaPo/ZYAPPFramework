//
//  ZYDefineConstants.h
//  ZYAPPFramework
//
//  Created by szy on 2019/1/21.
//  Copyright © 2019 szy. All rights reserved.
//

#import "ZYHTTPManager.h"

@implementation ZYHTTPManager

static ZYHTTPManager *_httpManager = nil;

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _httpManager = [[ZYHTTPManager alloc]initWithBaseURL:[NSURL URLWithString:kNetWorkBaseUrl]];
    });
    return _httpManager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    if (_httpManager == nil) {
        _httpManager = [super allocWithZone:zone];
        _httpManager.requestSerializer.timeoutInterval = 30;
        // 返回参数类型设置
        _httpManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain", @"text/javascript", @"text/html",nil];
        /**
         @"Accept" : @"application/json",
         @"Content-Type" : @"text/html",
         @"Data-Type" : @"json",
         @"Accept-Encoding" : @"gzip",
         @"Content-Encoding" : @"gzip",
         */
        //    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        //    [self.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
        /// self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    }
    return _httpManager;
}

- (id)copyWithZone:(NSZone *)zone {
    return _httpManager;
}

//MARK: post

- (void)post:(NSString *)api params:(NSDictionary *)params responseClass:(Class)clazz showLoading:(BOOL)showLoading success:(void(^)(ZYResponse *response))success failure:(void (^)(NSError *error))failure {
    [self post:api parameters:params showLoading:showLoading loadingMessage:nil openLog: YES success:^(id response) {
        if ([response isKindOfClass:[NSDictionary class]]) {
            ZYResponse *responseModel = [clazz mj_objectWithKeyValues:response];
            success(responseModel);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)post:(NSString *)api parameters:(NSDictionary *)parameters showLoading:(BOOL)showLoading success:(void(^)(id response))success failure:(void (^)(NSError *error))failure {
    [self post:api parameters:parameters showLoading:showLoading loadingMessage:nil openLog:YES success:success failure:failure];
}

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

- (void)post:(NSString *)api parameters:(NSDictionary *)parameters showLoading:(BOOL)showLoading loadingMessage:(NSString *)loadingMessage openLog: (BOOL)openLog success:(void(^)(id response))success failure:(void (^)(NSError *error))failure {
    
    if (!api || api.length <= 0) {
        return;
    }
    NSString *url = [NSString stringWithFormat:@"%@%@", kNetWorkBaseUrl, api];
    // 转义URL中可能存在的中文字符
    url = [NSString urlEncode:url];
    [self setRequestHeader];
    if (openLog) {
        DEBUGLog(@"\n ==request:\n%@:\n%@", url, parameters);
    }
    if (showLoading) {
        [MBProgressHUD showLoading:loadingMessage];
    }
    [self POST:api parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hiddenLoading];
        success(responseObject);
        if (openLog) {
            DEBUGLog(@"\n ==response :\n%@:\n%@", url, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hiddenLoading];
        failure(error);
        DEBUGLog(@"\n ==response error:\n%@:\n%@", url, error);
    }];
}

//MARK: get

- (void)get:(NSString *)api params:(NSDictionary *)params responseClass:(Class)clazz showLoading:(BOOL)showLoading success:(void(^)(ZYResponse *response))success failure:(void (^)(NSError *error))failure {
    [self get:api parameters:params showLoading:showLoading loadingMessage:nil openLog: YES success:^(id response) {
        if ([response isKindOfClass:[NSDictionary class]]) {
            ZYResponse *responseModel = [clazz mj_objectWithKeyValues:response];
            success(responseModel);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)get:(NSString *)api responseClass:(Class)clazz showLoading:(BOOL)showLoading success:(void(^)(ZYResponse *response))success failure:(void (^)(NSError *error))failure {
    [self get:api responseClass:clazz showLoading:showLoading success:success failure:failure];
}

- (void)get:(NSString *)api showLoading:(BOOL)showLoading success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [self get:api parameters:nil showLoading:YES loadingMessage:nil openLog:YES success:success failure:failure];
}

- (void)get:(NSString *)api parameters:(NSDictionary *)parameters showLoading:(BOOL)showLoading success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [self get:api parameters:parameters showLoading:YES loadingMessage:nil openLog:YES success:success failure:failure];
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

/**
*  get 请求
*
*  @param api            请求路径
*  @param parameters     请求参数
*  @param showLoading    是否显示loading
*  @param loadingMessage loading信息
*  @param success        请求成功的回调
*  @param failure        请求失败的回调
*/
- (void)get:(NSString *)api parameters:(NSDictionary *)parameters showLoading:(BOOL)showLoading loadingMessage:(NSString *)loadingMessage openLog: (BOOL)openLog success:(void(^)(id response))success failure:(void (^)(NSError *error))failure {
    
    if (!api || api.length <= 0) {
        return;
    }
    NSString *url = [NSString stringWithFormat:@"%@%@", kNetWorkBaseUrl, api];
    // 转义URL中可能存在的中文字符
    url = [NSString urlEncode:url];
    [self setRequestHeader];
    if (openLog) {
        DEBUGLog(@"\n ==request:\n%@:\n%@", url, parameters);
    }
    if (showLoading) {
        [MBProgressHUD showLoading:loadingMessage];
    }
    [self GET:api parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hiddenLoading];
        success(responseObject);
        if (openLog) {
            DEBUGLog(@"\n ==response :\n%@:\n%@", url, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DEBUGLog(@"\n===========response===========\n%@:\n%@", url, error);
        [MBProgressHUD hiddenLoading];
        failure(error);
    }];
}


//MARK: 上传文件

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

- (void)uploadData:(NSString *)api parameters:(NSDictionary *)parameters datas:(NSArray *)datas fileKey:(NSString *)fileKey fileName:(NSString *)fileName mimeType:(NSString *)mimeType showLoading:(BOOL)showLoading loadingMessage:(NSString *)loadingMessage openLog: (BOOL)openLog  progress:(void (^)(NSProgress *uploadProgress))progress success:(void (^)(id response))success failure:(void (^)(NSError *error))failure {
    if (!api || api.length <= 0) {
        return;
    }
    NSString *url = [NSString stringWithFormat:@"%@%@", kNetWorkBaseUrl, api];
    // 转义URL中可能存在的中文字符
    url = [NSString urlEncode:url];
    [self setRequestHeader];
    if (showLoading) {
        [MBProgressHUD showLoading:loadingMessage];
    }
    if (openLog) {
        DEBUGLog(@"\n ==request:\n%@:\n%@", url, parameters);
    }
    [self POST:api parameters:parameters headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < datas.count; i ++) {
            NSData *data = datas[i];
            NSString *file = [NSString stringWithFormat:@"%@_%d",fileName, i];
            [formData appendPartWithFileData:data name:fileKey fileName:file mimeType:mimeType];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hiddenLoading];
        success(responseObject);
        if (openLog) {
            DEBUGLog(@"\n ==response :\n%@:\n%@", url, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hiddenLoading];
        failure(error);
        DEBUGLog(@"\n===========response===========\n%@:\n%@", url, error);
    }];
}

- (void)uploadData:(ZYRequest *)request data:(NSData *)data fileKey:(NSString *)fileKey fileName:(NSString *)fileName mimeType:(NSString *)mimeType progress:(void (^)(NSProgress *uploadProgress))progress success:(void(^)(id response))success failure:(void (^)(NSError *error))failure {
    if (data == nil) {
        return;
    }
    [self uploadData:request.api parameters:request.parameters datas:@[data] fileKey:fileKey fileName:fileName mimeType:mimeType showLoading:request.showLoading loadingMessage:request.loadingMessage openLog:request.openLog progress:^(NSProgress *uploadProgress) {
        progress(uploadProgress);
    } success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)uploadData:(ZYRequest *)request responseClass:(Class)clazz data:(NSData *)data fileKey:(NSString *)fileKey fileName:(NSString *)fileName mimeType:(NSString *)mimeType progress:(void (^)(NSProgress *uploadProgress))progress success:(void(^)(ZYResponse *response))success failure:(void (^)(NSError *error))failure {
    if (data == nil) {
        return;
    }
    [self uploadData:request.api parameters:request.parameters datas:@[data] fileKey:fileKey fileName:fileName mimeType:mimeType showLoading:request.showLoading loadingMessage:request.loadingMessage openLog:request.openLog progress:^(NSProgress *uploadProgress) {
        progress(uploadProgress);
    } success:^(id response) {
        if ([response isKindOfClass:[NSDictionary class]]) {
            ZYResponse *responseModel = [clazz mj_objectWithKeyValues:response];
            success(responseModel);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

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
- (void)uploadImage:(UIImage *)image url:(NSString *)url parameters:(NSDictionary *)parameters fileKey:(NSString *)fileKey fileName:(NSString *)fileName showLoading:(BOOL)showLoading loadingMessage:(NSString *)loadingMessage progerss:(void (^)(NSProgress *progressValue))progress success:(void (^)(id response))success failure:(void (^)(NSError *error))failure {
    NSData *data = UIImageJPEGRepresentation(image, 1);
    // 开始post请求上传图像文件
    [self uploadData:url parameters:parameters datas:@[data] fileKey:fileKey fileName:fileName mimeType:@"image/jpeg" showLoading:showLoading loadingMessage:loadingMessage openLog:YES progress:progress success:success failure:failure];
}

- (void)uploadImage:(ZYRequest *)request image:(UIImage *)image fileKey:(NSString *)fileKey fileName:(NSString *)fileName progerss:(void (^)(NSProgress *progressValue))progress success:(void(^)(id response))success failure:(void (^)(NSError *error))failure {
    [self uploadImage:image url:request.api parameters:request.parameters fileKey:fileKey fileName:fileName showLoading:request.showLoading loadingMessage:request.loadingMessage progerss:^(NSProgress *progressValue) {
        progress(progressValue);
    } success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)uploadImage:(ZYRequest *)request responseClass:(Class)clazz image:(UIImage *)image fileKey:(NSString *)fileKey fileName:(NSString *)fileName progerss:(void (^)(NSProgress *progressValue))progress success:(void(^)(ZYResponse *response))success failure:(void (^)(NSError *error))failure {
    [self uploadImage:image url:request.api parameters:request.parameters fileKey:fileKey fileName:fileName showLoading:request.showLoading loadingMessage:request.loadingMessage progerss:^(NSProgress *progressValue) {
        progress(progressValue);
    } success:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            ZYResponse *responseModel = [clazz mj_objectWithKeyValues:responseObject];
            success(responseModel);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (AFSecurityPolicy *)HTTPSSecurityPolicy {
    // 先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"SuiTong" ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    // validatesDomainName 是否需要验证域名，默认为YES；
    // 假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    // 置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    // 如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    if (certData) {
        securityPolicy.pinnedCertificates = [NSSet setWithObject:certData];
    }
    
    return securityPolicy;
}

/// 设置请求头
- (void)setRequestHeader {
    NSString *token = @"";
    if (![NSString isEmpty:token]) {
        [self.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
    }
}

@end
