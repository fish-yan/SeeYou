//
//  CPPickerViewModel.m
//  youbaner
//
//  Created by Joseph Koh on 2018/6/20.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "CPPickerViewModel.h"

@implementation CPPickerViewModel

+ (instancetype)modelWithName:(NSString *)name mid:(NSNumber *)mid {
    CPPickerViewModel *m = [CPPickerViewModel new];
    m.name = name;
    m.mid = mid;
    return m;
}

@end
