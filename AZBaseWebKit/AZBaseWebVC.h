//
//  AZBaseWebVC.h
//  testWKWebView
//
//  Created by Andrew on 16/1/18.
//  Copyright © 2016年 Andrew. All rights reserved.
//

#define AZ_WK_NEED_IOS8  __IPHONE_OS_VERSION_MAX_ALLOWED >=__IPHONE_8_0

#import <UIKit/UIKit.h>

typedef void (^azCompletionHandler)(NSString * __nullable value, NSError * __nullable error);

/**
 *  最大网络等待时间
 */
static const float WEB_TIMEOUT=15.0;

@interface AZBaseWebVC : UIViewController

/**
 *  >= ios 8 为 WKWebView 。 < ios8.0 为 UIWebView
 */
@property (nonatomic,weak)id webView;

/**
 *  请求URL
 */
@property (nonatomic,copy)NSString *urlStr;

#pragma  mark -- 对外接口

/** 开始请求 */
-(void)loadRequest:(NSString *)urlStr;

/**
 *  执行 javaScript 内部分开 wkwebview 和 uiwebview
 *
 *  @param javaScript 内容
 *
 *  @param completionHandler  执行完结果回调
 */
-(void)azEvaluateingJavaScript:(NSString *)javaScript andcompletionHandler:(azCompletionHandler) completionHandler;


@end
