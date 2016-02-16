//
//  AZBaseWebVC.m
//  testWKWebView
//
//  Created by Andrew on 16/1/18.
//  Copyright © 2016年 Andrew. All rights reserved.
//



#import "AZBaseWebVC.h"
#import "AZBaseWebView.h"
//#import "AZBaseWKWebView.h"

#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"

#if AZ_WK_NEED_IOS8
    #import <WebKit/WebKit.h>
#endif

#if AZ_WK_NEED_IOS8
@interface AZBaseWebVC ()<WKNavigationDelegate,WKUIDelegate>
{
    WKWebView *wkWebView;
}
@property (nonatomic,strong)NJKWebViewProgressView *progressView;
@property (nonatomic,strong)NJKWebViewProgress *progressProxy;
@end

#else
@interface AZBaseWebVC ()<UIWebViewDelegate,NJKWebViewProgressDelegate>
{
    AZBaseWebView *azWebView;
}
@property (nonatomic,strong)NJKWebViewProgressView *progressView;
@property (nonatomic,strong)NJKWebViewProgress *progressProxy;
@end
#endif


@implementation AZBaseWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
#if AZ_WK_NEED_IOS8
    [self createWKWebView];

    [wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
#else
    [self createWebView];

#endif
    
    [self createNJK];
    
    [self loadRequest:self.urlStr];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
    /** 清除NSURLCache，尽力挽救 */
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.navigationController.navigationBar addSubview:_progressView];
    [_progressView setProgress:0 animated:NO];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    /** 在view将要消失的时候，将_progressView移除，因为navigationbar是和其他viewcontroller 共用的 */
    [_progressView removeFromSuperview];
    
}


#if AZ_WK_NEED_IOS8

-(void)createWKWebView
{
    WKWebViewConfiguration *configuration=[[WKWebViewConfiguration alloc] init];
    wkWebView=[[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    wkWebView.navigationDelegate=self;
    wkWebView.UIDelegate=self;
    [self.view addSubview:wkWebView];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        [_progressView setProgress:wkWebView.estimatedProgress animated:YES];
    }
}


#else

-(void)createWebView
{
    azWebView=[AZBaseWebView shareWebView];
    azWebView.frame=self.view.bounds;
    azWebView.delegate=self;
    [self.view addSubview:azWebView];
    
}


#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
}


#endif


-(void)createNJK
{
    _progressProxy = [[NJKWebViewProgress alloc] init];
   
#if AZ_WK_NEED_IOS8

#else
    azWebView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
#endif
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigaitonBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigaitonBarBounds.size.height - progressBarHeight, navigaitonBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
}


-(void)loadRequest:(NSString *)urlStr
{
    NSURL *url=[NSURL URLWithString:urlStr];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] initWithURL:url];

    //设置超时时间
    request.timeoutInterval=WEB_TIMEOUT;

#if AZ_WK_NEED_IOS8
    [wkWebView loadRequest:request];
#else
    [azWebView loadRequest:request];
#endif
    
}

-(void)dealloc
{
#if AZ_WK_NEED_IOS8
    [wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
#else
    
#endif
}

-(id)webView
{
#if AZ_WK_NEED_IOS8
    return wkWebView;
#else
    return azWebView;
#endif
}


/**
 *  执行 javaScript 内部分开 wkwebview 和 uiwebview
 *
 *  @param javaScript 内容
 *
 *  @param completionHandler  执行完结果回调
 */
-(void)azEvaluateingJavaScript:(NSString *)javaScript andcompletionHandler:(azCompletionHandler) completionHandler
{
#if AZ_WK_NEED_IOS8
    [self.webView evaluateJavaScript:javaScript completionHandler:^(id _Nullable x, NSError * _Nullable error) {
        if (completionHandler) {
            completionHandler((NSString *)x,error);
        }
    }];
#else
    NSString *result=[self.webView stringByEvaluatingJavaScriptFromString:javaScript];
    if (completionHandler) {
        completionHandler(result,nil);
    }
#endif
}


@end
