//
//  ZYNetworkConstants.h
//  ZYAPPFramework
//
//  Created by sogubaby on 2019/1/30.
//  Copyright © 2019 szy. All rights reserved.
//

#ifndef ZYNetworkConstants_h
#define ZYNetworkConstants_h

/// 测试环境接口域名
static NSString *const kNetWorkDomain_dev = @"";
/// 线上环境接口域名
static NSString *const kNetWorkDomain_dis = @"";

#ifdef DEBUG

//#define kNetWorkBaseUrl kNetWorkDomain_dev
#define kNetWorkBaseUrl kNetWorkDomain_dis

#else
#define kNetWorkBaseUrl kNetWorkDomain_dis
#endif

#import "ZYRequest.h"
#import "ZYResponse.h"
#import "ZYHTTPManager.h"
#import "ZYNetworkManager.h"

//日后删除，使用ZYNetworkManager替代
#import "ZYURLSessionManager.h"

#endif /* ZYNetworkConstants_h */
