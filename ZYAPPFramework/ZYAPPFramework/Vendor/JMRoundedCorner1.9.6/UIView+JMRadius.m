//
//  UIView+RoundedCorner.m
//  UIImageRoundedCornerDemo
//
//  Created by jm on 16/2/25.
//  Copyright © 2016年 Jim. All rights reserved.
//

#import "UIView+JMRadius.h"
#import <objc/runtime.h>

static NSOperationQueue *jm_operationQueue;
static char jm_operationKey;

@implementation UIView (RoundedCorner)

+ (void)load {
    jm_operationQueue = [[NSOperationQueue alloc] init];
}

- (NSOperation *)jm_getOperation {
    id operation = objc_getAssociatedObject(self, &jm_operationKey);
    return operation;
}

- (void)jm_setImageWithOperation:(NSOperation *)operation {
    objc_setAssociatedObject(self, &jm_operationKey, operation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)jm_cancelOperation {
    NSOperation *operation = [self jm_getOperation];
    [operation cancel];
    [self jm_setImageWithOperation:nil];
}

#pragma mark UIView

- (void)jm_setImageWithCornerRadius:(CGFloat)radius image:(UIImage *)image {
    [self jm_setImageWithCornerRadius:radius image:image borderColor:nil borderWidth:0 backgroundColor:nil contentMode:UIViewContentModeScaleAspectFill];
}

- (void)jm_setImageWithJMRadius:(JMRadius)radius image:(UIImage *)image {
    [self jm_setImageWithJMRadius:radius image:image borderColor:nil borderWidth:0 backgroundColor:nil contentMode:UIViewContentModeScaleAspectFill];
}

- (void)jm_setImageWithCornerRadius:(CGFloat)radius image:(UIImage *)image contentMode:(UIViewContentMode)contentMode {
    [self jm_setImageWithCornerRadius:radius image:image borderColor:nil borderWidth:0 backgroundColor:nil contentMode:contentMode];
}

- (void)jm_setImageWithJMRadius:(JMRadius)radius image:(UIImage *)image contentMode:(UIViewContentMode)contentMode {
    [self jm_setImageWithJMRadius:radius image:image borderColor:nil borderWidth:0 backgroundColor:nil contentMode:contentMode];
}

- (void)jm_setImageWithCornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor {
    [self jm_setImageWithCornerRadius:radius image:nil borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor contentMode:UIViewContentModeScaleAspectFill];
}

- (void)jm_setImageWithJMRadius:(JMRadius)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor {
    [self jm_setImageWithJMRadius:radius image:nil borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor contentMode:UIViewContentModeScaleAspectFill];
}

- (void)jm_setImageWithCornerRadius:(CGFloat)radius image:(UIImage *)image borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor contentMode:(UIViewContentMode)contentMode {
    [self jm_setImageWithJMRadius:JMRadiusMake(radius, radius, radius, radius) image:image borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor contentMode:contentMode];
}

- (void)jm_setImageWithJMRadius:(JMRadius)radius image:(UIImage *)image borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor contentMode:(UIViewContentMode)contentMode {
    [self jm_setImageWithJMRadius:radius image:image borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor contentMode:contentMode size:CGSizeZero forState:UIControlStateNormal];
}

- (void)jm_setImageWithJMRadius:(JMRadius)radius image:(UIImage *)image borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor contentMode:(UIViewContentMode)contentMode size:(CGSize)size completion:(JMRoundedCornerCompletionBlock)completion {
    [self jm_setImageWithJMRadius:radius image:image borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor contentMode:contentMode size:size forState:UIControlStateNormal background:NO completion:completion];
}

#pragma mark UIButton

- (void)jm_setCornerRadius:(CGFloat)radius backgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self jm_setImageWithCornerRadius:radius image:nil borderColor:nil borderWidth:0 backgroundColor:backgroundColor forState:state];
}

- (void)jm_setJMRadius:(JMRadius)radius backgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self jm_setImageWithJMRadius:radius image:nil borderColor:nil borderWidth:0 backgroundColor:backgroundColor forState:state];
}

- (void)jm_setCornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self jm_setImageWithCornerRadius:radius image:nil borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor forState:state];
}

- (void)jm_setJMRadius:(JMRadius)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self jm_setImageWithJMRadius:radius image:nil borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor forState:state];
}

- (void)jm_setJMRadius:(JMRadius)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor size:(CGSize)size forState:(UIControlState)state {
    [self jm_setImageWithJMRadius:radius image:nil borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor contentMode:UIViewContentModeScaleAspectFill size:size forState:state];
}

- (void)jm_setImageWithCornerRadius:(CGFloat)radius image:(UIImage *)image forState:(UIControlState)state {
    [self jm_setImageWithCornerRadius:radius image:image borderColor:nil borderWidth:0 backgroundColor:nil forState:state];
}

- (void)jm_setBackgroundImageWithCornerRadius:(CGFloat)radius image:(UIImage *)image forState:(UIControlState)state {
    [self jm_setBackgroundImageWithCornerRadius:radius image:image borderColor:nil borderWidth:0 backgroundColor:nil forState:state];
}

- (void)jm_setImageWithJMRadius:(JMRadius)radius image:(UIImage *)image forState:(UIControlState)state {
    [self jm_setImageWithJMRadius:radius image:image borderColor:nil borderWidth:0 backgroundColor:nil forState:state];
}

- (void)jm_setBackgroundImageWithJMRadius:(JMRadius)radius image:(UIImage *)image forState:(UIControlState)state {
    [self jm_setBackgroundImageWithJMRadius:radius image:image borderColor:nil borderWidth:0 backgroundColor:nil forState:state];
}

