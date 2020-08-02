//
//  HYHomeViewController.m
//  youbaner
//
//  Created by luzhongchang on 17/7/30.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYHomeViewController.h"
#import "HYHomeTableviewCell.h"
#import "HYHomeViewModel.h"
#import "HYHomeCellViewModel.h"
#import "HYLetGoTip.h"
#import "AuthenticationIngCommitSuccessViewController.h"
@interface HYHomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic ,strong) UITableView *mTableview;
@property(nonatomic ,strong) HYHomeViewModel *viewModel;
@property(nonatomic ,assign) NSString *sex;
@property(nonatomic ,assign) BOOL doing;
@end

#define HYHOMET_TABLEVIEWCELL_ID @"HYHomeTableviewCell"
@implementation HYHomeViewController


-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)setUpView
{
    self.mTableview =[UITableView tableViewOfStyle:UITableViewStyleGrouped inView:self.view withDatasource:self delegate:self];
    self.mTableview.showsVerticalScrollIndicator=NO;
    self.mTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mTableview.backgroundColor =[UIColor clearColor];
    //    self.mTableview.rowHeight=SCREEN_WIDTH+100;
    [self.mTableview registerClass:[HYHomeTableviewCell class] forCellReuseIdentifier:HYHOMET_TABLEVIEWCELL_ID];
    @weakify(self);
    [self.mTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom).offset(-44);
    }];
    
    self.mTableview.mj_header = [WDRefresher headerWithRefreshingBlock:^{
        @strongify(self);
        
        if(self.source ==HYHOME_LETGO)
        {
            
        }
        else
        {
            self.viewModel.page=1;
            [self.mTableview.mj_header beginRefreshing];
            [self.viewModel.doRaccommand execute:@"1"];
        }
    }];
    
    
    self.mTableview.mj_footer =[WDRefresher footerWithRefreshingBlock:^{
        
        @strongify(self);
        [self.mTableview.mj_footer beginRefreshing];
        [self.viewModel.doRaccommand execute:@"1"];
    }];
    
    
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.doing =NO;
    self.view.backgroundColor =[UIColor bge5e7e9Color];
    [self setUpView];
    self.viewModel = [HYHomeViewModel new];
    [self bindModel];
    
    [WDProgressHUD showInView:self.view];
    if(self.source ==HYHOME_LETGO)
    {
        self.canBack= YES;
        self.viewModel.sex = self.sex;
        self.doing =YES;
        [self.viewModel.doOneUserRaccommand execute:@"1"];
        
    }
    else
    {
        [self.viewModel.doRaccommand execute:@"1"];
    }
    
    // Do any additional setup after loading the view.
}


-(void) popBack
{
    [YSMediator popToViewControllerName:@"HYLoginViewController" animated:YES];
}



#pragma mark --bind--

