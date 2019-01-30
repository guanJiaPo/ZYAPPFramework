//
//  ZYDefineConstants.h
//  ZYAPPFramework
//
//  Created by szy on 2019/1/21.
//  Copyright © 2019 szy. All rights reserved.
//

#import "ZYHTTPSessionManager.h"

@implementation ZYHTTPSessionManager

static ZYHTTPSessionManager *HTTPSessionManager = nil;

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        HTTPSessionManager = [[ZYHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:kNetWorkBaseUrl]];
    });
    return HTTPSessionManager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    if (HTTPSessionManager == nil) {
        HTTPSessionManager = [super allocWithZone:zone];
        HTTPSessionManager.requestSerializer.timeoutInterval = 30;
        /// 返回参数类型设置
        HTTPSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                          @"text/json",
                                                          @"text/plain",
                                                          @"text/javascript",
                                                          @"text/html",nil];
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
    return HTTPSessionManager;
}

- (id)copyWithZone:(NSZone *)zone {
    return HTTPSessionManager;
}


/**
 *  MARK: post 请求
 *
 *  @param url         请求路径
 *  @param parameters  请求参数
 *  @param success     请求成功的回调
 *  @param failure     请求失败的回调
 */
- (void)post:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id response))success failure:(void (^)(NSError *error))failure {
    
    if (!url || url.length <= 0) {
        return;
    }
    /// 转义URL中可能存在的中文字符
    url = [NSString urlEncode:url];
    [self setRequestHeader];
    [self POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DEBUGLog(@"\n===========response===========\n%@:\n%@", url, error);
        failure(error);
    }];
}

- (void)post:(ZYRequest *)request responseClass:(Class)clazz success:(void(^)(ZYResponse *response))success failure:(void (^)(NSError *error))failure {
    if (request.showLoading) {
        [MBProgressHUD showLoading:request.loadingMessage];
    }
    [self post:request.url parameters:request.parameters success:^(id response) {
        [MBProgressHUD hiddenLoading];
        if ([response isKindOfClass:[NSDictionary class]]) {
            ZYResponse *responseModel = [clazz mj_objectWithKeyValues:response];
            success(responseModel);
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hiddenLoading];
        failure(error);
    }];
}

- (void)post:(ZYRequest *)request success:(void(^)(id response))success failure:(void (^)(NSError *error))failure {
    if (request.showLoading) {
        [MBProgressHUD showLoading:request.loadingMessage];
    }
    [self post:request.url parameters:request.parameters success:^(id response) {
        [MBProgressHUD hiddenLoading];
        success(response);
    } failure:^(NSError *error) {
        [MBProgressHUD hiddenLoading];
        failure(error);
    }];
}

/**
 *  MARK: get 请求
 *
 *  @param url         请求路径
 *  @param parameters  请求参数
 *  @param success     请求成功的回调
 *  @param failure     请求失败的回调
 */
- (void)get:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id response))success failure:(void (^)(NSError *error))failure {
    
    if (!url || url.length <= 0) {
        return;
    }
    /// 转义URL中可能存在的中文字符
    url = [NSString urlEncode:url];
    [self setRequestHeader];
    [self GET:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DEBUGLog(@"\n===========response===========\n%@:\n%@", url, error);
        failure(error);
    }];
}

