//
//  HYTopPayViewController.m
//  youbaner
//
//  Created by Joseph Koh on 2018/6/19.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYTopPayViewController.h"
#import "HYPopPayAnimator.h"
#import "HYPopDataModel.h"

@interface PopActionView : UIView

@property (nonatomic, strong) UILabel *tlabel;
@property (nonatomic, strong) UILabel *vlabel;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *value;

@property (nonatomic, copy) void (^action)(NSString *value);

+ (instancetype)actionViewWithTitle:(NSString *)title
                              value:(NSString *)value
                             action:(void (^)(NSString *value))action;

@end


@implementation PopActionView

+ (instancetype)actionViewWithTitle:(NSString *)title
                              value:(NSString *)value
                             action:(void (^)(NSString *value))action {
    PopActionView *v = [[PopActionView alloc] init];
    v.title          = title;
    v.value          = value;
    v.action         = action;
    return v;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubvews];
        [self setupSubvewsLayout];
        [self bind];
    }

    return self;
}

- (void)setupSubvews {
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pop_top_bg"]];
    _tlabel              = [UILabel labelWithText:self.title
                           textColor:[UIColor colorWithHexString:@"#313131"]
                            fontSize:18
                              inView:self
                           tapAction:NULL];
    _vlabel =
    [UILabel labelWithText:self.value textColor:[UIColor whiteColor] fontSize:18 inView:self tapAction:NULL];
    _vlabel.textAlignment      = NSTextAlignmentCenter;
    _vlabel.layer.cornerRadius = 45 * 0.5;
    _vlabel.clipsToBounds      = YES;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [self addGestureRecognizer:tap];
    @weakify(self);
    [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer *_Nullable x) {
        @strongify(self);
        if (self.action) {
            self.action(self.value);
        }
    }];
}

- (void)setupSubvewsLayout {
    [self.tlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(45);
        make.centerY.height.equalTo(self);
    }];

    [self.vlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.height.centerY.equalTo(self);
        make.width.mas_equalTo(95);
    }];
}

- (void)bind {
    RAC(self.tlabel, text) = RACObserve(self, title);

    @weakify(self);
    [RACObserve(self, title) subscribeNext:^(NSString *_Nullable x) {
        @strongify(self);
        if (x == nil) {
            self.hidden = YES;
        } else {
            self.hidden = NO;
        }
    }];
    RAC(self.vlabel, text) = RACObserve(self, value);
}

@end

@interface HYTopPayViewController ()

@property (nonatomic, strong) HYPopPayVM *viewModel;
@property (nonatomic, strong) HYPopPayAnimator *animator;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) HYPopDataModel *dataModel;

@property (nonatomic, strong) NSMutableArray *itemsArrM;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation HYTopPayViewController


+ (void)load {
    [self mapName:kModuleTopDisplayPay withParams:nil];
}

#pragma mark - Life Circle

- (instancetype)init {
    if (self = [super init]) {
        self.animator               = [HYPopPayAnimator new];
        self.transitioningDelegate  = self.animator;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self initialize];
    [self setupSubviews];
    [self setupSubviewsLayout];
    [self bind];
    [self requestProducts];
}

#pragma mark - Action

- (void)requestProducts {
    [WDProgressHUD showInView:self.view];
    [self.viewModel fetchDataWithResult:^(NSArray * _Nonnull dataArray, NSError * _Nonnull error) {
        if (error) {
            [WDProgressHUD showTips:error.localizedDescription];
            return;
        }
        [self.viewModel updateDataArray:dataArray];
        
        [WDProgressHUD hiddenHUD];
        [self resetupListData];
    }];
}

- (void)purchase {
    [WDProgressHUD showInView:self.view];
    [self.viewModel.fetchOrderIDCmd execute:nil];
}

#pragma mark - Bind

