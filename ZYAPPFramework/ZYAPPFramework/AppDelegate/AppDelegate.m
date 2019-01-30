//
//  AppDelegate.m
//  ZYAPPFramework
//
//  Created by szy on 2019/1/21.
//  Copyright © 2019 szy. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setupRootController];
    return YES;
}

#pragma mark private

- (void)setupRootController {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ZYTabBarController *rootVC = [[ZYTabBarController alloc] init];
    [self.window setRootViewController:rootVC];
    [self.window makeKeyAndVisible];
}


@end
