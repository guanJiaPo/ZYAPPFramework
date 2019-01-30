//
//  InsetsLabel.m
//  youyi
//
//  Created by f.g.xiaofange on 16/7/28.
//  Copyright © 2016年 xiaofange. All rights reserved.
//

#import "InsetsLabel.h"

@implementation InsetsLabel

- (id)initWithFrame:(CGRect)frame andInsets:(UIEdgeInsets)insets
{
    if(self = [super initWithFrame:frame]){
        self.insets = insets;
    }
    return  self;
}

- (id)initWithInsets:(UIEdgeInsets)insets
{
    if(self = [super init]){
        self.insets = insets;
    }
    return  self;
}

- (void)drawTextInRect:(CGRect)rect {
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.insets)];
}

@end