- (void)bind {
    @weakify(self);
    [[self.viewModel.fetchOrderIDCmd.executionSignals switchToLatest] subscribeNext:^(id _Nullable x) {
        @strongify(self);
        [self.viewModel purchaseWithResult:^(NSString * _Nonnull receipt, NSError * _Nonnull error) {
            if (error) {
                [WDProgressHUD showTips:error.localizedDescription];
                return;
            }
            
            [self.viewModel.checkReceiptCmd execute:receipt];
        }];
    }];
    
    [self.viewModel.fetchOrderIDCmd.errors subscribeNext:^(NSError *_Nullable x) {
        [WDProgressHUD hiddenHUD];
        [WDProgressHUD showTips:x.localizedDescription];
    }];
    
    [[self.viewModel.fetchOrderIDCmd.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue]) {
            [WDProgressHUD showInView:self.view];
        }
    }];
    
    //
    [[self.viewModel.checkReceiptCmd.executionSignals switchToLatest] subscribeNext:^(id _Nullable x) {
        [[HYUserContext shareContext] fetchLatestUserinfoWithSuccessHandle:^(HYUserCenterModel *infoModel) {
            [WDProgressHUD hiddenHUD];
            [[HYUserContext shareContext] deployLoginActionWithUserModel:infoModel];
            [self dismissViewControllerAnimated:YES completion:NULL];
            
        }
                                                             failureHandle:^(NSError *error) {
                                                                 [WDProgressHUD hiddenHUD];
                                                             }];
        
        
    }];
    [self.viewModel.checkReceiptCmd.errors subscribeNext:^(NSError *_Nullable x) {
        [WDProgressHUD hiddenHUD];
        [WDProgressHUD showTips:@"购买凭证校验失败"];
    }];
}


//
//#pragma mark - Action
//
//- (void)submitAction {
//    NSLog(@"-----> submit action");
//}
//
//
//#pragma mark - Bind
//
//- (void)bind {
//    @weakify(self);
//
//    [[[self.viewModel.topDisplayRaccommand.executionSignals switchToLatest]
//    merge:[self.viewModel.matchMakerRaccommand.executionSignals switchToLatest]] subscribeNext:^(id _Nullable x) {
//        @strongify(self);
//        [WDProgressHUD hiddenHUD];
//        [self resetupListData];
//    }];
//
//    [[self.viewModel.topDisplayRaccommand.errors merge:self.viewModel.topDisplayRaccommand.errors]
//    subscribeNext:^(NSError *_Nullable x) {
//        [WDProgressHUD showTips:x.localizedDescription];
//    }];
//
//
//    [[self.viewModel.TrayHasExtraRaccommand.executionSignals switchToLatest] subscribeNext:^(WDResponseModel *_Nullable x) {
//        @strongify(self);
//        [self juage];
//    }];
//
//    [self.viewModel.TrayHasExtraRaccommand.errors subscribeNext:^(NSError *_Nullable x) {
//        [WDProgressHUD showTips:x.localizedDescription];
//    }];
//}

- (void)resetupListData {
    [self.viewModel.dataArray enumerateObjectsUsingBlock:^(NSDictionary *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        if (idx >= self.itemsArrM.count) return;

        PopActionView *v = self.itemsArrM[idx];
        v.title          = obj[@"title"];
        v.value          = obj[@"price"];
    }];
}


#pragma mark - Initialize

- (void)initialize {
    self.view.backgroundColor = [UIColor clearColor];
    self.viewModel            = [HYPopPayVM new];
    self.viewModel.type       = self.type;
}

- (void)requestData {
    [WDProgressHUD showInView:self.view];
    if (self.type == HYPopPayTypeTopDisplay) {
        [self.viewModel.topDisplayRaccommand execute:@{ @"type": @"2" }];
    } else {
        [self.viewModel.topDisplayRaccommand execute:@{ @"type": @"4" }];
    }
}


#pragma mark - Setup Subviews

- (void)setupSubviews {
    self.maskView       = [UIView viewWithBackgroundColor:[UIColor blackColor] inView:self.view];
    self.maskView.tag   = 1024;
    self.maskView.alpha = 0.4;
    self.maskView.translatesAutoresizingMaskIntoConstraints = NO;

    self.contentView                    = [UIView viewWithBackgroundColor:[UIColor whiteColor] inView:self.view];
    self.contentView.clipsToBounds      = YES;
    self.contentView.layer.cornerRadius = 5;
    self.contentView.tag                = 1025;

    self.closeBtn = [UIButton buttonWithNormalImgName:@"white_close"
                                              bgColor:nil
                                               inView:self.view
                                               action:^(UIButton *btn) {
                                                   [self dismissViewControllerAnimated:YES completion:NULL];
                                               }];
    self.closeBtn.tag = 1026;

    //
    _titleLabel = [UILabel labelWithText:self.viewModel.tips
                               textColor:[UIColor colorWithHexString:@"#313131"]
                           textAlignment:NSTextAlignmentCenter
                                fontSize:16
                                  inView:_contentView
                               tapAction:NULL];
    _titleLabel.numberOfLines = 0;
}

