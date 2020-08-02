//
//  HYProfileInfoCell.h
//  youbaner
//
//  Created by Joseph Koh on 2018/6/14.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYBaseTableViewCell.h"
#import "HYProfileCellModel.h"

@interface HYProfileInfoCell : HYBaseTableViewCell

@property (nonatomic, strong) HYProfileCellModel *cellModel;

@property (nonatomic, copy) void(^friendRequireHandler)(void);
@property (nonatomic, copy) void(^identityHandler)(void);
@property (nonatomic, copy) void(^userInfoHandler)(void);
@property (nonatomic, copy) void(^avatarHandler)(void);

@end