- (void)jm_setImageWithCornerRadius:(CGFloat)radius image:(UIImage *)image contentMode:(UIViewContentMode)contentMode forState:(UIControlState)state {
    [self jm_setImageWithCornerRadius:radius image:image borderColor:nil borderWidth:0 backgroundColor:nil forState:state];
}

- (void)jm_setBackgroundImageWithCornerRadius:(CGFloat)radius image:(UIImage *)image contentMode:(UIViewContentMode)contentMode forState:(UIControlState)state {
    [self jm_setBackgroundImageWithCornerRadius:radius image:image borderColor:nil borderWidth:0 backgroundColor:nil forState:state];
}

- (void)jm_setImageWithCornerRadius:(CGFloat)radius image:(UIImage *)image borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self jm_setImageWithJMRadius:JMRadiusMake(radius, radius, radius, radius) image:image borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor contentMode:UIViewContentModeScaleAspectFill size:self.bounds.size forState:state];
}

- (void)jm_setBackgroundImageWithCornerRadius:(CGFloat)radius image:(UIImage *)image borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self jm_setBackgroundImageWithJMRadius:JMRadiusMake(radius, radius, radius, radius) image:image borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor contentMode:UIViewContentModeScaleAspectFill size:self.bounds.size forState:state];
}

- (void)jm_setImageWithJMRadius:(JMRadius)radius image:(UIImage *)image borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self jm_setImageWithJMRadius:radius image:image borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor contentMode:UIViewContentModeScaleAspectFill size:self.bounds.size forState:state];
}

- (void)jm_setBackgroundImageWithJMRadius:(JMRadius)radius image:(UIImage *)image borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self jm_setBackgroundImageWithJMRadius:radius image:image borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor contentMode:UIViewContentModeScaleAspectFill size:self.bounds.size forState:state];
}


- (void)jm_setImageWithJMRadius:(JMRadius)radius image:(UIImage *)image borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor contentMode:(UIViewContentMode)contentMode size:(CGSize)size forState:(UIControlState)state {
    [self jm_setImageWithJMRadius:radius image:image borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor contentMode:contentMode size:size forState:state completion:nil];
}

- (void)jm_setBackgroundImageWithJMRadius:(JMRadius)radius image:(UIImage *)image borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor contentMode:(UIViewContentMode)contentMode size:(CGSize)size forState:(UIControlState)state {
    [self jm_setBackgorundImageWithJMRadius:radius image:image borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor contentMode:contentMode size:size forState:state completion:nil];
}

- (void)jm_setImageWithJMRadius:(JMRadius)radius image:(UIImage *)image borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor contentMode:(UIViewContentMode)contentMode size:(CGSize)size forState:(UIControlState)state  completion:(JMRoundedCornerCompletionBlock)completion {
    [self jm_setImageWithJMRadius:radius image:image borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor contentMode:contentMode size:size forState:state background:NO completion:completion];
}

- (void)jm_setBackgorundImageWithJMRadius:(JMRadius)radius image:(UIImage *)image borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor contentMode:(UIViewContentMode)contentMode size:(CGSize)size forState:(UIControlState)state completion:(JMRoundedCornerCompletionBlock)completion {
    [self jm_setImageWithJMRadius:radius image:image borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor contentMode:contentMode size:size forState:state background:YES completion:completion];
}

#pragma mark base method

- (void)jm_setImageWithJMRadius:(JMRadius)radius image:(UIImage *)image borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor contentMode:(UIViewContentMode)contentMode size:(CGSize)size forState:(UIControlState)state  background:(BOOL)background completion:(JMRoundedCornerCompletionBlock)completion {
    [self jm_cancelOperation];
    __block CGSize _size = size;
    
    __weak typeof(self) weakSelf = self;
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        
        if ([[weakSelf jm_getOperation] isCancelled]) return;
        
        if (CGSizeEqualToSize(_size, CGSizeZero)) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                _size = weakSelf.bounds.size;
            });
        }
        CGSize pixelSize = CGSizeMake(pixel(_size.width), pixel(_size.height));
        UIImage *currentImage = [UIImage jm_setJMRadius:radius image:(UIImage *)image size:pixelSize borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor withContentMode:contentMode];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            __strong typeof(weakSelf) self = weakSelf;
            if ([[self jm_getOperation] isCancelled]) return;
            self.frame = CGRectMake(pixel(self.frame.origin.x), pixel(self.frame.origin.y), pixelSize.width, pixelSize.height);
            if ([self isKindOfClass:[UIImageView class]]) {
                ((UIImageView *)self).image = currentImage;
            } else if ([self isKindOfClass:[UIButton class]] && image) {
                if (background) {
                    [((UIButton *)self) setBackgroundImage:currentImage forState:state];
                } else {
                    [((UIButton *)self) setImage:currentImage forState:state];
                }
            } else if ([self isKindOfClass:[UILabel class]]) {
                self.layer.backgroundColor = [UIColor colorWithPatternImage:currentImage].CGColor;
            } else {
                self.layer.contents = (__bridge id _Nullable)(currentImage.CGImage);
            }
            if (completion) completion(currentImage);
        }];
    }];
    
    [self jm_setImageWithOperation:blockOperation];
    [jm_operationQueue addOperation:blockOperation];
}

static inline CGFloat pixel(CGFloat num) {
    CGFloat unit = 1.0 / [UIScreen mainScreen].scale;
    CGFloat remain = fmod(num, unit);
    return num - remain + (remain >= unit / 2.0? unit: 0);
}

@end
