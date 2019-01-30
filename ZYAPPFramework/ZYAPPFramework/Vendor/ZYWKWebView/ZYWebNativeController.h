//
//  UEWebViewController.h
//  WKWebViewController
//
//  Created by 石志愿 on 2017/6/5.
//  Copyright © 2017年 http://xiaofange123.com. All rights reserved.
//

/********************************oc js 交互******************************/

#import "ZYWebViewController.h"

@interface ZYWebNativeController : ZYWebViewController


/**
 OC给JS提供公开的API 在JS端可以手动调用这些API

 @param methodName 方法名
 */
- (void)registerScriptMessageHandler:(NSString *)methodName;


/**
 移除API 需要在dealloc前(viewDidDisappear)移除 否则会造成内存泄漏

 @param methodName 方法名
 */
- (void)removeScriptMessageHandler:(NSString *)methodName;

@end
