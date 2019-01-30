//
//  UEEmptyView.h
//  EmptyViewTest
//
//  Created by 石志愿 on 2018/7/12.
//  Copyright © 2018年 石志愿. All rights reserved.
//

#import "LYEmptyView.h"

@interface ZYEmptyView : LYEmptyView

/// mark - 默认空数据样式

+ (instancetype)defaultEmptyViewWithTarget:(id)target action:(SEL)action;
+ (instancetype)defaultEmptyViewWithAction:(LYActionTapBlock)actionBlock;

/// mark - 无网络
+ (instancetype)emptyViewForNoNetworkWithTarget:(id)target action:(SEL)action;
+ (instancetype)emptyViewForNoNetworkWithAction:(LYActionTapBlock)actionBlock;

/// mark - 自定义

+ (instancetype)emptyViewWithImageName:(NSString *)imageName detail:(NSString *) detail;

+ (instancetype)emptyViewWithImage:(UIImage *)image detail:(NSString *) detail;

+ (instancetype)emptyViewWithImageName:(NSString *)imageName title:(NSString *)title detail:(NSString *) detail;

+ (instancetype)emptyViewWithImageName:(NSString *)imageName detail:(NSString *) detail offsetY:(CGFloat)offsetY;

+ (instancetype)emptyViewWithImageName:(NSString *)imageName title:(NSString *)title detail:(NSString *) detail btnTitle:(NSString *)btnTitle target:(id)target action:(SEL)action;

+ (instancetype)emptyViewWithImageName:(NSString *)imageName title:(NSString *)title detail:(NSString *) detail btnTitle:(NSString *)btnTitle actionBlock:(LYActionTapBlock)actionBlock;

@end
