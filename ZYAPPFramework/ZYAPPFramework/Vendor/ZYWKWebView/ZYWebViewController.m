//
//  TLWebViewController.m
//  TalentLive
//
//  Created by f.g.xiaofange on 2017/3/17.
//  Copyright © 2017年 http://xiaofange123.com. All rights reserved.
//

#import "ZYWebViewController.h"

@interface ZYWebViewController () <WKNavigationDelegate,WKUIDelegate>

@property (nonatomic, strong) NSURLRequest   *request;
@property (nonatomic, strong) WKWebView      *webView;
@property (nonatomic, assign) BOOL          isLoading; //使用webView.isLoading无法立即更新
@property (nonatomic, strong) UIProgressView  *progressView;

@property (nonatomic, strong) UIBarButtonItem *backBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *forwardBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *refreshBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *stopBarButtonItem;

@end

@implementation ZYWebViewController

#pragma mark - life cycle

- (instancetype _Nonnull )initWithUrlString:(NSString *_Nonnull)urlString {
    urlString = [NSString urlEncode:urlString];
    return [self initWithURL:[NSURL URLWithString:urlString]];
}

- (instancetype)initWithURL:(NSURL *)url
{
    return [self initWithURLRequest:[NSURLRequest requestWithURL:url]];
}

- (instancetype)initWithURLRequest:(NSURLRequest *)request {
    if (self = [super init]) {
        self.showToolBar = false;
        self.request = request;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    [self loadRequest:self.request];
    self.isLoading = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    /// 隐藏导航栏分割线
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar addSubview:self.progressView];
    [self.navigationController setToolbarHidden:!self.showToolBar animated:animated];
    if (self.showToolBar) {
        [self updateToolbarItems];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.progressView removeFromSuperview];
    [self.navigationController setToolbarHidden:YES animated:animated];
}

- (void)dealloc {
    if (self.observeTitle) {
        [self.webView removeObserver:self forKeyPath:@"title"];
    }
    
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

#pragma mark - Toolbar

- (void)updateToolbarItems {
    self.backBarButtonItem.enabled = self.webView.canGoBack;
    self.forwardBarButtonItem.enabled = self.webView.canGoForward;
    
    UIBarButtonItem *refreshStopBarButtonItem = self.isLoading ? self.stopBarButtonItem : self.refreshBarButtonItem;
    
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *firstSpace = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? flexibleSpace : fixedSpace;
    NSArray *items = [NSArray arrayWithObjects:
                      firstSpace,
                      self.backBarButtonItem,
                      flexibleSpace,
                      self.forwardBarButtonItem,
                      flexibleSpace,
                      refreshStopBarButtonItem,
                      flexibleSpace,
                      nil];
    self.navigationController.toolbar.barStyle = self.navigationController.navigationBar.barStyle;
    self.navigationController.toolbar.tintColor = kHexColor(0x3bbd79);
    self.toolbarItems = items;
}

- (void)handleError:(NSError *)error{
    NSString *urlString = error.userInfo[NSURLErrorFailingURLStringErrorKey];
    
    if (([error.domain isEqualToString:@"WebKitErrorDomain"] && 101 == error.code) ||
        ([error.domain isEqualToString:NSURLErrorDomain] && (NSURLErrorBadURL == error.code || NSURLErrorUnsupportedURL == error.code))) {
        [self showTip:@"网址无效"];
    }else if ([error.domain isEqualToString:NSURLErrorDomain] && (NSURLErrorTimedOut == error.code ||
                                                                  NSURLErrorCannotFindHost == error.code ||
                                                                  NSURLErrorCannotConnectToHost == error.code ||
                                                                  NSURLErrorNetworkConnectionLost == error.code ||
                                                                  NSURLErrorDNSLookupFailed == error.code ||
                                                                  NSURLErrorNotConnectedToInternet == error.code)) {
        [self showTip:@"网络连接异常"];
    }else if ([error.domain isEqualToString:@"WebKitErrorDomain"] && 102 == error.code){
        NSURL *url = [NSURL URLWithString:urlString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        } else {
            [self showTip:@"无法打开连接"];
        }
    } else if (error.code == -999){
        //加载中断
    } else {
        [self showTip:([error.userInfo objectForKey:@"NSLocalizedDescription"]? [error.userInfo objectForKey:@"NSLocalizedDescription"]: error.description)];
    }
}

#pragma mark - load view

- (void)loadUrlStr:(NSString *)urlStr
{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self loadRequest:request];
}

- (void)loadRequest:(NSURLRequest *_Nonnull)request
{
    if (request) {
        [self.webView loadRequest:request];
    }
}

- (void)loadHTMLString:(NSString *)string {
    [self loadHTMLString:string baseURL:nil];
}

