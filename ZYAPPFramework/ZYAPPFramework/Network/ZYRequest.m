//
//  ZYDefineConstants.h
//  ZYAPPFramework
//
//  Created by szy on 2019/1/21.
//  Copyright © 2019 szy. All rights reserved.
//

#import "ZYRequest.h"

@implementation ZYRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.showLoading = true;
        self.loadingMessage = @"";
        self.scheme = @"https";
        self.host = kNetWorkBaseUrl;
        self.port = @"";
    }
    return self;
}

- (NSString *)url {
    if (![NSString isEmpty:self.api]) {
        
        if([[self host] rangeOfString:@"http"].location != NSNotFound) {
            NSString *url = [NSString stringWithFormat:@"%@%@%@%@", [self host], [NSString isEmpty:[self port]] ? @"" : @":", [self port], [self api]];
            
            return url;
        } else {
            NSString *url = [NSString stringWithFormat:@"%@://%@%@%@%@", [self scheme], [self host], [NSString isEmpty:[self port]] ? @"" : @":", [self port], [self api]];
            
            return url;
        }
    }
    
    return self.api;
}

- (NSDictionary *)parameters {
    /// 1. 获取请求对象的所有property
    NSMutableDictionary *parame = [self mj_keyValues];
    
    /// 2. 去除KDRequest的property
    NSMutableArray *proNames = [NSMutableArray array];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([ZYRequest class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [proNames addObject:propertyName];
    }
    free(properties);
    [parame removeObjectsForKeys:proNames];
    
    /// 3. 去除子类中不需要作为请求参数的property
    NSArray *theTransients = [[self class] transients];
    if (theTransients.count) {
        [parame removeObjectsForKeys:theTransients];
    }
    
    return parame;
}

+ (NSArray *)transients {
    return [NSArray array];
}

@end
