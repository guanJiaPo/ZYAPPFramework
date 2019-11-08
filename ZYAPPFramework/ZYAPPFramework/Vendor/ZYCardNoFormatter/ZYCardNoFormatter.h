//
//  ZYCardNoFormatter.h
//  ZYAPPFramework
//
//  Created by 石志愿 on 2019/7/30.
//  Copyright © 2019 szy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYCardNoFormatter : NSObject

/**
 *  默认为4，即4个数一组 用空格分隔
 */
@property (assign, nonatomic) NSInteger groupSize;

/**
 *  分隔符 默认为空格
 */
@property (copy, nonatomic) NSString *separator;

- (void)cardNoField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
