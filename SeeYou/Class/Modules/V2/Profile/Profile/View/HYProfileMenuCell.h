//
//  HYProfileMenuCell.h
//  youbaner
//
//  Created by Joseph Koh on 2018/6/14.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYBaseTableViewCell.h"
#import "HYProfileCellModel.h"

@interface HYProfileMenuCell : HYBaseTableViewCell

@property (nonatomic, strong) HYProfileCellModel *cellModel;
@property (nonatomic, copy) void(^menuItemClick)(NSInteger idx, NSString *mapStr);

@end
