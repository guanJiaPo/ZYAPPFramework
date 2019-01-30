//
//  TLWebViewController.h
//  TalentLive
//
//  Created by f.g.xiaofange on 2017/3/17.
//  Copyright © 2017年 http://xiaofange123.com. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYWebViewController : UIViewController

@property (nonatomic, strong, readonly) WKWebView *webView;

/// 是否显示底部工具栏 默认false
@property (nonatomic, assign) BOOL showToolBar;

/// 是否监听title 默认true
@property (nonatomic, assign) BOOL observeTitle;

#pragma mark - init

- (instancetype _Nonnull )initWithUrlString:(NSString *_Nonnull)urlString;
- (instancetype)initWithURL:(NSURL *)url;

#pragma mark - load

- (void)loadUrlStr:(NSString *)urlStr;

- (void)loadRequest:(NSURLRequest *_Nonnull)request;

- (void)loadFileURL:(NSURL *_Nonnull)URL allowingReadAccessToURL:(NSURL *_Nullable)readAccessURL;

/// 
- (void)loadHTMLString:(NSString *)string;
- (void)loadHTMLString:(NSString *_Nonnull)string baseURL:(nullable NSURL *)baseURL;

- (void)loadData:(NSData *_Nullable)data MIMEType:(NSString *_Nullable)MIMEType characterEncodingName:(NSString *_Nullable)characterEncodingName baseURL:(NSURL *_Nullable)baseURL;

@end

NS_ASSUME_NONNULL_END
