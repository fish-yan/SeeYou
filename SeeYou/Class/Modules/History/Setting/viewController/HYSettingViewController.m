//
//  HYSettingViewController.m
//  youbaner
//
//  Created by luzhongchang on 17/8/9.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYSettingViewController.h"
#import "HySettingViewModel.h"
@interface HYSettingViewController ()
@property(nonatomic ,strong)HySettingViewModel * viewModel;
@end

@implementation HYSettingViewController


-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
   
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.canBack =YES;
    self.view.backgroundColor =[UIColor bgf5f5f5Color];
    self.navigationItem.title=@"设置";
    [self setupView];
    self.viewModel =[HySettingViewModel new];
    
    [self bindmodel];
    // Do any additional setup after loading the view.
}

-(void) popBack
{
    [super popBack];
     [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void) setupView
{
      @weakify(self);
    UIView * resetSecrect =[UIView viewWithBackgroundColor:[UIColor whiteColor] inView:self.view];

    [resetSecrect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top).offset(10);
        make.height.equalTo(@50);
    }];
    
    UILabel * titleLabel =[UILabel labelWithText:@"修改密码" textColor:[UIColor tc7d7d7dColor] fontSize:14 inView:resetSecrect tapAction:nil];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    UIImageView *arrowView =[UIImageView imageViewWithImageName:@"arrowright" inView:resetSecrect];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.top.equalTo(resetSecrect.mas_top).offset(16);
        make.height.equalTo(@15);
        make.width.equalTo(@150);
        
    }];
    
    [arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.top.equalTo(resetSecrect.mas_top).offset(16);
        make.height.equalTo(@14);
        make.width.equalTo(@8);
        
    }];
    
    
    
    UIView * userProtocal=[UIView viewWithBackgroundColor:[UIColor whiteColor] inView:self.view];
    
 
    [userProtocal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(resetSecrect.mas_bottom).offset(10);
        make.height.equalTo(@50);
    }];
    
    UILabel * userProtocalLabel =[UILabel labelWithText:@"用户协议" textColor:[UIColor tc7d7d7dColor] fontSize:14 inView:userProtocal tapAction:nil];
    userProtocalLabel.textAlignment = NSTextAlignmentLeft;
    
    UIImageView *userProtocalLabelarrowView =[UIImageView imageViewWithImageName:@"arrowright" inView:userProtocal];
    
    [userProtocalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.centerY.equalTo(userProtocal.mas_centerY);
        make.height.equalTo(@15);
        make.width.equalTo(@150);
        
    }];
    
    [userProtocalLabelarrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.top.equalTo(userProtocal.mas_top).offset(16);
        make.height.equalTo(@14);
        make.width.equalTo(@8);
        
    }];
    
    UITapGestureRecognizer * ges =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openProtocal)];
    [userProtocal addGestureRecognizer:ges];
    
    
    
    
    UIButton *resetButton =[UIButton buttonWithTitle:@"" titleColor:[UIColor clearColor] fontSize:0 bgColor:0 inView:self.view action:^(UIButton *btn) {
        
         [YSMediator pushToViewController:@"HYResetSecrectViewController" withParams:@{@"titleString":@"修改密码"} animated:YES callBack:nil];
    }];
    [resetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(resetSecrect);
    }];
    
    
    
    
    

    UIButton *logoutButton =[UIButton buttonWithTitle:@"退出登录" titleColor:[UIColor whiteColor] fontSize:14 bgColor:[UIColor bgff8bb1Color] inView:self.view action:^(UIButton *btn) {
        
        [WDProgressHUD showInView:nil];
        @strongify(self);
        [self.viewModel.doCommand execute:@"1"];
       
    }];
    [logoutButton.layer setMasksToBounds:YES];
    [logoutButton.layer setCornerRadius:2];
    [logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userProtocal.mas_bottom).offset(80);
        make.left.equalTo(resetSecrect.mas_left).offset(20);
        make.right.equalTo(resetSecrect.mas_right).offset(-20);
        make.height.equalTo(@50);
        
    }];
    
}

-(void)openProtocal
{
 [YSMediator pushToViewController:@"HYProtocalViewController" withParams:nil animated:YES callBack:nil];
}

-(void)bindmodel
{

    [[self.viewModel.doCommand.executionSignals switchToLatest] subscribeNext:^(WDResponseModel *  _Nullable x) {
    
        [[HYUserContext shareContext] deployLogoutAction];
        [WDProgressHUD showTips:x.msg];
        [WDProgressHUD hiddenHUD];
        
    }];
    [self.viewModel.doCommand.errors subscribeNext:^(NSError * _Nullable x) {
        [[HYUserContext shareContext] deployLogoutAction];
        [WDProgressHUD hiddenHUD];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
