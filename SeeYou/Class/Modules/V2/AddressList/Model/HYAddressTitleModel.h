//
//  HYAddressTitleModel.h
//  SeeYou
//
//  Created by Joseph Koh on 2018/8/12.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYAddressTitleModel : HYBaseModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL hasUnread;

+ (instancetype)modelWithTitle:(NSString *)title hasUnread:(BOOL)hasUnread;

@end

NS_ASSUME_NONNULL_END