- (void)setupSubviewsLayout {
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];


    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.mas_equalTo(self.viewModel.popViewHeight);
        make.width.mas_equalTo(315);
    }];

    //
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_contentView);
        make.top.offset(30);
        make.left.offset(20);
        make.right.offset(-20);
    }];


    __block CGFloat offset_y = 30;
    @weakify(self);
    [self.viewModel.dataArray enumerateObjectsUsingBlock:^(NSDictionary *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {

        PopActionView *v = [self cacheActionViewAtIndex:idx
                                              withTitle:obj[@"title"]
                                                  value:obj[@"price"]
                                                 action:^(NSString *value) {
                                                     @strongify(self);
                                                     self.viewModel.itemSelectedIdx = idx;
                                                     [self.viewModel.fetchOrderIDCmd execute:nil];
//                                                     self.dataModel = value;
//                                                     [self tryhasExtra:value.ID];
                                                 }];
        [_contentView addSubview:v];

        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_bottom).offset(offset_y);
            make.left.offset(25);
            make.right.offset(-25);
            make.height.mas_equalTo(45);
        }];

        offset_y += (45 + 10);
    }];

    //
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.contentView.mas_bottom).offset(10);
        make.width.height.mas_equalTo(24);
    }];
}


- (PopActionView *)cacheActionViewAtIndex:(NSInteger)idx
                                withTitle:(NSString *)title
                                    value:(NSString *)value
                                   action:(void (^)(NSString *value))action {
    if (self.itemsArrM.count == 0 || (self.itemsArrM.count && self.itemsArrM.count <= idx)) {
        PopActionView *v = [PopActionView actionViewWithTitle:title value:value action:action];
        [self.itemsArrM addObject:v];
        return v;
    }

    return self.itemsArrM[idx];
}

- (NSMutableArray *)itemsArrM {
    if (!_itemsArrM) {
        _itemsArrM = [NSMutableArray array];
    }
    return _itemsArrM;
}
//
//- (void)tryhasExtra:(NSString *)ID {
//    if (ID == nil) {
//        return;
//    }
//    [WDProgressHUD showInView:self.view];
//    [self.viewModel.TrayHasExtraRaccommand execute:@{ @"id": ID }];
//}
//
//- (void)juage {
//    // 0：余额不足抵扣，1：余额足够抵扣
//    if ([self.viewModel.extraModel.status intValue] == 1) {
//        [WDProgressHUD showTips:@"购买成功"];
//        if (self.payResult) {
//            self.payResult(YES);
//        }
//        [self dismissViewControllerAnimated:YES completion:NULL];
//    } else {
//        [self dismissViewControllerAnimated:YES
//                                 completion:^{
//
//                                     id rst = ^(BOOL isSuccess){
//                                         if (isSuccess) {
//                                             [WDProgressHUD showTips:@"购买成功"];
//
//                                             if (self.payResult) {
//                                                 self.payResult(YES);
//                                             }
//                                             [YSMediator popToViewControllerName:@"HYProfileVC" animated:YES];
//                                         } else {
//                                             [WDProgressHUD showTips:@"购买失败"];
//                                             if (self.payResult) {
//                                                 self.payResult(NO);
//                                             }
//                                         }                                     };
//                                     /*
//                                      @property(nonatomic ,strong) NSString * ID;
//                                      @property(nonatomic ,strong) NSString * name;
//                                      @property(nonatomic ,strong) NSString * price;
//                                      @property(nonatomic ,strong) NSString *price2;
//                                      */
//                                     prepayappointmentModel * extraModel = self.viewModel.extraModel;
//                                     NSDictionary *params = @{
//                                                              @"orderId": extraModel.orderid ?: @"",
//                                                              @"balance": extraModel.balance,
//                                                              @"payCount": extraModel.payamount,
//                                                              @"rst": rst,
//                                                              @"actionType": @1
//                                                              };
//                                     [YSMediator pushToViewController:kModuleDatingPay
//                                                           withParams:params
//                                                             animated:YES
//                                                             callBack:NULL];
//
//                                 }];
//    }
//}
@end
