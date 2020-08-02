//
//  HYLocation.m
//  youbaner
//
//  Created by Joseph Koh on 2018/6/24.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYLocation.h"
@implementation HYCoordinate

@end

@implementation HYLocation

- (instancetype)init {
    if (self = [super init]) {
        self.coordinate = [HYCoordinate new];
    }
    return self;
}

@end
