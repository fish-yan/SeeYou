//
//  HYCompleteInfoVM.m
//  youbaner
//
//  Created by Joseph Koh on 2018/5/16.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYCompleteInfoVM.h"

@implementation HYCompleteInfoVM

- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    @weakify(self);
    self.saveInfoCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        HYUserCenterModel *model = [HYUserContext shareContext].userModel;
        model.iscomplete = UserInfoTypeNoAvatar;
        [[HYUserContext shareContext] updateUserInfo:model];
        
        
        @strongify(self);
        NSDictionary *params = @{
                                 @"name": self.nickName ?: @"",
                                 @"sex": self.gender ?: @"",
                                 @"birthday": self.birthday ?: @"",
                                 @"workarea": self.workareaCode ?: @"",
                                 @"salary": self.salary ?: @"",
                                 };
        NSDictionary *dict = [NSDictionary convertParams:API_SAVEPARTUSE_DATA dic:params];
        return [self saveSignal:dict];
    }];
}

- (RACSignal *)saveSignal:(NSDictionary *)params {
    return [WDRequestAdapter requestSignalWithURL:@""
                                           params:params
                                      requestType:WDRequestTypePOST
                                     responseType:WDResponseTypeMessage
                                    responseClass:nil];
}

@end
