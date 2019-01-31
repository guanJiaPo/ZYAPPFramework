//
//  UEEmptyView.m
//  EmptyViewTest
//
//  Created by 石志愿 on 2018/7/12.
//  Copyright © 2018年 石志愿. All rights reserved.
//

#import "ZYEmptyView.h"

@interface ZYEmptyView ()

@end

@implementation ZYEmptyView

- (void)prepare{
    [super prepare];
    
    //元素竖直方向的间距
    self.subViewMargin = 10;
    //标题
    self.titleLabFont = [UIFont systemFontOfSize:16];
    self.titleLabTextColor = kHexColor(0x333333);

    //描述字体
    self.detailLabFont = [UIFont systemFontOfSize:14];
    self.detailLabTextColor = kHexColor(0x999999);

    //按钮
    self.actionBtnCornerRadius = 4;
    self.actionBtnBorderColor = kHexColor(0xe0e0e0);
    self.actionBtnBorderWidth = 1;
    self.actionBtnTitleColor = kHexColor(0x333333);
    self.actionBtnBackGroundColor = kHexColor(0xf7f9fc);
}

#pragma mark - 默认空数据样式
+ (instancetype)defaultEmptyViewWithTarget:(id)target action:(SEL)action {
    
    ZYEmptyView *emptyView = [ZYEmptyView emptyViewWithImageName:@"nodata" title:@"暂无数据" detail:@"请稍后再试!" btnTitle:@"重新加载" target:target action:action];
    return emptyView;
}

+ (instancetype)defaultEmptyViewWithAction:(LYActionTapBlock)actionBlock {
    
    ZYEmptyView *emptyView = [ZYEmptyView emptyViewWithImageName:@"nodata" title:@"暂无数据" detail:@"请稍后再试!" btnTitle:@"重新加载" actionBlock:actionBlock];
    return emptyView;
}

#pragma mark - 无网络
+ (instancetype)emptyViewForNoNetworkWithTarget:(id)target action:(SEL)action {
    
    ZYEmptyView *emptyView = [ZYEmptyView emptyViewWithImageName:@"empty_jd" title:@"网络请求失败" detail:@"请您检查网络链接后重试!" btnTitle:@"重新加载" target:target action:action];
    return emptyView;
}

+ (instancetype)emptyViewForNoNetworkWithAction:(LYActionTapBlock)actionBlock {
    
    ZYEmptyView *emptyView = [ZYEmptyView emptyViewWithImageName:@"empty_jd" title:@"网络请求失败" detail:@"请您检查网络链接后重试!" btnTitle:@"重新加载" actionBlock:actionBlock];
    return emptyView;
}

#pragma mark - 自定义

+ (instancetype)emptyViewWithImageName:(NSString *)imageName detail:(NSString *) detail offsetY:(CGFloat)offsetY {
    ZYEmptyView *emptyView = [ZYEmptyView emptyViewWithImageStr:imageName titleStr:nil detailStr:detail];
    emptyView.contentViewOffset = offsetY;
    return emptyView;
}

+ (instancetype)emptyViewWithImage:(UIImage *)image detail:(NSString *) detail {
    return [ZYEmptyView emptyViewWithImage:image titleStr:nil detailStr:detail];
}

+ (instancetype)emptyViewWithImageName:(NSString *)imageName detail:(NSString *) detail {
    return [ZYEmptyView emptyViewWithImageStr:imageName titleStr:nil detailStr:detail];
}

+ (instancetype)emptyViewWithImageName:(NSString *)imageName title:(NSString *)title detail:(NSString *) detail {
    return [ZYEmptyView emptyViewWithImageStr:imageName titleStr:title detailStr:detail];
}

+ (instancetype)emptyViewWithImageName:(NSString *)imageName title:(NSString *)title detail:(NSString *) detail btnTitle:(NSString *)btnTitle target:(id)target action:(SEL)action {
    return [ZYEmptyView emptyActionViewWithImageStr:imageName titleStr:title detailStr:detail btnTitleStr:btnTitle target:target action:action];
}

+ (instancetype)emptyViewWithImageName:(NSString *)imageName title:(NSString *)title detail:(NSString *) detail btnTitle:(NSString *)btnTitle actionBlock:(LYActionTapBlock)actionBlock {
    return [ZYEmptyView emptyActionViewWithImageStr:imageName titleStr:title detailStr:detail btnTitleStr:btnTitle btnClickBlock:actionBlock];
}

@end