- (void)loadHTMLString:(NSString *_Nonnull)string baseURL:(nullable NSURL *)baseURL
{
    if ([NSString isEmpty:string]) {
        return;
    }
    [self.webView loadHTMLString:string baseURL:baseURL];
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > 90000
- (void)loadFileURL:(NSURL * _Nonnull)URL allowingReadAccessToURL:(nullable NSURL *)readAccessURL
{
    if (@available(iOS 9.0, *)) {
        [self.webView loadFileURL:URL allowingReadAccessToURL:readAccessURL];
    } else {
        // Fallback on earlier versions
    }
}

- (void)loadData:(NSData *_Nullable)data MIMEType:(NSString *_Nullable)MIMEType characterEncodingName:(NSString *_Nullable)characterEncodingName baseURL:(NSURL *_Nullable)baseURL
{
    if (@available(iOS 9.0, *)) {
        [self.webView loadData:data MIMEType:MIMEType characterEncodingName:characterEncodingName baseURL:baseURL];
    } else {
        // Fallback on earlier versions
    }
}
#endif

#pragma mark - event

- (void)leftButtonClicked
{
    if (self.presentingViewController || !self.navigationController){
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context  {
    
    if ([keyPath isEqualToString:@"title"]) {
        if (self.observeTitle) {
            self.title = change[NSKeyValueChangeNewKey];
        }
    } else if ([keyPath isEqualToString:@"estimatedProgress"]) {
        [self.progressView setProgress:[change[NSKeyValueChangeNewKey] doubleValue] animated:YES];
        if (!self.isLoading) {
            [UIView animateWithDuration:0.25 animations:^{
                self.progressView.alpha = 0.0;
                self.progressView.progress = 0.0;
            }];
        } else {
            self.progressView.alpha = 1.0;
        }
    } else {
        [self willChangeValueForKey:keyPath];
        [self didChangeValueForKey:keyPath];
    }
}

- (void)goBackTapped:(UIBarButtonItem *)sender {
    [self.webView goBack];
}

- (void)goForwardTapped:(UIBarButtonItem *)sender {
    [self.webView goForward];
}

- (void)reloadTapped:(UIBarButtonItem *)sender {
    [self.webView reload];
    self.isLoading = YES;
    [self updateToolbarItems];
}

- (void)stopTapped:(UIBarButtonItem *)sender {
    [self.webView stopLoading];
    self.isLoading = NO;
    if (self.progressView) {
        self.progressView.alpha = 0.0;
        self.progressView.progress = 0.0;
    }
    [self updateToolbarItems];
}

- (void)doneButtonTapped:(id)sùender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)callJS
{
    [self.webView evaluateJavaScript:@"document.body.style.webkitTouchCallout='none';" completionHandler:^(id _Nullable object, NSError * _Nullable error) {
    }];
    [self.webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';" completionHandler:^(id _Nullable object, NSError * _Nullable error) {
    }];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    if (self.progressView) {
        self.progressView.alpha = 0.0;
        self.progressView.progress = 0.0;
    }
    [self callJS];
    self.isLoading = NO;
    if (self.showToolBar) {
        [self updateToolbarItems];
    }
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    self.isLoading = NO;
    if (self.showToolBar) {
        [self updateToolbarItems];
    }
    if (error) {
        [self handleError:error];
    }
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > 90000
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    [self.webView reload];
}
#endif

#pragma mark - gettr

- (UIProgressView *)progressView {
    if (_progressView == nil) {
        CGFloat progressBarHeight = 3.0f;
        CGRect navigaitonBarBounds = self.navigationController.navigationBar.bounds;
        CGRect frame = CGRectMake(0, navigaitonBarBounds.size.height, navigaitonBarBounds.size.width, progressBarHeight);
        _progressView = [[UIProgressView alloc] initWithFrame:frame];
        _progressView.tintColor = kHexColor(0x4A6AFF);
        _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    }
    return _progressView;
}

- (WKWebView *)webView {
    if (_webView == nil) {
        
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.userContentController = [[WKUserContentController alloc] init];;
        
        WKPreferences *preferences = [[WKPreferences alloc] init];
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        configuration.preferences = preferences;
        NSInteger barHeight = self.showToolBar ? kNavTotalHeight + 44 : kNavTotalHeight;
        CGRect frame = CGRectMake(0, 0, kScreenWidth, KScreenHeight - barHeight);
        _webView = [[WKWebView alloc] initWithFrame:frame configuration:configuration];
        _webView.allowsBackForwardNavigationGestures = YES;
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        if (self.observeTitle) {
            [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
        }
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _webView;
}

- (UIBarButtonItem *)backBarButtonItem {
    if (!_backBarButtonItem) {
        _backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ZYWebViewController.bundle/ZYWebViewControllerBack"]
                                                              style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(goBackTapped:)];
        _backBarButtonItem.width = 18.0f;
    }
    return _backBarButtonItem;
}

- (UIBarButtonItem *)forwardBarButtonItem {
    if (!_forwardBarButtonItem) {
        _forwardBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ZYWebViewController.bundle/ZYWebViewControllerNext"]
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(goForwardTapped:)];
        _forwardBarButtonItem.width = 18.0f;
    }
    return _forwardBarButtonItem;
}

- (UIBarButtonItem *)refreshBarButtonItem {
    if (!_refreshBarButtonItem) {
        _refreshBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadTapped:)];
    }
    return _refreshBarButtonItem;
}

- (UIBarButtonItem *)stopBarButtonItem {
    if (!_stopBarButtonItem) {
        _stopBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stopTapped:)];
    }
    return _stopBarButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

