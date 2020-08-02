//
//  HYAddressSubViewModel.m
//  youbaner
//
//  Created by 卢中昌 on 2018/4/21.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYAddressSubViewModel.h"
#import "HYAddressSubModel.h"
@implementation HYAddressSubViewModel

- (id)init
{
    if(self = [super init])
    {
        [self initalize];
        
    }
    return self;
}
- (void)initalize
{
 
    @weakify(self);
    self.heartCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        return [self heartSignalWithParams:input];
    }];
    
    self.markCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        return [[[self markSignalWithInput:input]
                 doNext:^(id  _Nullable x) {
                     @strongify(self);
                     self.isview = @(YES);
                 }]
                doError:^(NSError * _Nonnull error) {
                    NSLog(@"----%@", error);
                }];
    }];
    
}


- (RACSignal *)markSignalWithInput:(NSNumber *)input {
    NSDictionary *params = @{
                             @"id": self.mid ?: @"",
                             @"type": @(self.type) 
                             };
    return [[WDRequestAdapter requestSignalWithURL:@""
                                            params:[NSDictionary convertParams:@"viewuseraddress" dic:params]
                                       requestType:WDRequestTypePOST
                                      responseType:WDResponseTypeMessage
                                     responseClass:nil]
            map:^id _Nullable(WDResponseModel * _Nullable value) {
                return [value.data lastObject];
            }];
}

- (RACSignal *)heartSignalWithParams:(NSDictionary *)params {
    return [[WDRequestAdapter requestSignalWithURL:@""
                                            params:[NSDictionary convertParams:API_ISBEMOVED dic:params]
                                       requestType:WDRequestTypePOST
                                      responseType:WDResponseTypeObject
                                     responseClass:[HYObjectListModel class]]
            map:^id _Nullable(WDResponseModel * _Nullable value) {
                return value.data;
            }];
}

+ (instancetype)viewModelWithObj:(id)obj
{
    HYAddressSubViewModel *vm = [HYAddressSubViewModel new];
    [vm setObj:obj];
    return vm;
}

- (void)setObj:(HYAddressSubModel *)obj
{
    self.userID = obj.userID;
    self.userAvatar = [NSURL URLWithString:obj.userAvatar];
    self.userNickName = obj.userNickName;
    self.userAge = obj.userAge;
    self.city = obj.city;
    self.userAgeAndcity =[NSString stringWithFormat:@"%@岁 * %@",self.userAge ,self.city];
    self.isheart = obj.isheart;
    self.isview = obj.isview;
    self.mid = obj.mid;
}

@end
