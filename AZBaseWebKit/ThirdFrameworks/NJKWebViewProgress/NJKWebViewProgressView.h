//
//  NJKWebViewProgressView.h
// iOS 7 Style WebView Progress Bar
//
//  Created by Satoshi Aasano on 11/16/13.
//  Copyright (c) 2013 Satoshi Asano. All rights reserved.
//  Andrew Zhang change 2015-04-30

#import <UIKit/UIKit.h>
#import "NJKWebViewProgress.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#if 1
/** Safari bar color  */
#define TINT_COLOR [UIColor colorWithRed:22.f / 255.f green:126.f / 255.f blue:251.f / 255.f alpha:1.0] // iOS7 Safari bar color
#endif

//#define TINT_COLOR UIColorFromRGB(0x51c422)

@interface NJKWebViewProgressView : UIView
@property (nonatomic) float progress;

@property (nonatomic) UIView *progressBarView;
@property (nonatomic) NSTimeInterval barAnimationDuration; // default 0.1
@property (nonatomic) NSTimeInterval fadeAnimationDuration; // default 0.27
@property (nonatomic) NSTimeInterval fadeOutDelay; // default 0.1

- (void)setProgress:(float)progress animated:(BOOL)animated;

@end
