//
//  Common.h
//  Zonbo
//
//  Created by 步云 on 2018/1/8.
//  Copyright © 2018年 步云. All rights reserved.
//

#ifndef Common_h
#define Common_h


#define fScreenW [UIScreen mainScreen].bounds.size.width
#define fScreenH [UIScreen mainScreen].bounds.size.height





#define kStatusBarH 20
#define kNavigationBarH 44

#define WXAppID @"wx0e34274ace6d93b2"//微信AppID
#define OnlineUrl @"http://app.fjzb666.com/#/%@"//线上

//#define OnlineUrl @"http://192.168.180.105:8086/#/%@"//小赖
//#define OnlineUrl @"http://192.168.180.135:8086/#/%@"//李杰URL


#define URL_APPID @"wx41a0b1601e0bc191"
#define URL_SECRET @"2267eb4f3b85be0c5b4f99a774b32d97"
#define Qr_code_url @"http://wechat.fjzb666.com/#/register?userid"//推广码：扫描二维码的url


#define DefineWeakSelf __weak __typeof(self) weakSelf = self



#define fViewWidth self.frame.size.width
#define fViewHeight self.frame.size.height

#define Show_Alert(_message_) UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:_message_ preferredStyle:UIAlertControllerStyleAlert]; \
[alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]]; \
[self presentViewController:alert animated:YES completion:nil];

#define FunCOLOR(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define NULL_STR(str)   (str == nil || (NSNull *)str == [NSNull null] || str.length == 0 || [str isEqualToString:@"(null)"] || [str isEqualToString:@"<null>"] || [str isEqualToString:@""])

#ifdef DEBUG
#define SLog(format, ...) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#else
#define SLog(format, ...)
#endif

/** 色值 RGBA **/
#define RGB_A(r, g, b, a) [UIColor colorWithRed:(CGFloat)(r)/255.0f green:(CGFloat)(g)/255.0f blue:(CGFloat)(b)/255.0f alpha:(CGFloat)(a)]
/** 色值 RGB **/
#define RGB(r, g, b) RGB_A(r, g, b, 1)
#define RGB_HEX(__h__) RGB((__h__ >> 16) & 0xFF, (__h__ >> 8) & 0xFF, __h__ & 0xFF)
#define APPCONFIG_UNIT_LINE_WIDTH                (1/[UIScreen mainScreen].scale)       //常用线宽



//LBXScan 如果需要使用LBXScanViewController控制器代码，那么下载了那些模块，请定义对应的宏
#define LBXScan_Define_Native  //包含native库
#define LBXScan_Define_ZXing   //包含ZXing库
#define LBXScan_Define_ZBar   //包含ZBar库
#define LBXScan_Define_UI     //包含界面库

//iPhoneX机型判断
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ?  CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define ZXLNavigationBarAdapterContentInsetTop (IS_IPHONE_X? 88.0f:64.0f) //顶部偏移


#define ZBWidth  [[UIScreen mainScreen]bounds].size.width
#define ZBHeight   [[UIScreen mainScreen]bounds].size.height

#define UI_IS_IPHONE_X        [[UIScreen mainScreen] bounds].size.height >= 812.0f
#define UI_IS_IPHONE_8P        [[UIScreen mainScreen] bounds].size.width >= 414.0f
#define UI_IS_IPHONE_SE        [[UIScreen mainScreen] bounds].size.width <= 320.0f
#define UI_IS_IPHONE_6        [[UIScreen mainScreen] bounds].size.height == 667.0f
#define ZBTabIPHONEX    (UI_IS_IPHONE_X ? 83.0f : 49.0f)
#define ZBNaviIPHONEX  (UI_IS_IPHONE_X ? 88.0f : 64.0f)

#define ZBSystemiOS        [[UIDevice currentDevice].systemVersion floatValue]

#endif /* Common_h */
