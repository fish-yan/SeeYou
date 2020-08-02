//
//  HYNetworkTools.h
//  youbaner
//
//  Created by luzhongchang on 17/7/30.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYNetworkTools : NSObject

@property (nonatomic, assign, getter=isReachable) BOOL reachable;

+ (instancetype)shareTools;

- (void)startMonitoring;
- (void)stopMonitoring;

@end
