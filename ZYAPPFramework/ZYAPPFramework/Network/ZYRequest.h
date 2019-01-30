//
//  ZYDefineConstants.h
//  ZYAPPFramework
//
//  Created by szy on 2019/1/21.
//  Copyright © 2019 szy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYRequest : NSObject

/// 域名
@property (nonatomic, copy ) NSString *host;

/// 协议 http 或 https 默认https
@property (nonatomic, copy ) NSString *scheme;

/// 端口
@property (nonatomic, copy ) NSString *port;

/// 含域名的完整接口地址
@property (nonatomic, copy, readonly) NSString *url;

/// 不含域名的相对接口地址
@property (nonatomic, copy) NSString *api;

/// 是否显示加载动画 默认true
@property (nonatomic, assign) BOOL showLoading;

/// 加载动画提示语 showLoading为true时有效 默认: “加载中...”
@property (nonatomic, copy  ) NSString *loadingMessage;

/// 请求参数，默认子类的所有property（不含KDRequest本类的property）
- (NSDictionary *)parameters;

/// 如果子类中有一些property不需要作为请求参数，那么在子类中重新该方法，返回不需要作为请求参数的property名称
+ (NSArray *)transients;

@end

NS_ASSUME_NONNULL_END
