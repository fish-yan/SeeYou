//
//  HYMyAccountVC.m
//  youbaner
//
//  Created by Joseph Koh on 2018/4/19.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYMyAccountVC.h"
#import "HYMyAccountVM.h"
#import "HYMyAccountCell.h"

@interface HYMyAccountVC ()

@property (nonatomic, strong) HYMyAccountVM *viewModel;

@end

@implementation HYMyAccountVC

+ (void)load {
    [self mapName:kModuleMyAccount withParams:nil];
}

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialize];
    [self bind];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self requestData];
}


#pragma mark - Action

- (void)requestData {
    [self.viewModel.requestCmd execute:nil];
}

- (void)rightItemAction {
    [YSMediator pushToViewController:kModuleAccountDetail
                          withParams:nil
                            animated:YES
                            callBack:NULL];
}

- (void)rechargeMoney {
    [YSMediator pushToViewController:kModuleMoneyRecharge
                          withParams:@{@"money": self.viewModel.balance}
                            animated:YES
                            callBack:NULL];
}

- (void)transterMoney {
    [YSMediator pushToViewController:kModuleMoneyTransfer
                          withParams:@{@"money": self.viewModel.profit}
                            animated:YES
                            callBack:NULL];
}

- (void)withdarwMoney {
    [YSMediator pushToViewController:kModuleMoneyWithdarw
                          withParams:@{@"money": self.viewModel.profit}
                            animated:YES
                            callBack:NULL];
}

#pragma mark - Bind

- (void)bind {
    @weakify(self);
    [[self.viewModel.requestCmd.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        @strongify(self);
        if ([x boolValue]) {
            [WDProgressHUD showInView:self.view];
        }
    }];
    
    [[self.viewModel.requestCmd.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [WDProgressHUD hiddenHUD];
        [self.tableView reloadData];
    }];
    
    [self.viewModel.requestCmd.errors subscribeNext:^(NSError * _Nullable x) {
        [WDProgressHUD showTips:x.localizedDescription];
        @strongify(self);
        [self.view showFailureViewOfType:WDFailureViewTypeError
                         withClickAction:^{
                             @strongify(self);
                             [self requestData];
                         }];
    }];
}


#pragma mark - TableView Datasource && Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 116;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HYMyAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseID" forIndexPath:indexPath];
    cell.model = self.viewModel.dataArray[indexPath.row];
    @weakify(self);
    cell.detailAction = ^{
        [self rightItemAction];
    };
    cell.rechargeAction = ^{
        @strongify(self);
        [self rechargeMoney];
    };
    cell.withdarwAction = ^{
        [WDProgressHUD showTips:@"暂无开通, 敬请期待"];
//        @strongify(self);
//        [self withdarwMoney];
    };

    cell.transferAction = ^{
        [WDProgressHUD showTips:@"暂无开通, 敬请期待"];
//        @strongify(self);
//        [self transterMoney];
    };
    return cell;
}


#pragma mark - Initialize

- (void)initialize {
    self.navigationItem.title = @"我的账户";
    self.viewModel = [HYMyAccountVM new];
    self.style = UITableViewStyleGrouped;
}


#pragma mark - Setup Subviews

- (void)setupSubviews {
    [super setupSubviews];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"明细"
//                                                                              style:UIBarButtonItemStylePlain
//                                                                             target:self
//                                                                             action:@selector(rightItemAction)];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[HYMyAccountCell class] forCellReuseIdentifier:@"reuseID"];
    
}

- (void)setupSubviewsLayout {
    [super setupSubviewsLayout];
}


#pragma mark - Lazy Loading

@end
