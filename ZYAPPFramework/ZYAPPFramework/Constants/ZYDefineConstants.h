//
//  ZYDefineConstants.h
//  ZYAPPFramework
//
//  Created by szy on 2019/1/21.
//  Copyright © 2019 szy. All rights reserved.
//

/************************* 宏定义 ***************************/

#ifndef ZYDefineConstants_h
#define ZYDefineConstants_h

/// 用户是否登录(本地用户token是否为空)
#ifndef kLogining
#define kLogining [ZYUser isLogining]
#endif

#ifndef kScreenWidth
#define kScreenWidth       [UIScreen  mainScreen].bounds.size.width
#endif

#ifndef KScreenHeight
#define KScreenHeight      [UIScreen  mainScreen].bounds.size.height
#endif

#ifndef kScreenScale
#define kScreenScale       [UIScreen mainScreen].scale
#endif

/// 1像素
#ifndef kOnePixels
#define kOnePixels         (1 / [UIScreen mainScreen].scale)
#endif

/// 状态栏高度
#ifndef kStatusBarHeight
#define kStatusBarHeight   [UIApplication sharedApplication].statusBarFrame.size.height
#endif

/// 导航栏高度
#ifndef kNavBarHeight
#define kNavBarHeight      44
#endif

/// 导航栏总高度（状态栏 + 导航栏）
#ifndef kNavTotalHeight
#define kNavTotalHeight    (kStatusBarHeight + kNavBarHeight)
#endif

#ifndef tyWeakSelf
#define tyWeakSelf __weak typeof(self) weakSelf = self
#endif

/// 虚拟home键高度
#ifndef kSafeAreaBottom
#define kSafeAreaBottom [NSObject safeAreaBottom]
#endif

#ifndef kSafeAreaInsets
#define kSafeAreaInsets [NSObject safeAreaInsets]
#endif

#ifndef kScaleW
#define kScaleW(w) ((w) / 414.0 * kScreenWidth)
#endif

#ifndef kScaleH
#define kScaleH(h) ((h)/736.f * MIN(736, KScreenHeight))
#endif

#ifndef kFont
#define kFont(size) [UIFont systemFontOfSize:size]
#endif

#ifndef iPad
#define iPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#endif

#ifndef kRGBColor
#define kRGBColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#endif

#ifndef kRGBAColor
#define kRGBAColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#endif

#ifndef kHexColor
#define kHexColor(hex) [UIColor colorWithRGB:hex]
#endif

#ifndef kHexAColor
#define kHexAColor(hex, a) [UIColor colorWithRGB:hex alpha:a]
#endif

#ifndef kHexStrColor
#define kHexStrColor(hexStr)  [UIColor colorWithHexString:hexStr]
#endif

/// 主题色
#ifndef kThemeColor
#define kThemeColor kHRGB(0x4A6AFF)
#endif

/// 主标题色
#ifndef kTitleColor
#define kTitleColor kHRGB(0x383838)
#endif

/// 副标题色
#ifndef kSubTitleColor
#define kSubTitleColor kHRGB(0x9092a5)
#endif

/// 分割线
#ifndef kLineColor
#define kLineColor kHRGB(0xC2CADC)
#endif

/// 白色
#ifndef kWhiteColor
#define kWhiteColor kHRGB(0xffffff)
#endif

#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

///DebugLog
#ifdef DEBUG
#define DebugLog(s, ...) NSLog(@"%@:%s(%d): %@",[self class], __FUNCTION__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__]);
#else
#define DebugLog(s, ...)
#endif

#ifdef DEBUG
#define DEBUGLog(format, ...) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#else
#define DEBUGLog(format, ...)
#endif

#endif /* ZYDefineConstants_h */
