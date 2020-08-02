//
//  HYIdentifyUploadIDImageCell.h
//  SeeYou
//
//  Created by Joseph Koh on 2018/7/16.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYBaseTableViewCell.h"
#import "HYIdentifyCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYIdentifyUploadIDImageCell : HYBaseTableViewCell

@property (nonatomic, strong) HYIdentifyCellModel *cellModel;

@property (nonatomic, copy) void(^addBtnClickHandler)(UIButton *btn);

@end

NS_ASSUME_NONNULL_END
