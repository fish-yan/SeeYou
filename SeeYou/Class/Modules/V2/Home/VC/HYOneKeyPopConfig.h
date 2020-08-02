//
//  HYOneKeyPopConfig.h
//  youbaner
//
//  Created by Joseph Koh on 2018/6/14.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYOneKeyPopConfig : NSObject
+ (instancetype)config;

- (void)configPopTime:(NSInteger)time;
- (void)popWithActionHandle:(void(^)(NSArray *infos))hander;
@end
