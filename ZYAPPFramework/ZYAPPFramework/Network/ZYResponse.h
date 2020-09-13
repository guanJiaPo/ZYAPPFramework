//
//  ZYDefineConstants.h
//  ZYAPPFramework
//
//  Created by szy on 2019/1/21.
//  Copyright © 2019 szy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYResponse : NSObject

@property (nonatomic, assign, readonly) BOOL success;

/// 200为成功,其他都为失败
@property (nonatomic, assign) NSInteger code;
/// 提示信息
@property (nonatomic, copy  ) NSString *message;

@property (nonatomic, assign) NSTimeInterval time;

@property (nonatomic, assign) NSInteger pageCount;

@end

NS_ASSUME_NONNULL_END