- (void)bindModel
{
    @weakify(self);
    [RACObserve(self, source) subscribeNext:^(NSNumber *  _Nullable x) {
        
        @strongify(self);
        int fromSource = [x intValue];
        
        switch (fromSource) {
            case HYHOME_LETGO:
            {
                self.navigationItem.title=@"逛一逛";
                [self showTips];
                [self.mTableview mas_remakeConstraints:^(MASConstraintMaker *make) {
                    @strongify(self);
                    make.left.equalTo(self.view.mas_left);
                    make.right.equalTo(self.view.mas_right);
                    make.top.equalTo(self.view.mas_top);
                    make.bottom.equalTo(self.view.mas_bottom);
                }];
                
                UIButton  * button =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 21)];
                [button setTitle: @"立即注册" forState:UIControlStateNormal];
                [button setTitle: @"立即注册" forState:UIControlStateHighlighted];
                [button setTitleColor:[UIColor tcfd5492Color] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor tcfd5492Color] forState:UIControlStateHighlighted];
                button.titleLabel.font =Font_PINGFANG_SC(15);
                [button addTarget:self action:@selector(gotoRegister) forControlEvents:UIControlEventTouchUpInside];
                self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:button];
                
                self.mTableview.mj_header.hidden=YES;
                
            
            }
                break;
            case HYHOME:
            {
                self.navigationItem.title=@"遇见";
                [self.mTableview mas_remakeConstraints:^(MASConstraintMaker *make) {
                    @strongify(self);
                    make.left.equalTo(self.view.mas_left);
                    make.right.equalTo(self.view.mas_right);
                    make.top.equalTo(self.view.mas_top);
                    make.bottom.equalTo(self.view.mas_bottom).offset(-44);
                }];
            
            }
                break;
            default:
                break;
        }
        
    }];
    
    
        //home
    
    [[self.viewModel.doRaccommand.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [WDProgressHUD hiddenHUD];
        [self.view hiddenFailureView];
        
        [self.mTableview.mj_header endRefreshing];
        [self.mTableview.mj_footer endRefreshing];
        [self.mTableview reloadData];
        if(self.viewModel.listArray.count==0)
        {
            [self.view showFailureViewOfType:WDFailureViewTypeEmpty withClickAction:^{
                @strongify(self);
                [self.viewModel.doRaccommand execute:@"1"];
            }];
        }
        
    }];
    
    [self.viewModel.doRaccommand.errors subscribeNext:^(NSError * _Nullable x) {
       
        @strongify(self);
        [WDProgressHUD hiddenHUD];
         [self.view hiddenFailureView];
        [self.mTableview.mj_header endRefreshing];
        [self.mTableview.mj_footer endRefreshing];
        [WDProgressHUD showTips:x.localizedDescription];
        [self.view showFailureViewOfType:WDFailureViewTypeError withClickAction:^{
            @strongify(self);
            [self.viewModel.doRaccommand execute:@"1"];
        }];
    }];
    
        
    
    //逛一逛
    [[self.viewModel.doOneUserRaccommand.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        
        
        @strongify(self);
        self.doing=NO;
        [WDProgressHUD hiddenHUD];
        [self.view hiddenFailureView];
        [self.mTableview reloadData];
         if(self.viewModel.listArray.count==0)
         {
            [self.view showFailureViewOfType:WDFailureViewTypeEmpty withClickAction:^{
                @strongify(self);
                [WDProgressHUD showInView:self.view];
                [self.view hiddenFailureView];
                [self.viewModel.doRaccommand execute:@"1"];
            }];
         }
    }];
    
    [self.viewModel.doOneUserRaccommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        self.doing=NO;
        [WDProgressHUD hiddenHUD];
        [self.view hiddenFailureView];
        [WDProgressHUD showTips:x.localizedDescription];
        [self.view showFailureViewOfType:WDFailureViewTypeError withClickAction:^{
            [WDProgressHUD showInView:self.view];
            [self.view hiddenFailureView];
            @strongify(self);
            [self.viewModel.doRaccommand execute:@"1"];
        }];
    }];
    
    
    
    [RACObserve(self.viewModel, hasMore) subscribeNext:^(NSNumber *  _Nullable x) {
       
      
            self.mTableview.mj_footer.hidden=![x boolValue];
        
   
    }];
    

    
    
}

#pragma mark -- tableview delegate--

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.viewModel.listArray.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  1;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYHomeTableviewCell *cell = [tableView dequeueReusableCellWithIdentifier:HYHOMET_TABLEVIEWCELL_ID];
//    if (self.mTableview.dragging == NO && self.mTableview.decelerating == NO)
    {
        [cell bindWithViewModel:[self.viewModel.listArray objectAtIndex:indexPath.section]];
    }
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return [tableView fd_heightForCellWithIdentifier:HYHOMET_TABLEVIEWCELL_ID cacheByIndexPath:indexPath configuration:^(HYHomeTableviewCell * cell) {
        [cell bindWithViewModel:[self.viewModel.listArray objectAtIndex:indexPath.section]];
    }];
    
