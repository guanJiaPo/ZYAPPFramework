//
//  PEEyptyTableViewCell.m
//  PE
//
//  Created by sogubaby on 2018/11/15.
//  Copyright © 2018年 zhupeng. All rights reserved.
//

#import "ZYEyptyTableCell.h"

@interface ZYEyptyTableCell ()

@property (nonatomic, weak  ) UIImageView *iconView;
@property (nonatomic, weak  ) UILabel *tipLabel;
@end

@implementation ZYEyptyTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

#pragma mark UI

- (void)setupSubViews {
    UIImageView *iconView = [[UIImageView alloc]init];
    iconView.contentMode = UIViewContentModeCenter;
    self.iconView = iconView;
    [self.contentView addSubview:iconView];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView).offset(-14);
    }];
    
    UILabel *tipLabel = [[UILabel alloc]init];
    self.tipLabel = tipLabel;
    tipLabel.font = [UIFont systemFontOfSize:18];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = kHexColor(0x999999);
    [self.contentView addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.iconView.mas_bottom).offset(10);
        make.height.mas_equalTo(18);
    }];
}

- (void)configureWithIcon:(NSString *)iconName tipString:(NSString *)tipString {
    self.iconView.image = [UIImage imageNamed:iconName];
    self.tipLabel.text = tipString;
}

@end
