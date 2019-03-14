//
//  UIButton+JMRadius.m
//  JMRoundedCornerDemo
//
//  Created by 饶志臻 on 2016/10/9.
//  Copyright © 2016年 饶志臻. All rights reserved.
//

#import "UIButton+JMRadius.h"

#if __has_include(<SDWebImage/UIButton+WebCache.h>)
#import <SDWebImage/UIButton+WebCache.h>
#else
#import "UIButton+WebCache.h"
#endif


@implementation UIButton (JMRadius)

#pragma mark setImage

- (void)jm_setImageWithCornerRadius:(CGFloat)radius imageURL:(NSURL *)imageURL placeholder:(UIImage *)placeholder size:(CGSize)size forState:(UIControlState)state {
    [self jm_setImageWithJMRadius:JMRadiusMake(radius, radius, radius, radius) imageURL:imageURL placeholder:placeholder borderColor:nil borderWidth:0 backgroundColor:nil contentMode:UIViewContentModeScaleAspectFill size:size forState:(UIControlState)state];
}

- (void)jm_setImageWithJMRadius:(JMRadius)radius imageURL:(NSURL *)imageURL placeholder:(UIImage *)placeholder size:(CGSize)size forState:(UIControlState)state {
    [self jm_setImageWithJMRadius:radius imageURL:imageURL placeholder:placeholder borderColor:nil borderWidth:0 backgroundColor:nil contentMode:UIViewContentModeScaleAspectFill size:size forState:(UIControlState)state];
}

- (void)jm_setImageWithCornerRadius:(CGFloat)radius imageURL:(NSURL *)imageURL placeholder:(UIImage *)placeholder contentMode:(UIViewContentMode)contentMode size:(CGSize)size forState:(UIControlState)state {
    [self jm_setImageWithJMRadius:JMRadiusMake(radius, radius, radius, radius) imageURL:imageURL placeholder:placeholder borderColor:nil borderWidth:0 backgroundColor:nil contentMode:contentMode size:size forState:(UIControlState)state];
}

- (void)jm_setImageWithJMRadius:(JMRadius)radius imageURL:(NSURL *)imageURL placeholder:(UIImage *)placeholder contentMode:(UIViewContentMode)contentMode size:(CGSize)size forState:(UIControlState)state {
    [self jm_setImageWithJMRadius:radius imageURL:imageURL placeholder:placeholder borderColor:nil borderWidth:0 backgroundColor:nil contentMode:contentMode size:size forState:(UIControlState)state];
}

- (void)jm_setImageWithJMRadius:(JMRadius)radius imageURL:(NSURL *)imageURL placeholder:(UIImage *)placeholder borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor contentMode:(UIViewContentMode)contentMode size:(CGSize)size forState:(UIControlState)state {
    
    [self jm_setImageWithJMRadius:radius imageURL:imageURL placeholder:placeholder borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor contentMode:contentMode size:size forState:state background:NO];
}

#pragma mark setBackgroundImage

- (void)jm_setBackgroundImageWithCornerRadius:(CGFloat)radius imageURL:(NSURL *)imageURL placeholder:(UIImage *)placeholder size:(CGSize)size forState:(UIControlState)state {
    [self jm_setBackgroundImageWithJMRadius:JMRadiusMake(radius, radius, radius, radius) imageURL:imageURL placeholder:placeholder borderColor:nil borderWidth:0 backgroundColor:nil contentMode:UIViewContentModeScaleAspectFill size:size forState:(UIControlState)state];
}

- (void)jm_setBackgroundImageWithJMRadius:(JMRadius)radius imageURL:(NSURL *)imageURL placeholder:(UIImage *)placeholder size:(CGSize)size forState:(UIControlState)state {
    [self jm_setBackgroundImageWithJMRadius:radius imageURL:imageURL placeholder:placeholder borderColor:nil borderWidth:0 backgroundColor:nil contentMode:UIViewContentModeScaleAspectFill size:size forState:(UIControlState)state];
}

