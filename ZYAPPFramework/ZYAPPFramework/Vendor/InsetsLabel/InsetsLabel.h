
//
//  InsetsLabel.h
//  youyi
//
//  Created by f.g.xiaofange on 16/7/28.
//  Copyright © 2016年 xiaofange. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InsetsLabel : UILabel
@property(nonatomic) UIEdgeInsets insets;
- (id)initWithFrame:(CGRect)frame andInsets:(UIEdgeInsets)insets;
- (id)initWithInsets:(UIEdgeInsets)insets;
@end
