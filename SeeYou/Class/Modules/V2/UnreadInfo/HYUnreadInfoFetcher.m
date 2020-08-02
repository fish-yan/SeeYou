//
//  HYUnreadInfoFetcher.m
//  SeeYou
//
//  Created by Joseph Koh on 2018/8/13.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYUnreadInfoFetcher.h"

@implementation HYUnreadInfoModel

@end


@implementation HYUnreadInfoFetcher

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static HYUnreadInfoFetcher *instance;
    dispatch_once(&onceToken, ^{
        instance = [HYUnreadInfoFetcher new];
        @weakify(instance);
        instance.unreadMsgCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(instance);
            return [instance fetchUnreadInfoSignal];
        }];
    });
    return instance;
}

- (RACSignal *)fetchUnreadInfoSignal {
    NSDictionary *params = @{};
    return [[[WDRequestAdapter requestSignalWithURL:@""
                                             params:[NSDictionary convertParams:@"getuserunreadcount" dic:params]
                                        requestType:WDRequestTypePOST
                                       responseType:WDResponseTypeObject
                                      responseClass:[HYUnreadInfoModel class]]
             map:^id _Nullable(WDResponseModel * _Nullable value) {
                 return value.data;
             }]
            doNext:^(HYUnreadInfoModel * _Nullable x) {
                if (x == nil) return;
                
                UITabBar *tabBar = [AppDelegateUIAssistant shareInstance].rootTabBarController.tabBar;
                for (NSInteger i = 0; i < tabBar.items.count; i++) {
                    if (i == 0 || i ==4) continue;
                    UITabBarItem *item = tabBar.items[i];
                    NSInteger cnt = 0;
                    if (i == 1) {
                        cnt = x.msgcount;
                    } else if (i == 2) {
                        cnt = x.appointmentcount;
                    } else if (i == 3) {
                        cnt = x.addresscount;
                    }
                    item.badgeValue = [self covertedNumber:cnt];
                }
            }];
}

- (NSString *)covertedNumber:(NSInteger)cnt {
    if (cnt == 0) return nil;
    if (cnt > 99) return @"99+";
    return [NSString stringWithFormat:@"%zd", cnt];
}
@end
