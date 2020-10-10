//
//  ByEnergyBaseWebVc.m
//  ByEnergyCharge
//
//  Created by Mr.lin on 2020/3/3.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "ByEnergyBaseWebVc.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>


// WKWebView 内存不释放的问题解决
@interface WeakWebViewScriptMessageDelegate : NSObject<WKScriptMessageHandler>

//WKScriptMessageHandler 这个协议类专门用来处理JavaScript调用原生OC的方法
@property (nonatomic, weak) id<WKScriptMessageHandler> scriptDelegate;

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end

@implementation WeakWebViewScriptMessageDelegate

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate {
    self = [super init];
    if (self) {
        _scriptDelegate = scriptDelegate;
    }
    return self;
}

#pragma mark - WKScriptMessageHandler
//遵循WKScriptMessageHandler协议，必须实现如下方法，然后把方法向外传递
//通过接收JS传出消息的name进行捕捉的回调方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    if ([self.scriptDelegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
        [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
    }
}

@end
@interface ByEnergyBaseWebVc ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
@property (nonatomic,strong) WKWebView *wkWebview;
@property (nonatomic, copy) NSString *webTitle; //标题
@property (nonatomic, strong) UIButton *backBarButton; //进度条颜色
@property (nonatomic, readwrite, strong) UIBarButtonItem *closeBarButton;//关闭按钮 （点击关闭按钮  退出WebView）
@property (nonatomic, assign) BOOL hasLoad;
@property (nonatomic,strong) UIProgressView *progress;
@end

@implementation ByEnergyBaseWebVc

static UIColor *progressViewBgColor = nil;

+ (ByEnergyBaseWebVc *)byEnergyWebViewControllerWithPath:(NSString *)path
                                               title:(NSString *)title
                                             baseUrl:(NSString *)baseUrl
                                              params:(NSDictionary *)params {
    ByEnergyBaseWebVc *vc = [[ByEnergyBaseWebVc alloc] init];
    vc.titleStr = title;
    vc.urlStr = [StringUtils resoureUrlStrWithPath:path params:params baseUrl:baseUrl];
    return vc;
}

+ (void)byEnergySetWebViewProgressViewBackgroundColor:(UIColor *)bgColor {
    progressViewBgColor = bgColor;
}

- (instancetype)initWithPath:(NSString *)pathStr
                      params:(NSDictionary *)params
                     baseUrl:(NSString *)baseUrl
                    titleStr:(NSString *)titleStr {
    self = [super init];
    if (self) {
        self.titleStr = titleStr;
        self.urlStr = [StringUtils resoureUrlStrWithPath:pathStr params:params baseUrl:baseUrl];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.hasLoad) {
        [self byEnergyInitViews];
        [self byEnergySetViewLayout];
        [self loadPage];
        self.hasLoad = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)byEnergyInitViews {
    self.title = self.titleStr;
    UIBarButtonItem *backItem = [self byEnergyNavItemWithImgeName:@"btn_return" Highlighted:@"" isLeft:YES target:self action:@selector(selectedToClose:) tags:2000];
    UIBarButtonItem *closeItem = [self byEnergyNavItemWithTitle:@"关闭" isLeft:YES target:self action:@selector(selectedToClose:) tags:2001];
    self.navigationItem.leftBarButtonItems = @[backItem,closeItem];
    self.closeBarButton = closeItem;
    self.closeBarButton.customView.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.wkWebview];
    [self addObserver];
}

