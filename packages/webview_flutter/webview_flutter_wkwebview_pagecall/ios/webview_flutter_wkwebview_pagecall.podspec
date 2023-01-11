#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'webview_flutter_wkwebview_pagecall'
  s.version          = '0.0.1'
  s.summary          = 'A WebView Plugin for Flutter.'
  s.description      = <<-DESC
A Flutter plugin that provides a WebView widget.
Downloaded by pub (not CocoaPods).
                       DESC
  s.homepage         = 'https://github.com/flutter/plugins'
  s.license          = { :type => 'BSD', :file => '../LICENSE' }
  s.author           = { 'Flutter Dev Team' => 'flutter-dev@googlegroups.com' }
  s.source           = { :http => 'https://github.com/flutter/plugins/tree/master/packages/webview_flutter/webview_flutter_wkwebview' }
  s.swift_version = '5.0'
  s.documentation_url = 'https://pub.dev/packages/webview_flutter'
  s.source_files = 'Classes/**/*.{h,m,swift}'
  s.public_header_files = 'Classes/**/*.h'
  # s.module_map = 'Classes/FlutterWebView.modulemap'
  s.resources = 'Classes/**/*.js'
  s.dependency 'Flutter'
  s.dependency 'AmazonChimeSDK-No-Bitcode', '0.22.0'
  s.dependency 'AmazonChimeSDKMedia-No-Bitcode', '0.17.4'

  s.platform = :ios, '11.0'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
