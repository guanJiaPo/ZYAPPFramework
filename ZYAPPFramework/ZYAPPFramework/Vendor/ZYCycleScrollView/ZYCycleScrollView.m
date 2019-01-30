//
//  ZYCycleScrollView.m
//  ZYCycleScrollView_OC
//
//  Created by sogubaby on 2019/1/16.
//  Copyright © 2019 sogubaby. All rights reserved.
//

#import "ZYCycleScrollView.h"
#import "UIImageView+WebCache.h"

#define currentTintColor [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
#define pageTintColor [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];

/// 手指的滑动方向
typedef enum : NSUInteger {
    ZYScrollDirectionNone = 0,
    ZYScrollDirectionLeft,
    ZYScrollDirectionRight,
} ZYScrollDirection;

@interface ZYCycleScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *currentImageView;

@property (nonatomic, strong) UIImageView *otherImageView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSTimer *timer;

/// 当前显示的图片的index
@property (nonatomic, assign) NSInteger currentIndex;
/// 将要显示的图片的index
@property (nonatomic, assign) NSInteger otherIndex;
/// 图片数量
@property (nonatomic, assign) NSInteger imageCount;
/// 当前位于scrollView的第几页
@property (nonatomic, assign) NSInteger currentPage;

/// 手指的滑动方向
@property (nonatomic, assign) ZYScrollDirection scrollDirection;

@end

@implementation ZYCycleScrollView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupSubViews];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

#pragma mark UI

- (void)setupSubViews {
    self.autoScroll = true;
    self.hidePageControl = false;
    self.autoScrollTimeInterval = 5.0;
    self.currentIndex = 0;
    self.otherIndex = 0;
    self.imageCount = 0;
    self.currentPage = 1;
    self.scrollDirection = ZYScrollDirectionNone;
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.currentImageView];
    [self.scrollView addSubview:self.otherImageView];
    [self addSubview:self.pageControl];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (newSuperview == nil) {
        if (self.autoScroll) {
            [self.timer invalidate];
            self.timer = nil;
        }
    }
}

#pragma mark public

- (void)reloadData {
    if (![self.delegate respondsToSelector:@selector(zy_numberOfPage)]) {
        return;
    }
    
    self.imageCount = [self.delegate zy_numberOfPage];
    self.pageControl.numberOfPages = self.imageCount;
    self.pageControl.currentPage = self.currentIndex;
    self.scrollView.scrollEnabled = self.imageCount > 1;
    if (self.imageCount > 0) {
        if (self.currentIndex >= self.imageCount) {
            self.currentIndex = self.imageCount - 1;
        }
        [self loadImage:self.currentImageView index:self.currentIndex];
        if (self.autoScroll) {
            self.timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:self.autoScrollTimeInterval];
        }
    }
}

#pragma mark action

/// 图片点击事件
- (void)tapCurrentImageView {
    if ([self.delegate respondsToSelector:@selector(zy_cycleScrollView:didSelectedPageAtIndex:image:)]) {
        [self.delegate zy_cycleScrollView:self didSelectedPageAtIndex:self.currentIndex image:self.currentImageView.image];
    }
}

#pragma mark private

/// 加载图片
- (void)loadImage:(UIImageView *)imageView index:(NSInteger)index {
    if (![self.delegate respondsToSelector:@selector(zy_cycleScrollView:imageDataForItemAtIndex:)]) {
        return;
    }
    
    id imageData = [self.delegate zy_cycleScrollView:self imageDataForItemAtIndex:index];
    
    if ([imageData isKindOfClass:[NSString class]]) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageData] placeholderImage:self.placeholderImage];
    } else if ([imageData isKindOfClass:[NSURL class]]) {
        [imageView sd_setImageWithURL:imageData placeholderImage:self.placeholderImage];
    } else if ([imageData isKindOfClass:[UIImage class]]) {
        imageView.image = imageData ?: self.placeholderImage;
    } else {
        imageView.image = self.placeholderImage;
    }
}