//    return [tableView fd_heightForCellWithIdentifier:HYHOMET_TABLEVIEWCELL_ID  configuration:^(HYHomeTableviewCell* cell) {
//        
//        [cell bindWithViewModel:[self.viewModel.listArray objectAtIndex:indexPath.section]];
//    }];
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
        return 10.0;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.01;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if(![self doNextOpration])
    {
        return;
    }
    
    id block=^(NSString *uid ,BOOL status)
    {
        
        for (int i=0; i< self.viewModel.listArray.count; i++) {
            HYHomeCellViewModel *vm = [self.viewModel.listArray objectAtIndex:i];
            if([vm.userId isEqualToString:uid])
            {
                ((HYHomeCellViewModel*)[self.viewModel.listArray objectAtIndex:i]).isBeMoved = status;
            }
        }
        
        
        
    };
    
    
    HYHomeCellViewModel *vm = [self.viewModel.listArray objectAtIndex:indexPath.section];
    [YSMediator pushToViewController:@"HYUserDetialViewController" withParams:@{@"uid":vm.userId,@"block":block} animated:YES callBack:^{
        
    }];
    
    //togo
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[SDWebImageManager sharedManager] cancelAll];
    
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        
    }];
    // Dispose of any resources that can be recreated.
}


/*显示下提示*/

- (void)showTips
{
    @weakify(self);
    HYLetGoTip *tips=[[HYLetGoTip alloc] initWithFrame:CGRectZero];
    [self.view addSubview:tips];
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    
    UITapGestureRecognizer * ges =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tryAndTry)];
    [tips addGestureRecognizer:ges];
    
}

-(void) tryAndTry
{
    if(self.doing)
    {
        [WDProgressHUD showTips:@"正在为您推荐优质对象..."];
        return;
    }
    [WDProgressHUD showInView:self.view];
    [self.viewModel.doOneUserRaccommand execute:@"1"];
}

-(void)gotoRegister
{
    [YSMediator popToViewControllerName:@"HYLoginViewController" animated:YES];
}

- (BOOL)doNextOpration
{
    if(![HYUserContext shareContext].login)
    {
        
        id cancelBlock=^()
        {
            
        };
        id sureBlock=^()
        {
            [[AppDelegateUIAssistant shareInstance].setLoginVCASRootVCComand execute:@"1"];
        };
        
        
        [YSMediator presentToViewController:@"HYAlertViewController"  withParams:@{@"message":@"为了保护会员隐私，登录后才可查看会员详情",
                                                                                          @"type":@2,
                                                                                          @"rightButtonTitle":@"去登录",
                                                                                          @"leftButtonTitle":@"取消",
                                                                                          @"rightTitleColor":[UIColor tcff8bb1Color],
                                                                                          @"cancelBlock":cancelBlock,
                                                                                          @"sureBlock":sureBlock
                                                                                          } animated:YES callBack:nil];
        
        return NO;
    }
    if([[HYUserContext shareContext].vipverifystatus intValue ]==0)
    {
        
        
        id cancelBlock=^()
        {
            
        };
        id sureBlock=^()
        {
            [YSMediator pushToViewController:@"IdentityAuthenticationViewController" withParams:@{} animated:YES callBack:nil];
        };
        
        
        [YSMediator presentToViewController:@"HYAlertViewController"  withParams:@{@"message":@"为了保护会员隐私，认证后才可以发送私信",
                                                                                          @"type":@2,
                                                                                          @"rightButtonTitle":@"立即认证",
                                                                                          @"leftButtonTitle":@"取消",
                                                                                          @"rightTitleColor":[UIColor tcff8bb1Color],
                                                                                          @"cancelBlock":cancelBlock,
                                                                                          @"sureBlock":sureBlock
                                                                                          } animated:YES callBack:nil];
        
        return NO;
    }
    return YES;
}

//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    if (!decelerate)
//    {
//        [self loadImagesForOnscreenRows];
//    }
//}
//
////// -------------------------------------------------------------------------------
//////	scrollViewDidEndDecelerating:scrollView
//////  When scrolling stops, proceed to load the app icons that are on screen.
////// -------------------------------------------------------------------------------
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    [self ];
//}

//- (void)loadImagesForOnscreenRows
//{
//    [self.mTableview beginUpdates];
//    [self.mTableview reloadData];
//    [self.mTableview e]
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
