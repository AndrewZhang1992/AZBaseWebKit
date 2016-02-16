//
//  AZBaseWKWebView.m
//  testWKWebView
//
//  Created by Andrew on 16/1/18.
//  Copyright © 2016年 Andrew. All rights reserved.
//

#import "AZBaseWKWebView.h"

@implementation AZBaseWKWebView

+(instancetype)shareWKWebView
{
    static AZBaseWKWebView *webView;
    static dispatch_once_t webViewOnce;
    dispatch_once(&webViewOnce, ^{
        WKWebViewConfiguration *configuration=[[WKWebViewConfiguration alloc] init];
        webView=[[AZBaseWKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        
    });
    return webView;
}

@end
