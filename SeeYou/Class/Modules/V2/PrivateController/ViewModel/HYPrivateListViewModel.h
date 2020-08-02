//
//  HYPrivateListViewModel.h
//  youbaner
//
//  Created by luzhongchang on 17/7/31.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"

@interface HYPrivateListViewModel : HYBaseViewModel

@property(nonatomic ,strong) RACCommand * doCommand;
@property(nonatomic ,assign) int page;
@property(nonatomic ,assign) int count;

@property(nonatomic ,strong) NSArray * listArray;

@property(nonatomic ,strong) RACCommand * dodeleteCommand;

//- (void)getHomeList;

@end
