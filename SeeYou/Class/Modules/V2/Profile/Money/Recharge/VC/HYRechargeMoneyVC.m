//
//  HYRechargeMoneyVC.m
//  youbaner
//
//  Created by Joseph Koh on 2018/4/23.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYRechargeMoneyVC.h"
#import "HYMoneyInfoView.h"
#import <StoreKit/StoreKit.h>
#import "HYRechargeViewModel.h"
#import "HYPopDataModel.h"

@interface HYRechargeMoneyVC ()

@property (nonatomic, strong) HYMoneyInfoView *infoView;
@property (nonatomic, strong) UIButton *submitBtn;
@property (nonatomic, strong) UILabel *tipsLabel;
@property (nonatomic, strong) HYRechargeViewModel *viewModel;


@property (nonatomic, strong) NSMutableArray *itemsArrM;
@property (nonatomic, strong) UIButton *selBtn;


@end

@implementation HYRechargeMoneyVC

+ (void)load {
    [self mapName:kModuleMoneyRecharge withParams:nil];
}

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialize];
    [self setupSubviews];
    [self bind];
    [self requestData];
}

#pragma mark - Action

- (void)requestData {
    [self.viewModel.getProductListCmd execute:nil];
}

- (void)rechargeSubmit {
    HYFinanceModel *selModel = self.viewModel.dataArray[self.selBtn.tag];
    [self.viewModel.getOderidInfoRaccommand execute:selModel.mid];
}


#pragma mark - Bind

- (void)bind {
    @weakify(self);
    [[[self.viewModel.getProductListCmd.executing skip:1]
      merge:[self.viewModel.getProductListCmd.executing skip:1]]
     subscribeNext:^(id  _Nullable x) {
         @strongify(self);
         if ([x boolValue]) {
             [WDProgressHUD showInView:self.view];
         }
     }];

    [[self.viewModel.getProductListCmd.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [WDProgressHUD hiddenHUD];
        [self reLayoutProduces];
        
        if(self.viewModel.dataArray.count == 0) {
            [self.view showFailureViewOfType:WDFailureViewTypeEmpty withClickAction:^{
                @strongify(self);
                [self requestData];
            }];
        }
    }];
    [self.viewModel.getProductListCmd.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        [WDProgressHUD hiddenHUD];
        [WDProgressHUD showTips:x.localizedDescription];
        [self.view showFailureViewOfType:WDFailureViewTypeError withClickAction:^{
             @strongify(self);
            [WDProgressHUD showInView:self.view];
            [self.viewModel.getProductListCmd execute:@{@"type":@"3"}];
        }];
    }];
    
    [[self.viewModel.getOderidInfoRaccommand.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        [WDProgressHUD hiddenHUD];
        @strongify(self);
        [self go2onlinePayView];
//        [self juadge];
        
    }];
    
    [self.viewModel.getOderidInfoRaccommand.errors subscribeNext:^(NSError * _Nullable x) {
        [WDProgressHUD hiddenHUD];
        [WDProgressHUD showTips:x.localizedDescription];
    }];
    
}


#pragma mark - Initialize

- (void)initialize {
    self.navigationItem.title = @"充值";
    self.viewModel = [HYRechargeViewModel new];
}


#pragma mark - Setup Subviews

- (void)setupSubviews {
    _infoView = [HYMoneyInfoView viewWithType:InfoViewTypeLeft andFrame:CGRectMake(15, 20, SCREEN_WIDTH - 30, 123.)];
    _infoView.title = @"我的钱包";
    _infoView.layer.cornerRadius = 4;
    _infoView.clipsToBounds = YES;
    _infoView.money = self.money;
    [self.view addSubview:_infoView];
    
    @weakify(self);
    _submitBtn = [UIButton buttonWithTitle:@"确认充值"
                                titleColor:[UIColor whiteColor]
                                  fontSize:16
                                   bgColor:nil
                                    inView:self.view
                                    action:^(UIButton *btn) {
                                        @strongify(self);
                                        [self rechargeSubmit];
                                    }];
    _submitBtn.clipsToBounds = YES;
    _submitBtn.layer.cornerRadius = 45 * 0.5;
    [_submitBtn setBackgroundImage:[UIImage gradientImageOfSize:CGSizeMake(315, 45)] forState:UIControlStateNormal];
    
    _tipsLabel = [UILabel labelWithText:@"充值本金金额是 1:1 冲入钱包"
                              textColor:[UIColor lightGrayColor]
                          textAlignment:NSTextAlignmentCenter
                               fontSize:16
                                 inView:self.view
                              tapAction:NULL];
    
    [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_infoView.mas_bottom).offset(300);
        make.left.offset(30);
        make.right.offset(-30);
        make.height.mas_equalTo(45);
    }];


    [_tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_submitBtn.mas_bottom).offset(20);
        make.centerX.equalTo(self.view);
    }];
}

