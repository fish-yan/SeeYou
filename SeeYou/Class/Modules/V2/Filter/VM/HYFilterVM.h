//
//  HYFilterVM.h
//  youbaner
//
//  Created by Joseph Koh on 2018/4/17.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"
#import "HYFilterRecordModel.h"

@interface HYFilterVM : HYBaseViewModel

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) BOOL hasBuyMatchMaker;

@property (nonatomic, strong) NSMutableDictionary *filterInfo;

@property (nonatomic, strong) HYFilterRecordModel *recordModel;

@end