- (void)byEnergySetViewLayout {
    [self.wkWebview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

#pragma mark 添加KVO观察者
- (void)addObserver {
    //TODO:kvo监听，获得页面title和加载进度值，以及是否可以返回
    [self.wkWebview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    [self.wkWebview addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:NULL];
    [self.wkWebview addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
}

#pragma mark - public methods
- (void)loadPage {
    if (byEnergyIsValidStr(self.filePath)) {
        [self loadLocalFile:self.filePath];
    }
    else if (byEnergyIsValidStr(self.urlStr)) {
        [self loadPageWithURLStr:self.urlStr];
    }
}

- (void)loadLocalFile:(NSString *)filePath {
    [self.wkWebview stopLoading];
    NSLog(@"filePath:%@",filePath);
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:[self readCurrentCookieWithDomain:filePath] forHTTPHeaderField:@"Cookie"];
    [_wkWebview loadRequest:request];
}

- (void)loadPageWithURLStr:(NSString *)urlStr {
    if ([urlStr length] > 0) {
        [self.wkWebview stopLoading];
        NSLog(@"urlStr:%@",urlStr);
        NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request addValue:[self readCurrentCookieWithDomain:urlStr] forHTTPHeaderField:@"Cookie"];
        [_wkWebview loadRequest:request];
    }
}

#pragma mark - wkDelegate
/*
 WKNavigationDelegate主要处理一些跳转、加载处理操作，WKUIDelegate主要处理JS脚本，确认框，警告框等
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
}

#pragma mark - WKNavigationDelegate
//内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    //不显示关闭按钮
    if(self.shouldDisableWebViewClose) return;
    UIBarButtonItem *backItem = self.navigationItem.leftBarButtonItems.firstObject;
    if (backItem) {
        if ([self.wkWebview canGoBack]) {
            [self.navigationItem setLeftBarButtonItems:@[backItem, self.closeBarButton]];
        } else {
            [self.navigationItem setLeftBarButtonItems:@[backItem]];
        }
    }
}

#pragma mark - privatge methods
- (void)distributeFrameMethodWithName:(NSString *)method
                               params:(NSDictionary *)params
                             callback:(NSString *)callback {
    if ([method isEqualToString:@"frameShowAlert"]) {
        [self frameShowAlert:params callback:callback];
    }
    
    if ([method isEqualToString:@"frameOpenUrl"]) {
        [self frameOpenUrl:params callback:callback];
    }
    
    if ([method isEqualToString:@"frameShowPage"]) {
        [self frameShowPage:params callback:callback];
    }
    
    if ([method isEqualToString:@"frameShowMsg"]) {
        [self frameShowMsg:params callback:callback];
    }
    
    if ([method isEqualToString:@"frameShowConfirm"]) {
        [SCAlertViewUtils showAlertWithType:SCAlertTypeAlert
                                      title:@"提示"
                                    message:params[@"message"]
                          cancelButtonTitle:@"取消"
                     destructiveButtonTitle:nil
                          otherButtonTitles:@[@"确定"]
                          completionHandler:^(SCAlertButtonType buttonType, NSUInteger buttonIndex) {
                              NSUInteger btnIndex = 1;
                              if (buttonType == SCAlertButtonTypeCancel) {
                                  btnIndex = 0;
                              }
                              JSContext *context = [JSContext currentContext];
                              JSValue *function = [context objectForKeyedSubscript:callback];
                              [function callWithArguments:@[@(btnIndex)]];
                          }];
    }
    
    if ([method isEqualToString:@"weixin"]) { //分享到微信
        if (self.shareButtonWithButtonType) {
            self.shareButtonWithButtonType(shareButtonTypeweChat);
        }
    }
    
    if ([method isEqualToString:@"circle"]) { //分享到微信朋友圈
        if (self.shareButtonWithButtonType) {
            self.shareButtonWithButtonType(shareButtonTypeweChat_line);
        }
    }
    
    [self distributePrivateMethodWithName:method params:params callback:callback];
}

- (void)distributePrivateMethodWithName:(NSString *)method
                                 params:(NSDictionary *)params
                               callback:(NSString *)callback {
    
}

- (void)frameShowAlert:(NSDictionary *)params callback:(NSString *)callback {
    if (byEnergyIsValidStr(params[@"message"])) {
        [BEnergyCustomAlertView showAlertViewWithTitle:params[@"message"]
                                           buttonArray:@[@"好的"]
                                                 block:^(BEnergyCustomAlertView * _Nonnull target, NSInteger buttonIndex) {
            
        }];
    }
}

- (void)frameOpenUrl:(NSDictionary *)params callback:(NSString *)callback {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:params[@"url"]]];
}

- (void)frameShowPage:(NSDictionary *)params callback:(NSString *)callback {
    if (byEnergyIsValidStr(params[@"url"])) {
        ByEnergyBaseWebVc *vc = [ByEnergyBaseWebVc byEnergyWebViewControllerWithPath:params[@"url"]
                                                                               title:byEnergyIsValidStr(params[@"title"])?params[@"title"]:@"详情"
                                                                             baseUrl:nil
                                                                              params:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)frameShowMsg:(NSDictionary *)params callback:(NSString *)callback {
    if (byEnergyIsValidStr(params[@"message"])) {
        [HUDManager showTextHud:params[@"message"] onView:self.view];
    }
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    kWeakSelf(self);
    NSLog(@"name:%@\\\\n body:%@\\\\n frameInfo:%@\\\\n",message.name,message.body,message.frameInfo);
    NSString *method = nil;
    NSString *callback = nil;
    //用message.body获得JS传出的参数体
    NSDictionary * params = message.body;
    method = byEnergyClearNilStr([params objectForKey:@"name"]);
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakself distributeFrameMethodWithName:method params:params callback:callback];
    });
}

#pragma mark KVO的监听代理
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {//加载进度值
        if (object == self.wkWebview) {
            [self.progress setAlpha:1.0f];
            [self.progress setProgress:self.wkWebview.estimatedProgress animated:YES];
            if(self.wkWebview.estimatedProgress >= 1.0f) {
                [UIView animateWithDuration:1.5f
                                      delay:0.0f
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     [self.progress setAlpha:0.0f];
                                 }
                                 completion:^(BOOL finished) {
                                     [self.progress setProgress:0.0f animated:NO];
                                 }];
            }
        }else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } else if ([keyPath isEqualToString:@"title"]) { //网页title
        if (object == self.wkWebview) {
            if (byEnergyIsNilOrNull(self.titleStr)) {
                self.navigationItem.title = self.wkWebview.title;
            }
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }else if ([keyPath isEqualToString:@"canGoBack"]) {  //是否可以返回
        if (object == self.wkWebview) {
            if ([self.wkWebview canGoBack]) {
                self.closeBarButton.customView.hidden = NO;
            } else {
                self.closeBarButton.customView.hidden = YES;
            }
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)backBtnClicked {
    if (self.wkWebview.canGoBack == 1){
        [self.wkWebview goBack];
    }else {
        [self.wkWebview stopLoading];
        self.wkWebview.navigationDelegate = nil;
        self.wkWebview.UIDelegate = nil;
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)selectedToClose:(UIButton *)sender {
    switch (sender.tag) {
        case 2000:
            NSLog(@"分享");
            [self backBtnClicked];
            break;
        case 2001:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        default:
            break;
    }
}

//解决第一次进入的cookie丢失问题
- (NSString *)readCurrentCookieWithDomain:(NSString *)domainStr {
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSMutableString *cookieString = [[NSMutableString alloc]init];
    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
        [cookieString appendFormat:@"%@=%@;",cookie.name,cookie.value];
    }
    //删除最后一个“;”
    if ([cookieString hasSuffix:@";"]) {
        [cookieString deleteCharactersInRange:NSMakeRange(cookieString.length - 1, 1)];
    }
    return cookieString;
}

+ (void)cleanCacheAndCookie {
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    //缓存web清除
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLCache *cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
}

- (void)setIsElastic:(BOOL)isElastic {
    _isElastic = isElastic;
    self.wkWebview.scrollView.bounces = _isElastic;
}

#pragma mark -----LazyLoad
- (WKWebView *)wkWebview {
    if (!_wkWebview) {
        WeakWebViewScriptMessageDelegate *weakScriptMessageDelegate = [[WeakWebViewScriptMessageDelegate alloc] initWithDelegate:self];
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];  //WKWebview配置对象
        WKPreferences *preference = [[WKPreferences alloc]init];
        // 是否支持记忆读取
        config.suppressesIncrementalRendering = YES;
        config.preferences = preference;
        //是否允许与js进行交互，默认是YES的，如果设置为NO，js的代码就不起作用了
        preference.javaScriptEnabled = YES;
        WKUserContentController *userContentController = [[WKUserContentController alloc]init];  //交互的重要之点
        [userContentController addScriptMessageHandler:weakScriptMessageDelegate name:@"AppModel"];   //切记 Share 方法名一定要和H5开发人员协商定好  self 指当前控制器，切记这个代理要添加 WKScriptMessageHandler  不然会报警告
        config.userContentController = userContentController;
        _wkWebview = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
        _wkWebview.UIDelegate = self;
        _wkWebview.navigationDelegate = self;
        _wkWebview.backgroundColor = [UIColor whiteColor];
        _wkWebview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _wkWebview.multipleTouchEnabled = YES;
        _wkWebview.autoresizesSubviews = YES;
        _wkWebview.scrollView.alwaysBounceVertical = YES;
        _wkWebview.allowsBackForwardNavigationGestures = YES;/**这一步是，开启侧滑返回上一历史界面**/
        _wkWebview.scrollView.bounces = YES;
    }
    return _wkWebview;
}

- (UIProgressView *)progress {
    if (!_progress) {
        _progress = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 2)];
        _progress.tintColor = [UIColor colorByEnergyWithBinaryString:@"FDBD42"];
        _progress.trackTintColor = [UIColor clearColor];
        [self.view addSubview:_progress];
    }
    return _progress;
}


- (void)dealloc {
    [self.wkWebview removeObserver:self forKeyPath:@"canGoBack"];
    [self.wkWebview removeObserver:self forKeyPath:@"title"];
    [_wkWebview.configuration.userContentController removeScriptMessageHandlerForName:@"AppModel"];
    [_wkWebview stopLoading];
    _wkWebview.navigationDelegate = nil;
    _wkWebview.UIDelegate = nil;
    self.progress = nil;
}
@end


