//
//  HYDatingLineCell.h
//  youbaner
//
//  Created by Joseph Koh on 2018/6/26.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYBaseTableViewCell.h"
#import "HYDatingLineModel.h"

@interface HYDatingLineCell : UITableViewCell

@property (nonatomic, strong) HYDatingLineModel *model;
@property (nonatomic, assign) BOOL isFirstItem;
@property (nonatomic, assign) BOOL isLastItem;
@end
