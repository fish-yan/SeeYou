//
//  BailViewModel.m
//  youbaner
//
//  Created by 卢中昌 on 2018/6/24.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "BailViewModel.h"
#import "HYPopDataModel.h"
#import "alipayModel.h"
@implementation BailViewModel
-(id)init
{
    self = [super init];
    if (self)
    {
        [self initalize];
    }
    return self;
    
}
-(void)initalize
{
    @weakify(self);
    self.getProductListRaccommand =  [[RACCommand alloc] initWithSignalBlock:^RACSignal *_Nonnull(NSDictionary *_Nullable input) {
        @strongify(self);
        return [[self gettopData:[NSDictionary convertParams:API_getmemberproduct dic:input]] doNext:^(WDResponseModel *_Nullable x) {
            @strongify(self);
            NSLog(@"%@", x.data);
            self.listArray = (NSArray *) x.data;
        }];
    }];
    
    self.getOderidInfoRaccommand=[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSDictionary*  _Nullable input) {
        @strongify(self);
        return [[self getExtra:[NSDictionary convertParams:API_PREPAYMENTOEDER dic:input]] doNext:^(WDResponseModel *_Nullable x) {
            @strongify(self);
            self.extraModel = x.data;
        }];
    }];
}


- (RACSignal *)gettopData:(NSDictionary *)dic {
    RACSignal *sig = [WDRequestAdapter requestSignalWithURL:@""
                                                     params:dic
                                                requestType:WDRequestTypePOST
                                               responseType:WDResponseTypeList
                                              responseClass:[HYPopDataModel class]];
    return sig;
}



- (RACSignal *)getExtra:(NSDictionary *)dic {
    RACSignal *sig = [WDRequestAdapter requestSignalWithURL:@""
                                                     params:dic
                                                requestType:WDRequestTypePOST
                                               responseType:WDResponseTypeObject
                                              responseClass:[prepayappointmentModel class]];
    return sig;
}

@end
