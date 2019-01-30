//
//  PEEyptyTableViewCell.h
//  PE
//
//  Created by sogubaby on 2018/11/15.
//  Copyright © 2018年 zhupeng. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const PEEyptyTableCellIdfi = @"PEEyptyTableCell";

@interface ZYEyptyTableCell : UITableViewCell

- (void)configureWithIcon:(NSString *)iconName tipString:(NSString *)tipString;

@end
