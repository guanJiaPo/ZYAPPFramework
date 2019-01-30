//
//  ZYNavigationController.m
//  ZYAPPFramework
//
//  Created by szy on 2019/1/21.
//  Copyright © 2019 szy. All rights reserved.
//

#import "ZYNavigationController.h"

@interface ZYNavigationController ()<UINavigationControllerDelegate>

@end

@implementation ZYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    /// 右划返回手势的左侧有效距离
    self.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge = 30.f;
    self.navigationBar.backIndicatorImage = [UIImage new];
    self.navigationBar.backIndicatorTransitionMaskImage = [UIImage new];
    [self.navigationBar setTintColor: [UIColor whiteColor]];
    [self.navigationBar setBarTintColor: [UIColor whiteColor]];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : kHexColor(0x000000), NSFontAttributeName : [UIFont boldSystemFontOfSize:18]}];
    [self.navigationBar setTranslucent:NO];
}

#pragma mark override

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count) {
        [viewController.navigationController.navigationBar setBackIndicatorImage:[UIImage new]];
        viewController.navigationItem.hidesBackButton = YES;
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"navigation_back_normal"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"navigation_back_highlighted"] forState:UIControlStateHighlighted];
        [backButton setFrame:CGRectMake(0, 0, 44, 44)];
        [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = kScreenWidth > 375 ? -20 : -16;
        UIView *backView = [[UIView alloc] initWithFrame:backButton.bounds];
        [backView addSubview:backButton];
        UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView];
        viewController.navigationItem.leftBarButtonItems = @[negativeSpacer, leftBarButtonItem];
        viewController.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge = 30;
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark action

- (void)backAction {
    if (self.viewControllers.count == 2 ){
        [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    }
    [self popViewControllerAnimated:YES];
}

#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self resetBarItemSpacesWithController:viewController];
    /// 隐藏导航栏底部分割线
    [viewController.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [viewController.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count == 1) {
        [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    } else {
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    }
}

#pragma mark private

/// 修改导航栏左右item边距
- (void)resetBarItemSpacesWithController:(UIViewController *)viewController
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 11.0) { return; }
    CGFloat space = kScreenWidth > 375 ? 20 : 16;
    for (UIBarButtonItem *buttonItem in viewController.navigationItem.leftBarButtonItems) {
        if (buttonItem.customView == nil) { continue; }
        UIButton *itemBtn = nil;
        if ([buttonItem.customView isKindOfClass:[UIButton class]]) {
            itemBtn = (UIButton *)buttonItem.customView;
        } else if ([buttonItem.customView isKindOfClass:[UIView class]]) {
            itemBtn = (UIButton *)buttonItem.customView.subviews.firstObject;
        }
        CGRect newFrame = itemBtn.frame;
        newFrame.origin.x = -space;
        itemBtn.frame = newFrame;
    }
    for (UIBarButtonItem *buttonItem in viewController.navigationItem.rightBarButtonItems) {
        if (buttonItem.customView == nil) { continue; }
        UIButton *itemBtn = nil;
        if ([buttonItem.customView isKindOfClass:[UIButton class]]) {
            itemBtn = (UIButton *)buttonItem.customView;
        } else if ([buttonItem.customView isKindOfClass:[UIView class]]) {
            itemBtn = (UIButton *)buttonItem.customView.subviews.firstObject;
        }
        CGRect newFrame = itemBtn.frame;
        newFrame.origin.x = space;
        itemBtn.frame = newFrame;
    }
}

@end
