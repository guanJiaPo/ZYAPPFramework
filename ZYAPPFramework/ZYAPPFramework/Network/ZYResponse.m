//
//  ZYDefineConstants.h
//  ZYAPPFramework
//
//  Created by szy on 2019/1/21.
//  Copyright © 2019 szy. All rights reserved.
//

#import "ZYResponse.h"

@implementation ZYResponse

- (BOOL)success {
    return self.code == 200;
}


@end
