//
//  HYLoginViewSubViewController.m
//  youbaner
//
//  Created by luzhongchang on 17/8/4.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYLoginViewSubViewController.h"
#import "LoginTextfiledView.h"
#import "NSString+Ext.h"
#import "HYLoginViewModel.h"
#import "RegexKit.h"
#import "SpecialRegexKit.h"

@interface HYLoginViewSubViewController ()<UITextFieldDelegate>
@property(nonatomic ,strong) LoginTextfiledView * phoneTextFiled;
@property(nonatomic ,strong) LoginTextfiledView * passWordTextfiled;

@property(nonatomic ,strong) UIButton * forgetPasswordButton;
@property(nonatomic ,strong) UIButton * loginButton;


@property(nonatomic ,strong) UILabel * proticalLablel;

@property (nonatomic,strong)UIScrollView * scrolleView;

@property (nonatomic ,strong) HYLoginViewModel * viewModel;

@end

@implementation HYLoginViewSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    self.canBack=YES;
    self.navigationItem.title=@"登录";
    [self setUpViews];
    self.viewModel =[[HYLoginViewModel alloc] init];
    [self bindViewModel];
    
    // Do any additional setup after loading the view.
}



-(void) setUpViews
{
    
    @weakify(self);
    [self.view addSubview:self.scrolleView];
    [self.scrolleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.scrolleView.scrollEnabled = NO;
    
    self.phoneTextFiled = [[LoginTextfiledView alloc]initWithPlaceHolder:@"请输入手机号" LoginTextFieldViewType:NormalTextFieldType title:@"请输入手机号"];
    [self.scrolleView addSubview:self.phoneTextFiled];
    [self.phoneTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.scrolleView.mas_top).offset(25.);
        make.height.mas_equalTo(70.0);
    }];
    
    
    self.passWordTextfiled = [[LoginTextfiledView alloc]initWithPlaceHolder:@"请输入密码（6-18位数字或字母）" LoginTextFieldViewType:PwdTextFieldType title:@"请输入密码（6-18位数字或字母）"];
    [self.scrolleView addSubview:self.passWordTextfiled];
    [self.passWordTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.phoneTextFiled.mas_bottom).offset(15.);
        make.height.mas_equalTo(70.0);
    }];
    
    [self.view addSubview:self.loginButton];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(- 20.);
        if(IS_IPHONE_5 || IS_IPHONE_4_OR_LESS){
            make.top.mas_equalTo(self.passWordTextfiled.mas_bottom).offset(45.5);
        }else{
            make.top.mas_equalTo(self.passWordTextfiled.mas_bottom).offset(151.0);
        }
        
        make.height.mas_equalTo(@44.);
    }];
    
    
    self.forgetPasswordButton=[UIButton buttonWithTitle:@"忘记密码?" titleColor:[UIColor tc31Color] fontSize:13 bgColor:[UIColor clearColor] inView:self.scrolleView action:^(UIButton *btn) {
       
        [YSMediator pushToViewController:@"HYResetSecrectViewController" withParams:@{@"titleString":@"忘记密码"} animated:YES callBack:nil];
        
    }];
    
    self.proticalLablel =[UILabel labelWithText:@"注册表示同意【花缘注册协议】" textColor:[UIColor tc69Color ] fontSize:10 inView:self.scrolleView tapAction:nil];
    
    UIButton *proticalLablelbutton =[UIButton buttonWithType:UIButtonTypeCustom];
    proticalLablelbutton.backgroundColor=[UIColor clearColor];
    [self.scrolleView addSubview:proticalLablelbutton];
    [proticalLablelbutton addTarget:self action:@selector(openProtical) forControlEvents:UIControlEventTouchUpInside];
    [proticalLablelbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom).offset(-10);
        make.height.equalTo(@44);
    }];
    
    
    self.proticalLablel.textAlignment =NSTextAlignmentCenter;
    [self.proticalLablel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.bottom.equalTo(self.view.mas_bottom).offset(-15);
        make.height.equalTo(@10);
    }];
    
    
    
    [self.forgetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.top.equalTo(self.passWordTextfiled.mas_bottom).offset(20);
        make.height.equalTo(@18);
    }];
}


-(void)openProtical
{
     [YSMediator pushToViewController:@"HYProtocalViewController" withParams:nil animated:YES callBack:nil];
}



- (UIScrollView *)scrolleView{
    
    if (!_scrolleView) {
        _scrolleView = [UIScrollView new];
        _scrolleView.contentSize = CGSizeMake(SCREEN_WIDTH, 700);
    }
    return _scrolleView;
}

- (UIButton *)loginButton{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton.titleLabel setFont: Font_PINGFANG_SC(14)];
        [_loginButton setBackgroundColor:[UIColor bt0Color]];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(LodginFunction:) forControlEvents:UIControlEventTouchUpInside];
        _loginButton.layer.cornerRadius = 3;
        _loginButton.clipsToBounds = YES;
        
    }
    return _loginButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -bindViewModel
- (void)bindViewModel{
    @weakify(self);
    NSString * mobile = [[NSUserDefaults standardUserDefaults]objectForKey:USER_REGISTER_MOBILE_KEY];
    if ([mobile length]) {
        self.phoneTextFiled.textField.text = [mobile PhoneNumberFormatString];
    }
    
    RAC(self.viewModel , userName) = self.phoneTextFiled.textField.rac_textSignal;
    RAC(self.viewModel, password) = self.passWordTextfiled.textField.rac_textSignal;
    
    
    RAC(self.loginButton,enabled) = [RACSignal combineLatest:@[RACObserve(self.viewModel, userName),RACObserve(self.viewModel, password),]reduce:^id(NSString *userName,NSString * pwd){
        return @([RegexKit validateMobile:[userName delMiddleSapce]] && [pwd length]);
    }];
    [RACObserve(self.loginButton, enabled) subscribeNext:^(id x) {
        @strongify(self);
        self.loginButton.alpha   = [x boolValue] ? 1.0 : 0.5;
    }];
    
    
    
    [[self.viewModel.loginCommond.executionSignals switchToLatest]subscribeNext:^(id  _Nullable x) {
        [WDProgressHUD hiddenHUD];
        
    }];
    
    [self.viewModel.loginCommond.errors subscribeNext:^(NSError * _Nullable x) {
        [WDProgressHUD hiddenHUD];
        [WDProgressHUD showTips:x.localizedDescription];
    }];
    
    
}




#pragma mark - 键盘监听事件
- (void)keyboardDidShow:(NSNotification *)notification
{
    
    self.scrolleView.scrollEnabled = YES;
//    if(IS_IPHONE_5 || IS_IPHONE_4_OR_LESS){
//        [self.scrolleView setContentOffset:CGPointMake(0, 0) animated:YES];
//    }else{
//        [self.scrolleView setContentOffset:CGPointMake(0, 100.) animated:YES];
//    }
//    
    
    
    
    
    
}
- (void)keyboardDidHide:(NSNotification *)notification
{
    [self.scrolleView setContentOffset:CGPointMake(0, 0.) animated:YES];
    self.scrolleView.scrollEnabled = NO;
    
}


- (void)LodginFunction:(id)sender{
    
    
    
    if (![SpecialRegexKit validateSpecialPassword: self.passWordTextfiled.textField.text]) {
        [WDProgressHUD showTips:@"密码长度必须为6-18位，请重新输入"];
        [self.passWordTextfiled.textField becomeFirstResponder];
        return;
    }
    
    [self submitPassword];

}


-(void)submitPassword
{
    [WDProgressHUD showInView:self.view];
    [self.viewModel.loginCommond execute:@1];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
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