/// 定时器 自动滚动
- (void)autoCycleScroll {
    /// 左滑, 显示下一张
    if (self.currentIndex == self.imageCount - 1) {
        self.otherIndex = 0;
    } else {
        self.otherIndex = self.currentIndex + 1;
    }
    self.otherImageView.frame = CGRectMake(self.scrollView.frame.size.width * 2, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self loadImage:self.otherImageView index:self.otherIndex];
    [UIView animateWithDuration:0.25 animations:^{
        self.scrollView.contentOffset = CGPointMake(self.frame.size.width * 2, 0);
    } completion:^(BOOL finished) {
        self.currentIndex = self.otherIndex;
        self.pageControl.currentPage = self.currentIndex;
        self.currentImageView.image = self.otherImageView.image;
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    }];
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offSetX = scrollView.contentOffset.x;
    if (offSetX > scrollView.frame.size.width) {
        ZYScrollDirection slideDirection = ZYScrollDirectionLeft;
        if (slideDirection != self.scrollDirection) {
            /// 左滑, 显示下一张
            if (self.currentIndex == self.imageCount - 1) {
                self.otherIndex = 0;
            } else {
                self.otherIndex = self.currentIndex + 1;
            }
            self.scrollDirection = slideDirection;
            self.otherImageView.frame = CGRectMake(scrollView.frame.size.width * 2, 0, scrollView.frame.size.width, scrollView.frame.size.height);
            [self loadImage:self.otherImageView index:self.otherIndex];
        }
    } else {
        ZYScrollDirection slideDirection = ZYScrollDirectionRight;
        if (slideDirection != self.scrollDirection) {
            /// 右滑, 显示上一张
            if (self.currentIndex == 0) {
                self.otherIndex = self.imageCount - 1;
            } else {
                self.otherIndex = self.currentIndex - 1;
            }
            self.scrollDirection = slideDirection;
            self.otherImageView.frame = CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height);
            [self loadImage:self.otherImageView index:self.otherIndex];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    /// 清除滑动方向
    self.scrollDirection = ZYScrollDirectionNone;
    NSInteger page = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
    if (page != self.currentPage) {
        self.currentIndex = self.otherIndex;
        self.pageControl.currentPage = self.currentIndex;
        self.currentImageView.image = self.otherImageView.image;
        scrollView.contentOffset = CGPointMake(scrollView.frame.size.width, 0);
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.autoScroll) {
        self.timer.fireDate = [NSDate distantFuture];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.autoScroll) {
        self.timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:self.autoScrollTimeInterval];
    }
}

#pragma mark setter

- (void)setHidePageControl:(BOOL)hidePageControl {
    _hidePageControl = hidePageControl;
    self.pageControl.hidden = hidePageControl;
}

- (void)setImageContentModel:(UIViewContentMode)imageContentModel {
    _imageContentModel = imageContentModel;
    self.currentImageView.contentMode = imageContentModel;
    self.otherImageView.contentMode = imageContentModel;
}

#pragma mark getter

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(self.frame.size.width * 3, self.frame.size.height);
        _scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
        _scrollView.showsVerticalScrollIndicator = false;
        _scrollView.showsHorizontalScrollIndicator = false;
        _scrollView.pagingEnabled = true;
        _scrollView.scrollEnabled = false;
    }
    return _scrollView;
}

- (UIImageView *)currentImageView {
    if (_currentImageView == nil) {
        _currentImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
        _currentImageView.clipsToBounds = true;
        _currentImageView.contentMode = UIViewContentModeScaleAspectFill;
        _currentImageView.userInteractionEnabled = true;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCurrentImageView)];
        [_currentImageView addGestureRecognizer:tap];
    }
    return _currentImageView;
}

- (UIImageView *)otherImageView {
    if (_otherImageView == nil) {
        _otherImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.scrollView.frame.size.width * 2, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
        _otherImageView.clipsToBounds = true;
        _otherImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _otherImageView;
}

- (UIPageControl *)pageControl {
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 24, self.scrollView.frame.size.width, 24)];
        _pageControl.hidesForSinglePage = true;
        _pageControl.currentPageIndicatorTintColor = currentTintColor;
        _pageControl.pageIndicatorTintColor = pageTintColor;
    }
    return _pageControl;
}

- (NSTimer *)timer {
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(autoCycleScroll) userInfo:nil repeats:true];
    }
    return _timer;
}

@end
