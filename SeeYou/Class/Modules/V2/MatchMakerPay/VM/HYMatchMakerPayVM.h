//
//  HYMatchMakerPayVM.h
//  SeeYou
//
//  Created by Joseph Koh on 2018/8/9.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"
#import "HYMatchMakerPayCellModel.h"
#import "IAPHelperViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYMatchMakerPayVM : IAPHelperViewModel

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) NSInteger itemSelectedIdx;

- (NSArray *)updateDataArray:(NSArray *)data;

@end

NS_ASSUME_NONNULL_END
