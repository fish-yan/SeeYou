//
//  HYHomeContentVM.m
//  youbaner
//
//  Created by Joseph Koh on 2018/4/16.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYHomeContentVM.h"

#define PAGE_COUNT 20

@implementation HYHomeContentVM

- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    @weakify(self);
    self.requestDataCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        self.flag = @1;
        RACSignal *signal = nil;
        if (self.type == HomeContentTypeRecommend) {
            NSArray *arr = @[[self requsetCommendSignal],
                             [self requsetListSignalWithPage:@1]];
            signal = [self rac_liftSelector:@selector(combineDataWithCommond:andList:)
                       withSignalsFromArray:arr];
        }
        else {
            signal = [[self requsetListSignalWithPage:@1]
                      doNext:^(id  _Nullable x) {
                          @strongify(self);
                          [self combineDataWithCommond:nil andList:x];
                      }];
        }
        
        
        return signal;
    }];
    
    self.commendRequestCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        return [[self requsetCommendSignal]
                doNext:^(NSArray * _Nullable x) {
                    @strongify(self);
                    if (!x || !x.count) return;
                    
                    NSMutableArray *arrM = self.dataArray.mutableCopy;
                    if (self.commendArray.count && self.commendArray.count > 0) {
                        [arrM replaceObjectAtIndex:0 withObject:x];
                    }
                    else {
                        [arrM insertObject:x atIndex:0];
                    }
                    self.dataArray = arrM.copy;
                }] ;
    }];
    
    self.listRequestCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        return [[self requsetListSignalWithPage:input] doNext:^(NSArray * _Nullable x) {
            @strongify(self);
            
            NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:2];
            if (self.commendArray && self.commendArray.count > 0) {
                [arrM addObject:self.commendArray];
            }
            
            NSMutableArray *list = self.listArray.mutableCopy;
            [list addObjectsFromArray:x];
            [arrM addObject:list];
            
            self.listArray = list;
            self.dataArray = arrM;
        }];
    }];
    

//    self.filterRequestCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
//        @strongify(self);
//        return [[self requsetListSignalWithPage:input] doNext:^(NSArray * _Nullable x) {
//            @strongify(self);
//
//            NSMutableArray *list = self.listArray.mutableCopy;
//            [list addObjectsFromArray:x];
//            self.listArray = list;
//            self.dataArray = @[list];
//        }];
//    }];
}

- (void)combineDataWithCommond:(NSArray *)commondRst andList:(NSArray *)listRst {
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:2];
    self.commendArray = commondRst;
    self.listArray = listRst;
    
    if (commondRst && commondRst.count) {
        [arrM addObject:commondRst];
    }
    if (listRst && listRst.count) {
        [arrM addObject:listRst];
    }
    self.dataArray = arrM.copy;
}

- (BOOL)hasCommend {
    return self.dataArray.count == 2;
}

- (RACSignal *)requsetListSignalWithPage:(NSNumber *)page {
    if (!page) {
        page = @1;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @(PAGE_COUNT), @"count",
                                   page, @"page",
                                   @(self.type), @"type", nil];
    NSDictionary *filterInfos = [self filterParams];
    if (filterInfos) {
        [params addEntriesFromDictionary:filterInfos];
    }
    @weakify(self);
    return [[WDRequestAdapter requestSignalWithURL:@""
                                             params:[NSDictionary convertParams:API_NEW_HOME dic:params]
                                        requestType:WDRequestTypePOST
                                       responseType:WDResponseTypeList
                                      responseClass:[HYObjectListModel class]]
             map:^id _Nullable(WDResponseModel * _Nullable value) {
                 @strongify(self);
                 NSInteger page = [self.flag integerValue];
                 if (page == value.totalpage || value.totalpage == 0) {
                     self.hasMore = NO;
                 } else {
                     self.flag = @(++page);
                     self.hasMore = YES;
                 }
                 
                 return value.data;
             }];
}

- (NSDictionary *)filterParams {
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    
        if (self.filterInfos.cityID) {
            [dictM setObject:self.filterInfos.cityID forKey:@"city"];
        }
        if (self.filterInfos.agestart) {
            [dictM setObject:self.filterInfos.agestart forKey:@"agestart"];
        }
        if (self.filterInfos.ageend) {
            [dictM setObject:self.filterInfos.ageend forKey:@"ageend"];
        }
        if (self.filterInfos.heightstart) {
            [dictM setObject:self.filterInfos.heightstart forKey:@"heightstart"];
        }
        if (self.filterInfos.heightend) {
            [dictM setObject:self.filterInfos.heightend forKey:@"heightend"];
        }
        if (self.filterInfos.degree) {
            [dictM setObject:self.filterInfos.degree forKey:@"degree"];
        }
        if (self.filterInfos.salary) {
            [dictM setObject:self.filterInfos.salary forKey:@"salary"];
        }
        if (self.filterInfos.constellation) {
            [dictM setObject:self.filterInfos.constellation forKey:@"constellation"];
        }
        if (self.filterInfos.wantmarry) {
            [dictM setObject:self.filterInfos.wantmarry forKey:@"wantmarry"];
        }
        if (self.filterInfos.marry) {
            [dictM setObject:self.filterInfos.marry forKey:@"marry"];
        }
    return dictM.copy;
}


- (RACSignal *)requsetCommendSignal {
    return [[WDRequestAdapter requestSignalWithURL:@""
                                           params:[NSDictionary convertParams:API_TOP_RECOMMAND dic:@{}]
                                      requestType:WDRequestTypePOST
                                     responseType:WDResponseTypeList
                                    responseClass:[HYObjectListModel class]]
            map:^id _Nullable(WDResponseModel * _Nullable value) {
                return value.data;
            }];
}

@end
