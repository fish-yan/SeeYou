//
//  WDSplashViewModel.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/3.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDSplashViewModel.h"

@implementation WDSplashViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    NSInteger numb = 4;
    NSMutableArray *imagesArrayM = [NSMutableArray arrayWithCapacity:numb];
    for (int i = 0; i < numb; i++) {
        [imagesArrayM addObject:[NSString stringWithFormat:@"Image-%d.png", i+1]];
    }
    self.imagesArray = imagesArrayM.copy;
}

@end
