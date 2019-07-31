//
//  MyMacro.h
//  ProjectFrameDemo
//
//  Created by scj on 2019/7/27.
//  Copyright © 2019 scj. All rights reserved.
//

#ifndef MyMacro_h
#define MyMacro_h

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0]
#define HEXColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue &0xFF00) >>8))/255.0 blue:((float)(rgbValue &0xFF))/255.0 alpha:1.0]
#define kRandomColor  [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1.0]
// 字体 屏幕 适配
#define IOS_VERSION_10_OR_LATER (([[[UIDevice currentDevice]systemVersion]floatValue]>=10.0)? (YES):(NO))
#define NEAdapationLabelFont(n) (IOS_VERSION_10_OR_LATER?((n-1)*([[UIScreen mainScreen]bounds].size.width/375.0f)):(n*([[UIScreen mainScreen]bounds].size.width/375.0f)))

/// 1.iOS系统版本
#define kSystemVersion [[UIDevice currentDevice].systemVersion doubleValue]

/// 3.判断手机型号
#define kisiPhone4  ([UIScreen mainScreen].bounds.size.height == 480)
#define kisiPhone5  ([UIScreen mainScreen].bounds.size.height == 568)
#define kisiPhone6  ([UIScreen mainScreen].bounds.size.height == 667)
#define kisiPhone6p ([UIScreen mainScreen].bounds.size.height == 736)
#define kisiPhoneX   \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})
#define kNavHeight  (kisiPhoneX ? 88 : 64)
#define kTabHeight  (kisiPhoneX ? 83 : 49)
#define kNavOffset  (kisiPhoneX ? 24 : 0)
#define kStatusBarHeight  (kisiPhoneX ? 44 : 20)

#define kIPhoneInditorBottomMargin (kisiPhoneX ? 34.0f : 0)
/// 4.屏幕大小尺寸
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

//弱引用
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self
#define SS(strongSelf)  __strong __typeof(&*self)strongSelf = self

#define kAdjust6LowWidth(width) (width * (kScreenWidth / 375.0f < 1.0f ? kScreenWidth / 375.0f: 1.0f))
#define kAdjust6LowHeight(height) (height * (kScreenHeight / 667.0f < 1.0f ? kScreenHeight / 667.0f : 1.0f))

#define kAdjust6WidthScale (kScreenWidth / 375.0f)
#define kAdjust6HeightScale (kScreenHeight / 667.0f)

#define kAdjust6Width(width) (width * kScreenWidth / 375.0f)
#define kAdjust6Height(height) (height * kScreenHeight / 667.0f)

#define USERDEVICEKICKED 25013
#define USERTOKENOUTDATE 25014
#define USERDISABLED 11003


#define RWNEEDPUSHLOGIN     if ([RWUserModel shareInstance].hasLogind == NO) {\
[RWLoginController openLogin];\
return;\
}

#define TEXTLIMIT @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"//数字和字母
#endif /* RWMacro_h */
