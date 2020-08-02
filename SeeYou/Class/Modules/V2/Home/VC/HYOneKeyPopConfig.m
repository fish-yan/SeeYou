//
//  HYOneKeyPopConfig.m
//  youbaner
//
//  Created by Joseph Koh on 2018/6/14.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYOneKeyPopConfig.h"
#import "HYNavigationController.h"
#import "HYOneKeyGreetVC.h"

@interface HYOneKeyPopConfig()

@property (nonatomic, strong) NSDictionary *popInfo;

@end

@implementation HYOneKeyPopConfig

static HYOneKeyPopConfig *config = nil;
+ (instancetype)config {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [HYOneKeyPopConfig new];
        config.popInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"popConfig"];
    });
    return config;
}

- (NSString *)today {
    NSDateFormatter *f0rmater = [[NSDateFormatter alloc] init];
    f0rmater.dateFormat = @"yyyy-MM-dd";
    NSString *date = [f0rmater stringFromDate:[NSDate date]];
    return date;
}

- (void)configPopTime:(NSInteger)time {
    if (!self.popInfo) {
        self.popInfo = @{
                    @"time": @(time),
                    @"popTime": @(0),
                    @"date": [self today]
                    };
        [[NSUserDefaults standardUserDefaults] setObject:self.popInfo forKey:@"popConfig"];
    }
    else {
        NSInteger popTime = [self.popInfo[@"popTime"] integerValue];
        NSString *date = self.popInfo[@"date"];
        [self updatePopInfoWithTime:time popTime:popTime date:date ?: [self today]];
    }
    
}
- (void)popWithActionHandle:(void(^)(NSArray *infos))hander {
//    [self doPopActionWithHandler:hander];
//    return;

    NSInteger time = [self.popInfo[@"time"] integerValue];
    NSInteger popTime = [self.popInfo[@"popTime"] integerValue];
    NSString *date = self.popInfo[@"date"];
    if (![date isEqualToString:[self today]] || popTime < time) {
        [self doPopActionWithHandler:hander];
        [self updatePopInfoWithTime:time popTime:(popTime + 1) date:[self today]];
    }
}

- (void)updatePopInfoWithTime:(NSInteger)time popTime:(NSInteger)popTime date:(NSString *)date {
    self.popInfo = @{
                     @"time": @(time),
                     @"popTime": @(popTime),
                     @"date": date
                     };
    [[NSUserDefaults standardUserDefaults] setObject:self.popInfo forKey:@"popConfig"];
}

- (void)doPopActionWithHandler:(void(^)(NSArray *infos))hander {
//    id callHandle = ^(NSArray *infos){
//        [YSMediator presentToViewController:kModuleExclusiveGreetView
//                                 withParams:nil
//                                   animated:YES
//                                   callBack:NULL];
//    };
//    [YSMediator presentToViewController:kModuleOneKeyGreetView
//                             withParams:nil
//                               animated:YES
//                               callBack:NULL];

    HYNavigationController *nav = [[HYNavigationController alloc] initWithRootViewController:[HYOneKeyGreetVC new]];
    [YSMediator presentViewController:nav
                           withParams:nil
                             animated:YES
                             callBack:NULL];

}

@end
