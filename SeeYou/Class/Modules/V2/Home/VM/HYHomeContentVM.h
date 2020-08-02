//
//  HYHomeContentVM.h
//  youbaner
//
//  Created by Joseph Koh on 2018/4/16.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"
#import "HYFilterRecordModel.h"

typedef NS_ENUM(NSInteger, HomeContentType) {
    HomeContentTypeRecommend = 1,
    HomeContentTypeLatest,
    HomeContentTypeNearby,
};

@interface HYHomeContentVM : HYBaseViewModel

@property (nonatomic, strong) RACCommand *requestDataCmd;
@property (nonatomic, strong) RACCommand *commendRequestCmd;
@property (nonatomic, strong) RACCommand *listRequestCmd;
//@property (nonatomic, strong) RACCommand *filterRequestCmd;

@property (nonatomic, strong) HYFilterRecordModel *filterInfos;

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *commendArray;
@property (nonatomic, strong) NSArray *listArray;

@property (nonatomic, assign) HomeContentType type;
@property (nonatomic, assign) BOOL hasCommend;

@end
