//
//  HYInfoListCell.h
//  youbaner
//
//  Created by Joseph Koh on 2018/4/16.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYBaseTableViewCell.h"

typedef NS_ENUM(NSInteger, InfoListCellType) {
    InfoListCellTypeCity,
    InfoListCellTypeDistance,
};

@interface HYInfoListCell : HYBaseTableViewCell

@property (nonatomic, strong) HYObjectListModel *model;

@property (nonatomic, assign) InfoListCellType cellType;

@property (nonatomic, copy) void(^msgClickHandler)(NSString *uid,NSString * name,NSString * avatar);
@property (nonatomic, copy) void(^dateClickHandler)(NSString *dateId, NSString *uid);
@property (nonatomic, copy) void(^heartClickHandler)(NSString *uid, NSInteger type);
@property (nonatomic, copy) void(^memberClicked)(void);

@end
