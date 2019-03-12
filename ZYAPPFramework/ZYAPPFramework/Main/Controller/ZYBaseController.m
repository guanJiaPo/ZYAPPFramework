//
//  ZYBaseController.m
//  ZYAPPFramework
//
//  Created by szy on 2019/1/21.
//  Copyright © 2019 szy. All rights reserved.
//

#import "ZYBaseController.h"

@interface ZYBaseController ()

@end

@implementation ZYBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.statusBarHidden = false;
}

#pragma mark public

/// 重写导航栏返回按钮
- (void)resetBackItem {
    self.navigationItem.hidesBackButton = YES;
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"navigation_back_normal"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"navigation_back_highlighted"] forState:UIControlStateHighlighted];
    [backButton setFrame:CGRectMake(0, 0, 44, 44)];
    [backButton addTarget:self action:@selector(backItemAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *negativeSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpace.width = kScreenWidth > 375 ? -20 : -16;
    UIView *backView = [[UIView alloc] initWithFrame:backButton.bounds];
    [backView addSubview:backButton];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView];
    self.navigationItem.leftBarButtonItems = @[negativeSpace, leftBarButtonItem];
}

/// 返回按钮
- (UIButton *)backButton {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"navigation_back_normal"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"navigation_back_highlighted"] forState:UIControlStateHighlighted];
    [backButton setFrame:CGRectMake(0, 0, 44, 44)];
    return backButton;
}

#pragma mark action

///导航栏返回按钮事件
- (void)backItemAction {
    [self.navigationController popViewControllerAnimated:true];
}

- (BOOL)prefersStatusBarHidden {
    return self.statusBarHidden;
}

@end
