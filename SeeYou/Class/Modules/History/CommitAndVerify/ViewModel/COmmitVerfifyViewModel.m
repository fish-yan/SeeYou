//
//  COmmitVerfifyViewModel.m
//  youbaner
//
//  Created by luzhongchang on 17/8/14.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "COmmitVerfifyViewModel.h"

@implementation COmmitVerfifyViewModel

- (id)init
{
    self =[super init];
    if(self)
    {
        [self initilize];
    }
    return self;
}

- (void)initilize
{
    
  
    @weakify(self);
    self.doRaccommand =[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        NSDictionary *dic =@{@"type":MAJIA_TYPE};
        return [[self getData:[NSDictionary convertParams:API_GETITEM dic:dic]] doNext:^(WDResponseModel *  _Nullable x) {
            
            @strongify(self);
            CommitVerdifyModel * model= x.data;
            self.price = model.productprice;
            self.peopleNumber = model.peopleNumber;
            self.productprice2 = model.productprice2;
            self.originalprice = model.originalprice;
            self.discount = model.discount;
        }];
    }];
}

- (RACSignal *)getData:(NSDictionary*)dic
{
    RACSignal *signal =[WDRequestAdapter requestSignalWithURL:@"" params:dic requestType:WDRequestTypePOST responseType:WDResponseTypeObject responseClass:[CommitVerdifyModel class]];
    return signal;
}

@end
