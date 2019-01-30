//
//  ZYBaseController.h
//  ZYAPPFramework
//
//  Created by szy on 2019/1/21.
//  Copyright © 2019 szy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYBaseController : UIViewController

/// 隐藏状态栏 默认false
@property (nonatomic, assign) BOOL statusBarHidden;

/// 重写导航栏返回按钮
- (void)resetBackItem;

@end

NS_ASSUME_NONNULL_END
