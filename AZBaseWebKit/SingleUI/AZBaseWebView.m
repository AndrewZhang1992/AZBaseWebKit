//
//  AZBaseWebView.m
//  testWKWebView
//
//  Created by Andrew on 16/1/18.
//  Copyright © 2016年 Andrew. All rights reserved.
//

#import "AZBaseWebView.h"

@implementation AZBaseWebView

+(instancetype)shareWebView
{
    static AZBaseWebView *webView=nil;
    static dispatch_once_t webViewOnce;
    dispatch_once(&webViewOnce, ^{
        webView=[[AZBaseWebView alloc] init];
    });
    return webView;
}

@end
