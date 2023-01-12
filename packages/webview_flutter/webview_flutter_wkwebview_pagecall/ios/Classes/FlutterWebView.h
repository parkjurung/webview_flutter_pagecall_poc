// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <Flutter/Flutter.h>
#import <WebKit/WebKit.h>
//#import <webview_flutter_wkwebview_pagecall-Swift.h> // dev

NS_ASSUME_NONNULL_BEGIN

/**
 * The WkWebView used for the plugin.
 *
 * This class overrides some methods in `WKWebView` to serve the needs for the plugin.
 */

// PagecallWebView 쓸때는 아래 커맨트아웃 하셈
//@interface FLTWKWebView : WKWebView
//@end

@interface FLTWebViewController : NSObject <FlutterPlatformView, WKUIDelegate>

//@property(nonatomic) FLTWKWebView* webView;
@property(nonatomic) WKWebView* webView;

- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
              binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;

- (UIView*)view;

- (void)onMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result;

@end

@interface FLTWebViewFactory : NSObject <FlutterPlatformViewFactory>
- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;
@end

NS_ASSUME_NONNULL_END
