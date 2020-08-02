//
//  HYBaseViewModel.m
//  youbaner
//
//  Created by luzhongchang on 17/7/29.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"

@implementation HYBaseViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self __initialize];
    }
    return self;
}

- (void)__initialize {
    self.errorSignal    = [RACSubject subject];
    self.successSignal  = [RACSubject subject];
    self.emptySignal    = [RACSubject subject];
    
    self.flag = @1;
}

+ (instancetype)viewModel {
    HYBaseViewModel *vm = [[self alloc] init];
    return vm;
}

// 实现的目的是为了避免子类调用 +viewModelWithObj:, 而没有实现导致的crash
+ (instancetype)viewModelWithObj:(id)obj {
    HYBaseViewModel *vm = [[HYBaseViewModel alloc] init];
    [vm setObj:obj];
    return vm;
}

- (void)setObj:(id)obj {
    
}

@end
