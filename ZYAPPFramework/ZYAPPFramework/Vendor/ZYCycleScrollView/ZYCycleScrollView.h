//
//  ZYCycleScrollView.h
//  ZYCycleScrollView_OC
//
//  Created by sogubaby on 2019/1/16.
//  Copyright © 2019 sogubaby. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZYCycleScrollView;

@protocol ZYCycleScrollViewDelegate <NSObject>

@required

- (NSInteger)zy_numberOfPage;

- (id)zy_cycleScrollView:(ZYCycleScrollView *)cycleScrollView imageDataForItemAtIndex:(NSInteger)index;

@optional

- (void)zy_cycleScrollView:(ZYCycleScrollView *)cycleScrollView didSelectedPageAtIndex:(NSInteger)index image:(UIImage *)image;

@end


@interface ZYCycleScrollView : UIView

@property (nonatomic, weak  ) id<ZYCycleScrollViewDelegate> delegate;

/// 是否隐藏页数 默认false
@property (nonatomic, assign) BOOL hidePageControl;

/// 是否自动滚动 默认true
@property (nonatomic, assign) BOOL autoScroll;

/// 自动滚动的间隔 默认 5.0s
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;

/// 占位图
@property (nonatomic, strong) UIImage *placeholderImage;

/// 图片填充模式，默认UIViewContentModeScaleAspectFill
@property (nonatomic, assign) UIViewContentMode imageContentModel;

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
