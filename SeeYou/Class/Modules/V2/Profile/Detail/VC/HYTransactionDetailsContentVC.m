//
//  HYTransactionDetailsContentVC.m
//  youbaner
//
//  Created by Joseph Koh on 2018/4/19.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYTransactionDetailsContentVC.h"
#import "HYTransationDetailsCell.h"

@interface HYTransactionDetailsContentVC ()

@property (nonatomic, strong) HYTransactionDetailsVM *viewModel;

@end

@implementation HYTransactionDetailsContentVC

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialize];
    [self bind];
    
    [WDProgressHUD showInView:self.tableView];
    [self requestData]; 
}

#pragma mark - Action

- (void)requestData {
    [self.viewModel.getDetailRaccommand execute:nil];
}

- (void)requestMoreData {
    [self.viewModel.getDetailRaccommand execute:self.viewModel.flag];
}

- (void)hiddenHudFlag {
    [WDProgressHUD hiddenHUD];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
    [self.view hiddenFailureView];
}

#pragma mark - Bind

- (void)bind {
    @weakify(self);
    [[self.viewModel.getDetailRaccommand.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self hiddenHudFlag];
        
        if(self.viewModel.dataArray.count == 0) {
            [self.view showFailureViewOfType:WDFailureViewTypeEmpty withClickAction:^{
                @strongify(self);
                [WDProgressHUD showInView:self.view];
                [self requestData];
            }];
        }
        else {
            [self.tableView reloadData];
        }
    }];
    
    RAC(self.tableView.mj_footer, hidden) = [RACObserve(self, viewModel.hasMore) not];
    
    [self.viewModel.getDetailRaccommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        [self hiddenHudFlag];
        
        [self.view showFailureViewOfType:WDFailureViewTypeError withClickAction:^{
            @strongify(self);
            [self.tableView hiddenFailureView];
            [WDProgressHUD showInView:self.view];
            [self requestData];
            
        }];
    }];
}


#pragma mark - Initialize

- (void)initialize {
    self.viewModel = [HYTransactionDetailsVM new];
    self.viewModel.type = self.type;
    
    @weakify(self);
    [self.tableView registerClass:[HYTransationDetailsCell class] forCellReuseIdentifier:@"reuseID"];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.mj_header =[WDRefresher headerWithRefreshingBlock:^{
        @strongify(self);
        [self requestData];
    }];
    
    self.tableView.mj_footer =[WDRefresher  footerWithRefreshingBlock:^{
        @strongify(self);
        [self requestMoreData];
    }];
    
}



#pragma mark - UITableView DataSource && Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HYTransationDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseID" forIndexPath:indexPath];
    cell.model = self.viewModel.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}
@end
