//
//  HYUserInfoPhotosCell.h
//  youbaner
//
//  Created by Joseph Koh on 2018/6/15.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYBaseTableViewCell.h"
#import "HYUserInfoCellModel.h"

@interface HYUserInfoPhotosCell : HYBaseTableViewCell

@property (nonatomic, strong) HYUserInfoCellModel *cellModel;
@property (nonatomic, copy) void(^addBtnClickHandler)(void);
@property (nonatomic, copy) void(^imageBtnClickHandler)(NSArray *images, NSInteger idx);

@property (nonatomic, assign) BOOL isMySelf;

@end
