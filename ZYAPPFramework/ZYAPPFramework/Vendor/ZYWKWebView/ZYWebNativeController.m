//
//  UEWebViewController.m
//  WKWebViewController
//
//  Created by 石志愿 on 2017/6/5.
//  Copyright © 2017年 http://xiaofange123.com. All rights reserved.
//

#import "ZYWebNativeController.h"
#import <WebKit/WebKit.h>


@interface ZYWebNativeController ()<WKScriptMessageHandler>

@end

@implementation ZYWebNativeController

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark - js调用oc

- (void)registerScriptMessageHandler:(NSString *)methodName
{
    [[self.webView configuration].userContentController addScriptMessageHandler:self name:methodName];
}

- (void)removeScriptMessageHandler:(NSString *)methodName
{
        [[self.webView configuration].userContentController removeScriptMessageHandlerForName:methodName];
}

//OC在JS调用方法后的处理
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
