//
//  HYAppContext.h
//  youbaner
//
//  Created by Joseph Koh on 2018/6/28.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYAppContext : NSObject

@property (nonatomic, assign, readonly) BOOL isNewUpdate;

+ (instancetype)shareContext;

@end