- (void)cleanItems {
    for (UIButton *btn in self.itemsArrM) {
        btn.hidden = YES;
    }
}

- (void)reLayoutProduces {
    [self cleanItems];
    
    CGFloat paddingH = 15.0;
    CGFloat paddingV = 20.0;
    CGFloat topMarign = 30.0;
    NSInteger cul = 3;
    CGFloat w = (SCREEN_WIDTH - (cul + 1) * paddingH) / cul;
    CGFloat h = 60.0 / 100.0 * w;
    __block UIButton *lastItem = nil;
    [self.viewModel.dataArray enumerateObjectsUsingBlock:^(HYFinanceModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *item = [self cachedBtnAtIndex:idx title:obj.name];
        CGFloat x = paddingH + (paddingH + w) * (idx % cul);
        CGFloat y = topMarign + (paddingV + h) * (idx / cul);
        [item mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(w, h));
            make.left.offset(x);
            make.top.equalTo(_infoView.mas_bottom).offset(y);
        }];
        lastItem = item;
    }];
    
    
    [_submitBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastItem.mas_bottom).offset(100);
        make.left.offset(30);
        make.right.offset(-30);
        make.height.mas_equalTo(45);
    }];
    
    
    [_tipsLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_submitBtn.mas_bottom).offset(20);
        make.centerX.equalTo(self.view);
    }];
}

- (UIButton *)cachedBtnAtIndex:(NSInteger)idx title:(NSString *)title {
    if (self.itemsArrM.count == 0 || (self.itemsArrM.count && idx >= self.itemsArrM.count)) {
        @weakify(self);
        UIButton *btn = [self createBtnWithValue:title tag:idx action:^(UIButton *btn) {
            @strongify(self);
            if (btn == self.selBtn) {
                return;
            }
            self.selBtn.selected = NO;
            self.selBtn.backgroundColor = [UIColor whiteColor];
            btn.selected = YES;
            btn.backgroundColor = [UIColor colorWithHexString:@"#FF8184"];

            self.selBtn = btn;
        }];
        [self.itemsArrM addObject:btn];
        return btn;
    }

    UIButton *btn = self.itemsArrM[idx];
    btn.hidden = NO;
    [btn setTitle:title forState:UIControlStateNormal];
    
    return btn;
}

- (UIButton *)createBtnWithValue:(NSString*)value tag:(NSInteger)tag action:(void(^)(UIButton *btn))action {
    UIButton *btn = [UIButton buttonWithTitle:[NSString stringWithFormat:@"%@", value]
                                   titleColor:[UIColor blackColor]
                                     fontSize:20
                                      bgColor:nil
                                       inView:self.view
                                       action:action];
    
    [btn setTitleColor:[UIColor colorWithHexString:@"#4A4A4A"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    btn.tag = tag;
    btn.layer.borderWidth = 1.0;
    btn.layer.borderColor = [UIColor colorWithHexString:@"#BCBCBC"].CGColor;
    [self.view addSubview:btn];
    return btn;
}


- (void)doResultAction:(BOOL)isSuccess {
    NSString *msg = isSuccess ? @"充值成功" : @"充值失败, 请重试";
    [WDProgressHUD showTips:msg];
    if (isSuccess) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }
}

- (void)go2onlinePayView {
    HYOrderPayModel *payModel = self.viewModel.payModel;
    
    id rst = ^(BOOL isSuccess){
        [self doResultAction:isSuccess];
    };
    NSDictionary *params = @{
                             @"orderId": payModel.orderid ?: @"",
                             @"balance": payModel.balance,
                             @"payCount": payModel.payamount,
                             @"rst": rst,
                             @"actionType": @1
                             };
    [YSMediator pushToViewController:kModuleDatingPay
                          withParams:params
                            animated:YES
                            callBack:NULL];
}


#pragma mark - Lazy Loading

@end