- (void)get:(ZYRequest *)request responseClass:(Class)clazz success:(void(^)(ZYResponse *response))success failure:(void (^)(NSError *error))failure {
    if (request.showLoading) {
        [MBProgressHUD showLoading:request.loadingMessage];
    }
    [self get:request.url parameters:request.parameters success:^(id response) {
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

- (void)get:(ZYRequest *)request success:(void(^)(id response))success failure:(void (^)(NSError *error))failure {
    if (request.showLoading) {
        [MBProgressHUD showLoading:request.loadingMessage];
    }
    [self get:request.url parameters:request.parameters success:^(id response) {
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
 *  上传文件
 *
 *  @param url        路径
 *  @param parameters 参数
 *  @param data       二进制文件
 *  @param fileKey    上传到服务器，接受此文件的字段名
 *  @param fileName   文件名称
 *  @param mimeType   文件类型
 *  @param success    成功回调
 *  @param failure    失败回调
 *  @param progress   上传进度
 */

- (void)uploadData:(NSString *)url parameters:(NSDictionary *)parameters data:(NSData *)data fileKey:(NSString *)fileKey fileName:(NSString *)fileName mimeType:(NSString *)mimeType progress:(void (^)(NSProgress *uploadProgress))progress success:(void (^)(id response))success failure:(void (^)(NSError *error))failure {
    url = [NSString urlEncode:url];
    [self setRequestHeader];
    [self POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (data) {
            [formData appendPartWithFileData:data name:fileKey fileName:fileName mimeType:mimeType];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        DEBUGLog(@"\n===========response===========\n%@:\n%@", url, error);
    }];
}

- (void)uploadData:(ZYRequest *)request data:(NSData *)data fileKey:(NSString *)fileKey fileName:(NSString *)fileName mimeType:(NSString *)mimeType progress:(void (^)(NSProgress *uploadProgress))progress success:(void(^)(id response))success failure:(void (^)(NSError *error))failure {
    if (request.showLoading) {
        [MBProgressHUD showLoading:request.loadingMessage];
    }
    [self uploadData:request.url parameters:request.parameters data:data fileKey:fileKey fileName:fileName mimeType:mimeType progress:^(NSProgress *uploadProgress) {
        progress(uploadProgress);
    } success:^(id response) {
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

- (void)uploadData:(ZYRequest *)request responseClass:(Class)clazz data:(NSData *)data fileKey:(NSString *)fileKey fileName:(NSString *)fileName mimeType:(NSString *)mimeType progress:(void (^)(NSProgress *uploadProgress))progress success:(void(^)(ZYResponse *response))success failure:(void (^)(NSError *error))failure {
    if (request.showLoading) {
        [MBProgressHUD showLoading:request.loadingMessage];
    }
    [self uploadData:request.url parameters:request.parameters data:data fileKey:fileKey fileName:fileName mimeType:mimeType progress:^(NSProgress *uploadProgress) {
        progress(uploadProgress);
    } success:^(id response) {
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
- (void)uploadImage:(UIImage *)image url:(NSString *)url parameters:(NSDictionary *)parameters fileKey:(NSString *)fileKey fileName:(NSString *)fileName progerss:(void (^)(NSProgress *progressValue))progress success:(void (^)(id response))success failure:(void (^)(NSError *error))failure {
    NSData *data = UIImageJPEGRepresentation(image, 1);
    // 开始post请求上传图像文件
    [self uploadData:url parameters:parameters data:data fileKey:fileKey fileName:fileName mimeType:@"image/jpeg" progress:progress success:success failure:failure];
}

- (void)uploadImage:(ZYRequest *)request image:(UIImage *)image fileKey:(NSString *)fileKey fileName:(NSString *)fileName progerss:(void (^)(NSProgress *progressValue))progress success:(void(^)(id response))success failure:(void (^)(NSError *error))failure {
    if (request.showLoading) {
        [MBProgressHUD showLoading:request.loadingMessage];
    }
    [self uploadImage:image url:request.url parameters:request.parameters fileKey:fileKey fileName:fileName progerss:^(NSProgress *progressValue) {
        progress(progressValue);
    } success:^(id responseObject) {
        if (request.showLoading) {
            [MBProgressHUD hiddenLoading];
        }
        success(responseObject);
    } failure:^(NSError *error) {
        if (request.showLoading) {
            [MBProgressHUD hiddenLoading];
        }
        failure(error);
    }];
}

- (void)uploadImage:(ZYRequest *)request responseClass:(Class)clazz image:(UIImage *)image fileKey:(NSString *)fileKey fileName:(NSString *)fileName progerss:(void (^)(NSProgress *progressValue))progress success:(void(^)(ZYResponse *response))success failure:(void (^)(NSError *error))failure {
    if (request.showLoading) {
        [MBProgressHUD showLoading:request.loadingMessage];
    }
    [self uploadImage:image url:request.url parameters:request.parameters fileKey:fileKey fileName:fileName progerss:^(NSProgress *progressValue) {
        progress(progressValue);
    } success:^(id responseObject) {
        if (request.showLoading) {
            [MBProgressHUD hiddenLoading];
        }
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            ZYResponse *responseModel = [clazz mj_objectWithKeyValues:responseObject];
            success(responseModel);
        }
    } failure:^(NSError *error) {
        if (request.showLoading) {
            [MBProgressHUD hiddenLoading];
        }
        failure(error);
    }];
}

+ (AFSecurityPolicy *)HTTPSSecurityPolicy {
    /// 先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"KSKD" ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    /// AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    /// allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    /// 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    /// validatesDomainName 是否需要验证域名，默认为YES；
    /// 假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    /// 置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    /// 如置为NO，建议自己添加对应域名的校验逻辑。
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
