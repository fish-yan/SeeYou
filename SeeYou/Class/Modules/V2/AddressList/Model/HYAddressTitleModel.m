//
//  HYAddressTitleModel.m
//  SeeYou
//
//  Created by Joseph Koh on 2018/8/12.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYAddressTitleModel.h"

@implementation HYAddressTitleModel

+ (instancetype)modelWithTitle:(NSString *)title hasUnread:(BOOL)hasUnread {
    HYAddressTitleModel *m = [HYAddressTitleModel new];
    m.title = title;
    m.hasUnread = hasUnread;
    
    return m;
}
@end
