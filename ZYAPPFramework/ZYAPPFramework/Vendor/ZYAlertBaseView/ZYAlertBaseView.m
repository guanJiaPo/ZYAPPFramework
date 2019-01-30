//
//  ZYAlertBaseView.m
//  PE
//
//  Created by sogubaby on 2018/11/8.
//  Copyright © 2018年 zhupeng. All rights reserved.
//

#import "ZYAlertBaseView.h"

@interface ZYAlertBaseView ()


@property (nonatomic, weak  ) UIView *backgroundView;
@property (nonatomic, weak  ) UIView *contentView;

@property (nonatomic, assign) ZYAlertViewStyle style;
@property (nonatomic, assign) CGFloat contentHeight;

@end

@implementation ZYAlertBaseView

- (instancetype)initWithContentHeight:(CGFloat)contentHeight style:(ZYAlertViewStyle)style
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.contentHeight = contentHeight;
        self.style = style;
        self.bgCancel = true;
        self.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundClicked)];
        UIView *backgroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.backgroundView = backgroundView;
        backgroundView.backgroundColor = [UIColor blackColor];
        backgroundView.alpha = 0;
        [backgroundView addGestureRecognizer:tapGestureRecognizer];
        [self addSubview:backgroundView];
        
        UIView *contentView = [[UIView alloc] init];
        self.contentView = contentView;
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.frame = CGRectMake(0,[UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width,self.contentHeight);
        [self addSubview:contentView];
    }
    return self;
}

#pragma mark - public methods

- (void)presentToWindow {
    [self presentToView:[UIApplication sharedApplication].keyWindow];
}

- (void)presentToView:(UIView *)superView {
    [superView addSubview:self];
    [self showAnimation];
}

- (void)showView {
    [self showAnimation];
}

- (void)hiddenView {
    [self hiddenViewCompletion:nil];
}

- (void)hiddenViewCompletion:(void(^ __nullable)(void))completion {
    [self hiddenAnimation:false completion:completion];
}

- (void)dismissViewCompletion:(void(^ __nullable)(void))completion {
    [self hiddenAnimation:true completion:completion];
}

- (void)dismissView {
    [self dismissViewCompletion:nil];
}

#pragma mark - private methods

- (void)showAnimation {
    self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, self.frame.size.height, self.contentView.frame.size.width, self.contentView.frame.size.height);
    CGFloat contentY = 0;
    switch (self.style) {
        case ZYAlertViewStyleBottom:
            contentY = self.frame.size.height - self.contentView.frame.size.height;
            break;
        case ZYAlertViewStyleCenter:
            contentY = (self.frame.size.height - self.contentView.frame.size.height) * 0.5;
            break;
        default:
            break;
    }
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, contentY, self.contentView.frame.size.width, self.contentView.frame.size.height);
        self.backgroundView.alpha = 0.2;
    } completion:^(BOOL finished) {
    }];
}

- (void)hiddenAnimation:(BOOL)isRemove completion:(void(^ __nullable)(void))completion
{
    [UIView animateWithDuration:0.25 delay:0 options: UIViewAnimationOptionCurveEaseOut animations:^{
        self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, self.frame.size.height, self.contentView.frame.size.width, self.contentView.frame.size.height);
            self.backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
        if (isRemove) {
            [self removeFromSuperview];
        }
    }];
}

#pragma mark action

- (void)backgroundClicked {
    if (self.bgCancel) {
        [self dismissView];
    }
}

#pragma mark setter

- (void)setHorizontalSpace:(NSInteger)horizontalSpace {
    _horizontalSpace = horizontalSpace;
    self.contentView.frame = CGRectMake(horizontalSpace, self.contentView.frame.origin.y, self.frame.size.width - horizontalSpace * 2, self.contentView.frame.size.height);
}



@end