- (void)jm_setBackgroundImageWithCornerRadius:(CGFloat)radius imageURL:(NSURL *)imageURL placeholder:(UIImage *)placeholder contentMode:(UIViewContentMode)contentMode size:(CGSize)size forState:(UIControlState)state {
    [self jm_setBackgroundImageWithJMRadius:JMRadiusMake(radius, radius, radius, radius) imageURL:imageURL placeholder:placeholder borderColor:nil borderWidth:0 backgroundColor:nil contentMode:contentMode size:size forState:(UIControlState)state];
}

- (void)jm_setBackgroundImageWithJMRadius:(JMRadius)radius imageURL:(NSURL *)imageURL placeholder:(UIImage *)placeholder contentMode:(UIViewContentMode)contentMode size:(CGSize)size forState:(UIControlState)state {
    [self jm_setBackgroundImageWithJMRadius:radius imageURL:imageURL placeholder:placeholder borderColor:nil borderWidth:0 backgroundColor:nil contentMode:contentMode size:size forState:(UIControlState)state];
}

- (void)jm_setBackgroundImageWithJMRadius:(JMRadius)radius imageURL:(NSURL *)imageURL placeholder:(UIImage *)placeholder borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor contentMode:(UIViewContentMode)contentMode size:(CGSize)size forState:(UIControlState)state {
    [self jm_setImageWithJMRadius:radius imageURL:imageURL placeholder:placeholder borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor contentMode:contentMode size:size forState:state background:YES];
}

#pragma mark base method

- (void)jm_setImageWithJMRadius:(JMRadius)radius imageURL:(NSURL *)imageURL placeholder:(UIImage *)placeholder borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor contentMode:(UIViewContentMode)contentMode size:(CGSize)size forState:(UIControlState)state background:(BOOL)background {
    
    NSString *transformKey =  [NSString stringWithFormat:@"%@%@%.1f%@%li%@", NSStringFromJMRadius(radius), borderColor.description, borderWidth, backgroundColor.description, (long)contentMode,NSStringFromCGSize(size)];
    /// 1. 从缓存中取已裁剪的图片
    NSString *transformImageKey = [NSString stringWithFormat:@"%@%@",imageURL.absoluteString, transformKey];
    UIImage *cacheImage = [[SDWebImageManager sharedManager].imageCache imageFromCacheForKey:transformImageKey];
    if (cacheImage) {
        if (background) {
            [self setBackgroundImage:cacheImage forState:state];
        } else {
            [self setImage:cacheImage forState:state];
        }
        return;
    }
    
    /// 2. 没有已裁剪的图片，从缓存中取原图片，再进行裁剪
    NSString *imageKey = [[SDWebImageManager sharedManager] cacheKeyForURL:imageURL];
    cacheImage = [[SDWebImageManager sharedManager].imageCache imageFromCacheForKey:imageKey];
    if (cacheImage) {
        cacheImage = [UIImage jm_setJMRadius:radius image:cacheImage size:size borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor withContentMode:contentMode];
        if (background) {
            [self setBackgroundImage:cacheImage forState:state];
        } else {
            [self setImage:cacheImage forState:state];
        }
        return;
    }
    
    /// 3. 缓存中没有图片，下载图片裁剪并缓存
    if (placeholder || borderWidth > 0 || backgroundColor) {
        placeholder = [UIImage jm_setJMRadius:radius image:nil size:size borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor withContentMode:contentMode];
    }
    if (background) {
        [self sd_setBackgroundImageWithURL:imageURL forState:state placeholderImage:placeholder completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (image) {
                UIImage *currentImage = [UIImage jm_setJMRadius:radius image:image size:size borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor withContentMode:contentMode];
                [self setBackgroundImage:currentImage forState:state];
                [[SDWebImageManager sharedManager].imageCache storeImage:currentImage forKey:transformImageKey completion:nil];
            }
        }];
    } else {
        [self sd_setImageWithURL:imageURL forState:state placeholderImage:placeholder completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (image) {
                UIImage *currentImage = [UIImage jm_setJMRadius:radius image:image size:size borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor withContentMode:contentMode];
                [self setImage:currentImage forState:state];
                [[SDWebImageManager sharedManager].imageCache storeImage:currentImage forKey:transformImageKey completion:nil];
            }
        }];
    }
    
}

@end
