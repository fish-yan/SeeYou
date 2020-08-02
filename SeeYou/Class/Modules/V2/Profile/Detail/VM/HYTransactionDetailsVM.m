//
//  HYTransactionDetailsVM.m
//  youbaner
//
//  Created by Joseph Koh on 2018/4/19.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYTransactionDetailsVM.h"
#import "HYTransationDetailsModel.h"

@implementation HYTransactionDetailsVM

- (instancetype)init {
    if (self = [super init]) {
        [self initalize];
    }
    return self;
}

- (void)initalize {
    @weakify(self);
    self.getDetailRaccommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *_Nonnull(NSNumber *_Nullable page) {
        @strongify(self);
        NSDictionary *params = @{
                                 @"type": @(self.type),
                                 @"page": page ?: @1,
                                 @"count": @20
                                 };
        return [[self transactionDetailsSingalWitParams:params]
                doNext:^(NSArray *_Nullable x) {
                    @strongify(self);
                    [self convertData:x];

        }];
    }];
}

- (RACSignal *)transactionDetailsSingalWitParams:(NSDictionary *)params {
//    // 1:收入,2:支出
//    private int type;
//    protected int page;
//    protected int count;

    @weakify(self);
    return [[WDRequestAdapter requestSignalWithURL:@""
                                            params:[NSDictionary convertParams:API_TRANSDETAIL_API dic:params]
                                       requestType:WDRequestTypePOST
                                      responseType:WDResponseTypeList
                                     responseClass:[HYTransationDetailsModel class]]
            map:^id _Nullable(WDResponseModel * _Nullable value) {
                @strongify(self);
                NSInteger page = [self.flag integerValue];
                self.hasMore = page < value.totalpage ? YES : NO;
                if (self.hasMore) {
                    self.flag = @(page++);
                }
                
                return value.data;
            }];
}


- (void)convertData:(NSArray *)data {
    NSMutableArray *tem = [NSMutableArray new];
    if (self.dataArray.count > 0) {
        [tem addObjectsFromArray:self.dataArray];
    }
    if (data.count > 0) {
        [tem addObjectsFromArray:data];
    }
    self.dataArray = [tem copy];
}


@end
