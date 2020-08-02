//
//  HYHomeCommendCell.h
//  youbaner
//
//  Created by Joseph Koh on 2018/4/16.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYBaseTableViewCell.h"

@interface HYHomeCommendCell : HYBaseTableViewCell

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) void(^topAction)(void);
@property (nonatomic, copy) void(^itemClickedAction)(HYObjectListModel *m);
@property (nonatomic, copy) void(^heartAction)(HYObjectListModel *m);
@end
