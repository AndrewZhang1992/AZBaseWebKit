//
//  AZBaseWKWebView.h
//  testWKWebView
//
//  Created by Andrew on 16/1/18.
//  Copyright © 2016年 Andrew. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface AZBaseWKWebView : WKWebView

/**
 *  单例对象 内部不指定frame
 *
 *  @return 实例
 */
+(instancetype)shareWKWebView;

@end
