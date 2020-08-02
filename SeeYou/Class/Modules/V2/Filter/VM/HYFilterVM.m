//
//  HYFilterVM.m
//  youbaner
//
//  Created by Joseph Koh on 2018/4/17.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYFilterVM.h"
#import "HYFilterCellModel.h"

@interface HYFilterVM ()

@end

@implementation HYFilterVM

- (instancetype)init {
    if (self = [super init]) {
        [self combineDataArray];
        
        @weakify(self);
        [RACObserve(self, recordModel) subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            [self combineDataArray];
        }];
    }
    return self;
}

- (BOOL)hasBuyMatchMaker {
    return [[HYUserContext shareContext].userModel.redniangstatus  boolValue];
}

- (void)combineDataArray {
    self.dataArray = @[[self commonDataModel],
                       [self matchMakerDataModel]];
}

- (HYFilterCellModel *)commonDataModel {
    HYFilterCellModel *m = [HYFilterCellModel new];
    m.name = @"一般筛选";
    m.arr = @[
               [HYFilterCellModel modelWithType:FilterCellTypeLocation
                                           name:@"工作所在地"
                                           icon:@"filter_location"
                                           info:self.recordModel.cityName ?: @"不限"
                                       isLocked:NO],
               [HYFilterCellModel modelWithType:FilterCellTypeAge
                                           name:@"年龄范围"
                                           icon:@"filter_date"
                                           info:self.recordModel.ageName ?:@"不限"
                                       isLocked:NO]
                   ];
    m.isLocked = NO;
    
    return m;
}

- (HYFilterCellModel *)matchMakerDataModel {
    BOOL isNeedLock = !self.hasBuyMatchMaker;
    NSArray *arr = @[
                     [HYFilterCellModel modelWithType:FilterCellTypeHeight name:@"身高范围"
                                                 icon:@"filter_man"
                                                 info:self.recordModel.heightName ?:@"不限"
                                             isLocked:isNeedLock],
                     [HYFilterCellModel modelWithType:FilterCellTypeEdu
                                                 name:@"最高学历"
                                                 icon:@"filter_book"
                                                 info:self.recordModel.degreeName ?:@"不限"
                                             isLocked:isNeedLock],
                     [HYFilterCellModel modelWithType:FilterCellTypeIncome
                                                 name:@"月收入"
                                                 icon:@"filter_wallet"
                                                 info:self.recordModel.salaryName ?:@"不限"
                                             isLocked:isNeedLock],
                     [HYFilterCellModel modelWithType:FilterCellTypeConstellation
                                                 name:@"星座"
                                                 icon:@"filter_constella"
                                                 info:self.recordModel.constellationName ?:@"不限"
                                             isLocked:isNeedLock],
                     [HYFilterCellModel modelWithType:FilterCellTypeMarryDate
                                                 name:@"期望结婚时间"
                                                 icon:@"filter_heart"
                                                 info:self.recordModel.wantmarryName ?:@"不限"
                                             isLocked:isNeedLock],
                     [HYFilterCellModel modelWithType:FilterCellTypeMarryStatus
                                                 name:@"目前婚姻状况"
                                                 icon:@"filter_now"
                                                 info:self.recordModel.marryStatusName ?:@"不限"
                                             isLocked:isNeedLock]
                     ];
    
    
    HYFilterCellModel *m = [HYFilterCellModel new];
    m.name = @"红娘推荐";
    m.arr = arr;
    m.isLocked = !self.hasBuyMatchMaker;
    m.info = @"去开通";
    
    return m;
}

- (HYFilterRecordModel *)recordModel {
    if (!_recordModel) {
        _recordModel = [HYFilterRecordModel new];
    }
    return _recordModel;
}

@end
