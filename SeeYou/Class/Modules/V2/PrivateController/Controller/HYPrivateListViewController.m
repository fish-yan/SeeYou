//
//  HYPrivateListViewController.m
//  youbaner
//
//  Created by luzhongchang on 17/7/31.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYPrivateListViewController.h"
#import "HYPrivateListViewModel.h"
#import "HYPrivateCellViewModel.h"
#import "HYPrivateListCell.h"
#import "AuthenticationManager.h"
@interface HYPrivateListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic ,strong) UITableView *mTableview;
@property(nonatomic ,strong) HYPrivateListViewModel *viewModel;
@property(nonatomic ,strong) UIButton * rightButton;
@end
#define HYPRIVVATE_CELL_INDENTIFY @"HyprivateListcell_indentify"
@implementation HYPrivateListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self setUpView];
    self.viewModel = [HYPrivateListViewModel new];
    [self bindmodel];
    [WDProgressHUD showInView:self.view];
   
//    UIBarButtonItem * rightButton =[[UIBarButtonItem alloc] initWithTitle:@"全部已读" style:UIBarButtonItemStylePlain target:self action:@selector(doAllread)];
//
//    self.rightButton =[UIButton buttonWithTitle:@"全部已读" titleColor:[UIColor bg2Color] fontSize:15 bgColor:[UIColor clearColor] inView:self.view action:^(UIButton *btn) {
//        [self doAllread];
//    }];
//    [self.view addSubview:self.rightButton];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
//    
    // Do any additional setup after loading the view.
}

-(void)doAllread
{
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{

    [super viewDidAppear:animated];
    self.viewModel.page=1;
    [self.viewModel.doCommand execute:@"1"];
    // 获取最新的未读信息数据
    [[HYUnreadInfoFetcher shareInstance].unreadMsgCmd execute:nil];
}

-(void)setUpView
{
    self.mTableview =[UITableView tableViewOfStyle:UITableViewStylePlain inView:self.view withDatasource:self delegate:self];
    self.mTableview.showsVerticalScrollIndicator=NO;
    self.mTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mTableview.backgroundColor =[UIColor clearColor];
    [self.mTableview registerClass:[HYPrivateListCell class] forCellReuseIdentifier:HYPRIVVATE_CELL_INDENTIFY];
    @weakify(self);
    [self.mTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom).offset(-44);
    }];

    self.mTableview.mj_header =[WDRefresher headerWithRefreshingBlock:^{
        @strongify(self);
        
        self.viewModel.page=1;
        [self.viewModel.doCommand execute:@"1"];
    }];
    
    self.mTableview.mj_footer = [WDRefresher footerWithRefreshingBlock:^{
        [self.viewModel.doCommand execute:@"1"];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- tableview delegate--

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.listArray.count;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYPrivateListCell *cell = [tableView dequeueReusableCellWithIdentifier:HYPRIVVATE_CELL_INDENTIFY];
    HYPrivateCellViewModel *vm = [self.viewModel.listArray objectAtIndex:indexPath.row];
    [cell bindWithViewModel:vm];
    cell.showBottomLine=YES;
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 105.0;
}

- (void)showPayAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:@"升级会员即可无限畅聊"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消"
                                              style:UIAlertActionStyleCancel
                                            handler:^(UIAlertAction * _Nonnull action) {
                                                
                                            }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"免费试用"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *_Nonnull action) {
                                                [YSMediator pushToViewController:@"HYMembershipVC"
                                                                      withParams:@{}
                                                                        animated:YES
                                                                        callBack:nil];
                                            }]];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(![[HYUserContext shareContext].userModel.vipstatus boolValue]) {
        [self showPayAlert];
        return;
    }
    
    HYPrivateCellViewModel *vm =[self.viewModel.listArray objectAtIndex:indexPath.row];
    
    if( [vm.usertype intValue]==3)
    {
        
        [vm.doRecommand execute:@"1"];
        [YSMediator pushToViewController:@"PrivateMessageDetialViewController" withParams:@{@"cantactName":vm.userName,@"cantactID":vm.uid,@"avatar":vm.photoString } animated:YES callBack:nil];
        return;
    }
    
    
    if(![[HYUserContext shareContext].userModel.vipstatus boolValue])
    {
        //todo 购买会员
        [YSMediator pushToViewController:@"HYMembershipVC" withParams:@{} animated:YES callBack:nil];
        return;
    }
    
    [vm.doRecommand execute:@"1"];
    [YSMediator pushToViewController:@"PrivateMessageDetialViewController" withParams:@{@"cantactName":vm.userName,@"cantactID":vm.uid,@"avatar":vm.photoString } animated:YES callBack:^{
        HYPrivateCellViewModel *vm = [self.viewModel.listArray objectAtIndex:indexPath.row];
        vm.hasRead = YES;
        // 获取最新的未读信息数据
        [[HYUnreadInfoFetcher shareInstance].unreadMsgCmd execute:nil];
    }];
    

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 从数据源中删除
    NSMutableArray * array  =[NSMutableArray arrayWithArray:self.viewModel.listArray];
    HYPrivateCellViewModel * m = [array objectAtIndex:indexPath.row];
    [array removeObjectAtIndex:indexPath.row];
    //这边需要调用删除接口
    [self.viewModel.dodeleteCommand execute:@{@"id":m.messageID }];
    
    self.viewModel.listArray= [array copy];
    // 从列表中删除
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}


-(void)bindmodel
{
    @weakify(self);
    [[self.viewModel.doCommand.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.mTableview.mj_header endRefreshing];
        [self.mTableview.mj_footer endRefreshing];
        [WDProgressHUD hiddenHUD];
        [self.view hiddenFailureView];
        [self.mTableview reloadData];
        if(self.viewModel.listArray.count==0)
        {
        
            [self.view showFailureViewOfType:WDFailureViewTypeMessageEmpty withClickAction:^{
                [WDProgressHUD showInView:self.view];
                [self.view hiddenFailureView];
                self.viewModel.page=1;
                [self.viewModel.doCommand execute:@1];
                
            }];
        }
        
    }];
    [self.viewModel.doCommand.errors subscribeNext:^(NSError * _Nullable x) {
        [WDProgressHUD hiddenHUD];
        [self.view hiddenFailureView];
        [self.mTableview.mj_header endRefreshing];
        [self.mTableview.mj_footer endRefreshing];
        [WDProgressHUD showTips:x.localizedDescription];
        
        [self.view showFailureViewOfType:WDFailureViewTypeError withClickAction:^{
            [WDProgressHUD showInView:self.view];
            [self.view hiddenFailureView];
            self.viewModel.page=1;
            [self.viewModel.doCommand execute:@1];
            
        }];
        
        
    
        
    }];
    
    [RACObserve(self.viewModel,hasMore) subscribeNext:^(NSNumber*  _Nullable x) {
       
        @strongify(self);
        if([x boolValue])
        {
            self.mTableview.mj_footer.hidden=NO;
        }
        else
        {
            self.mTableview.mj_footer.hidden=YES;
        }
        
    }];
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
