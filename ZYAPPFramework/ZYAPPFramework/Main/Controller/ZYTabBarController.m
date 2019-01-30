//
//  ZYTabBarController.m
//  ZYAPPFramework
//
//  Created by szy on 2019/1/21.
//  Copyright © 2019 szy. All rights reserved.
//

#import "ZYTabBarController.h"
#import "ZYHomeController.h"
#import "ZYProfileController.h"
#import "RDVTabBarItem.h"

@interface ZYTabBarController ()<RDVTabBarControllerDelegate>

@end

@implementation ZYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.backgroundView.backgroundColor = kHexColor(0xEFF0F6);
    [self setUpRootControllers];
}

#pragma mark - setUp

- (void)setUpRootControllers {
    /// 首页
    ZYHomeController *homeVC = [[ZYHomeController alloc]init];
    ZYNavigationController *nav_homeVC = [[ZYNavigationController alloc] initWithRootViewController:homeVC];
    /// 我的
    ZYProfileController *profileVC = [[ZYProfileController alloc] init];
    ZYNavigationController *nav_profileVC = [[ZYNavigationController alloc] initWithRootViewController:profileVC];
    [self setViewControllers:@[nav_homeVC, nav_profileVC]];
    [self customizeTabBarForController];
    self.delegate = self;
}

- (void)customizeTabBarForController {
    NSArray *tabBarItemImages = @[@"tabBar_home", @"tabBar_profile"];
    NSArray *tabBarItemTitles = @[@"首页", @"我的"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[self tabBar] items]) {
        item.titlePositionAdjustment = UIOffsetMake(0,0);
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected", [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal", [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        item.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        
        [item setTitle:[tabBarItemTitles objectAtIndex:index]];
        item.unselectedTitleAttributes = @{NSForegroundColorAttributeName : kHexColor(0x9092a5), NSFontAttributeName : [UIFont systemFontOfSize:12]};
        item.selectedTitleAttributes = @{NSForegroundColorAttributeName : kHexColor(0x4A6AFF), NSFontAttributeName : [UIFont systemFontOfSize:12]};
        
        item.badgePositionAdjustment = UIOffsetMake(-8, 1);
        item.badgeTextFont = [UIFont systemFontOfSize:11];
        index++;
    }
}

#pragma mark - <RDVTabBarControllerDelegate>

- (BOOL)tabBarController:(RDVTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    if (![viewController isKindOfClass:[ZYNavigationController class]]) {
        return YES;
    }
    
    if ([tabBarController.selectedViewController isEqual: viewController]) {
        return NO;
    }
    
    return YES;
}

@end
