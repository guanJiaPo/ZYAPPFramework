//
//  PEEmptyCollectionCell.h
//  PE
//
//  Created by sogubaby on 2018/11/15.
//  Copyright © 2018年 zhupeng. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const ZYEmptyCollectionCellIdfi = @"PEEmptyCollectionCell";

@interface ZYEmptyCollectionCell : UICollectionViewCell

- (void)configureWithIcon:(NSString *)iconName tipString:(NSString *)tipString;

@end
