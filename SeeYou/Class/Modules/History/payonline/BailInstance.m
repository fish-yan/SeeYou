//
//  BailInstance.m
//  youbaner
//
//  Created by 卢中昌 on 2018/6/24.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "BailInstance.h"
#import "BailViewModel.h"
#import "HYPopDataModel.h"
#import "PayOnlineViewController.h"
#import "alipayModel.h"
#import "HYTopPayVM.h"
@interface BailInstance ()
@property (nonatomic, strong) BailViewModel *viewModel;
@property (nonatomic, strong) UIViewController *vc;
@property (nonatomic, strong) HYPopDataModel *dataModel;
@end

@implementation BailInstance
+ (BailInstance *)sharedInstance:(UIViewController *)vc completeBlcok:(void (^)(NSString *status))block {
    static BailInstance *sharedSingleton = nil;
    static dispatch_once_t onceToken;
    @weakify(self);
    dispatch_once(&onceToken, ^(void) {

        @strongify(self);
        sharedSingleton = [[self alloc] initialize:vc completeBlcok:block];
    });
    return sharedSingleton;
}

- (id)initialize:(UIViewController *)vc completeBlcok:(void (^)(NSString *status))block {
    if (self == [super init]) {
        self.vc        = vc;
        self.viewModel = [BailViewModel new];
        [self bindModel];
        [WDProgressHUD showInView:vc.view];
        [self.viewModel.getProductListRaccommand execute:@{ @"type": @"5" }];
        self.block = block;
    }
    return self;
}


- (void)bindModel {
    @weakify(self);
    [[self.viewModel.getProductListRaccommand.executionSignals switchToLatest] subscribeNext:^(id _Nullable x) {
        @strongify(self);
        [WDProgressHUD hiddenHUD];

        if (self.viewModel.listArray.count == 0) {
            [self.vc.view showFailureViewOfType:WDFailureViewTypeEmpty
                                withClickAction:^{
                                    @strongify(self);
                                    [WDProgressHUD showInView:self.vc.view];
                                    [self.viewModel.getProductListRaccommand execute:@{ @"type": @"5" }];
                                }];
        } else {
            self.dataModel = self.viewModel.listArray[0];
            if (self.dataModel) {
                [WDProgressHUD showInView:self.vc.view];
                [self.viewModel.getOderidInfoRaccommand execute:@{ @"id": self.dataModel.ID }];
            }
        }
    }];
    [self.viewModel.getProductListRaccommand.errors subscribeNext:^(NSError *_Nullable x) {
        @strongify(self);
        [WDProgressHUD hiddenHUD];
        [WDProgressHUD showTips:x.localizedDescription];
        [self.vc.view showFailureViewOfType:WDFailureViewTypeError
                            withClickAction:^{
                                @strongify(self);
                                [WDProgressHUD showInView:self.vc.view];
                                [self.viewModel.getProductListRaccommand execute:@{ @"type": @"3" }];
                            }];
    }];

    [[self.viewModel.getOderidInfoRaccommand.executionSignals switchToLatest] subscribeNext:^(id _Nullable x) {
        [WDProgressHUD hiddenHUD];
        @strongify(self);
        [self juadge];

    }];

    [self.viewModel.getOderidInfoRaccommand.errors subscribeNext:^(NSError *_Nullable x) {
        [WDProgressHUD hiddenHUD];
        [WDProgressHUD showTips:x.localizedDescription];
    }];
}

- (void)juadge {
    @weakify(self);
    // 0：余额不足抵扣，1：余额足够抵扣
    if ([self.viewModel.extraModel.status intValue] == 1) {
        if (self.block) {
            //余额支付成功
            self.block(@"0");
        }
    } else {
        id block = ^(NSString *status) {

            @strongify(self);
            if (self.block) {
                //余额支付成功
                self.block(status);
            }


        };


        [YSMediator pushViewController:[PayOnlineViewController new]
                            withParams:@{
                                @"block": block,
                                @"basedatamodel": self.dataModel,
                                @"WDmodel": self.viewModel.extraModel
                            }
                              animated:YES
                              callBack:nil];
    }
}

@end
