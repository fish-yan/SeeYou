//
//  HYRegisterViewController.m
//  youbaner
//
//  Created by luzhongchang on 17/8/3.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYRegisterViewController.h"
#import "LoginTextfiledView.h"
#import "NSString+Ext.h"
#import "HYRegisterViewModel.h"
#import "RegexKit.h"
#import "SpecialRegexKit.h"
@interface HYRegisterViewController ()<UITextFieldDelegate>


@property(nonatomic ,strong) LoginTextfiledView * phoneTextFiled;
@property(nonatomic ,strong) LoginTextfiledView * codeTextfiled;
@property(nonatomic ,strong) LoginTextfiledView * passWordTextfiled;
@property(nonatomic ,strong) UILabel * countdownLabel;
@property(nonatomic ,strong) UIButton * registerButton;
@property(nonatomic ,strong) UILabel * proticalLablel;

@property (nonatomic,strong)UIScrollView * scrolleView;

@property (nonatomic ,strong) HYRegisterViewModel * viewModel;
@end

@implementation HYRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.canBack=YES;
    self.navigationItem.title=@"注册";
    [self setUpViews];
    self.viewModel =[[HYRegisterViewModel alloc] init];
    [self bindViewModel];
    
    // Do any additional setup after loading the view.
}

-(void) popBack
{
    [YSMediator pushToViewController:@"HYLoginViewController" withParams:nil animated:YES callBack:NULL];
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
    
    self.codeTextfiled = [[LoginTextfiledView alloc]initWithPlaceHolder:@"请输入验证码" LoginTextFieldViewType:SendCodeTextFieldType title:@"请输入验证码"];
    self.codeTextfiled.getVeryCodeBlock = ^(){
        @strongify(self);
        [self getVerycode];
    };
    
    [self.scrolleView addSubview:self.codeTextfiled];
    [self.codeTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.phoneTextFiled.mas_bottom).offset(15.);
        make.height.mas_equalTo(70.0);
    }];
    
    
    self.passWordTextfiled = [[LoginTextfiledView alloc]initWithPlaceHolder:@"请设置密码（6-18位数字或字母）" LoginTextFieldViewType:PwdTextFieldType title:@"请设置密码（6-18位数字或字母）"];
    [self.scrolleView addSubview:self.passWordTextfiled];
    [self.passWordTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.codeTextfiled.mas_bottom).offset(15.);
        make.height.mas_equalTo(70.0);
    }];
    
    [self.view addSubview:self.registerButton];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(- 20.);
        if(IS_IPHONE_5 || IS_IPHONE_4_OR_LESS){
            make.top.mas_equalTo(self.passWordTextfiled.mas_bottom).offset(45.5);
        }else{
            make.top.mas_equalTo(self.passWordTextfiled.mas_bottom).offset(65.5);
        }
        
        make.height.mas_equalTo(@44.);
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

- (UIButton *)registerButton{
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton.titleLabel setFont:Font_PINGFANG_SC(14.0)];
        [_registerButton setBackgroundColor:[UIColor bt0Color]];
        [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registerButton addTarget:self action:@selector(registerFunction:) forControlEvents:UIControlEventTouchUpInside];
        _registerButton.layer.cornerRadius = 3;
        _registerButton.clipsToBounds = YES;
        
    }
    return _registerButton;
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
    
    RAC(self.viewModel , loginName) = self.phoneTextFiled.textField.rac_textSignal;
    RAC(self.viewModel, verifyCode) = self.codeTextfiled.textField.rac_textSignal;
    RAC(self.viewModel, password) = self.passWordTextfiled.textField.rac_textSignal;

   
    RAC(self.registerButton,enabled) = [RACSignal combineLatest:@[RACObserve(self.viewModel, loginName), RACObserve(self.viewModel, verifyCode),RACObserve(self.viewModel, password)]reduce:^id(NSString *userName, NSString *verifyCode,NSString * pwd){
        return @([RegexKit validateMobile:[userName delMiddleSapce]] && verifyCode.length == 6&& [pwd length]);
    }];
    [RACObserve(self.registerButton, enabled) subscribeNext:^(id x) {
        @strongify(self);
        self.registerButton.alpha   = [x boolValue] ? 1.0 : 0.5;
    }];
    
    [RACObserve(self.codeTextfiled.sendCodeButton, enabled)subscribeNext:^(NSNumber * enable) {
        @strongify(self);
        if([enable boolValue]){
            [self.codeTextfiled.sendCodeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }else{
            [self.codeTextfiled.sendCodeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
    }];
    [self.phoneTextFiled.textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
         @strongify(self);
        if ([x length]) {
            self.codeTextfiled.sendCodeButton.enabled = YES;
        }else{
            self.codeTextfiled.sendCodeButton.enabled = NO;
        }
    }];
    [self.codeTextfiled.textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        if(x.length >6){
            self.codeTextfiled.textField.text = [self.codeTextfiled.textField.text substringToIndex:6];
        }
        
    }];

    [RACObserve([HYCountDown shareHelper], registerTime) subscribeNext:^(NSNumber *countdown) {
        @strongify(self);
        if ([countdown intValue] <0) {
            
            [self.codeTextfiled.sendCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
            [self.codeTextfiled.sendCodeButton  removeAllAnimation];
            self.codeTextfiled.sendCodeButton.titleLabel.font = [UIFont systemFontOfSize:13.];
            [HYUserContext shareContext].autoSendCode = YES;
            if(self.phoneTextFiled.textField.text.length){
                self.codeTextfiled.sendCodeButton.enabled = YES;
            }else{
                self.codeTextfiled.sendCodeButton.enabled = NO;
            }
        }else if ([countdown intValue] ==0){
            [self.codeTextfiled.sendCodeButton setTitle:@"再次获取验证码" forState:UIControlStateNormal];
            [self.codeTextfiled.sendCodeButton  removeAllAnimation];
            self.codeTextfiled.sendCodeButton.titleLabel.font = [UIFont systemFontOfSize:13.];
            [HYUserContext shareContext].autoSendCode = YES;
            self.codeTextfiled.sendCodeButton.enabled = YES;
        }else {
            [self.codeTextfiled.sendCodeButton setTitle:[NSString stringWithFormat:@"%lds", [countdown integerValue]] forState:UIControlStateNormal];
            self.codeTextfiled.sendCodeButton.titleLabel.font = [UIFont systemFontOfSize:13.];
            [HYUserContext shareContext].autoSendCode = NO;
            self.codeTextfiled.sendCodeButton.enabled = NO;
        }
    }];
    
    [[self.viewModel.cutdownCommond.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        [[HYCountDown shareHelper] startWithCountDownType:WDCountDownTypeRegister limitedTime:59];
        [self.codeTextfiled.sendCodeButton  loadingAnimation];
    }];
    [self.viewModel.cutdownCommond.errors subscribeNext:^(NSError * _Nullable x) {
        [WDProgressHUD showTips:x.localizedDescription];
    }];
    
    
    [[self.viewModel.requestRegisterCommond.executionSignals switchToLatest]subscribeNext:^(id  _Nullable x) {
       
        [WDProgressHUD hiddenHUD];
    }];
    
    [self.viewModel.requestRegisterCommond.errors subscribeNext:^(NSError * _Nullable x) {
        
        [WDProgressHUD hiddenHUD];
        [WDProgressHUD showTips:x.localizedDescription];
    }];
    
    
}


#pragma mark -获取验证码
- (void)getVerycode{
    
    if (![RegexKit validateMobile:[self.phoneTextFiled.textField.text delMiddleSapce]]) {
        
        [WDProgressHUD showTips:@"请输入有效的手机号"];
        [self.phoneTextFiled.textField becomeFirstResponder];
        return;
    }
    
    self.viewModel.codeType = VerifyCodeTypeRegist;
    
    self.viewModel.loginName = [self.phoneTextFiled.textField.text delMiddleSapce];
    [[NSUserDefaults standardUserDefaults]setObject:self.viewModel.loginName forKey:USER_REGISTER_MOBILE_KEY];
    
    [self.viewModel.cutdownCommond execute:@"1"];
    
    
}



#pragma mark - 键盘监听事件
- (void)keyboardDidShow:(NSNotification *)notification
{
  
    self.scrolleView.scrollEnabled = YES;
    if(IS_IPHONE_5 || IS_IPHONE_4_OR_LESS){
        [self.scrolleView setContentOffset:CGPointMake(0, 20.) animated:YES];
    }else{
//        [self.scrolleView setContentOffset:CGPointMake(0, 0.) animated:YES];
    }
    
    
    
    
    
    
}
- (void)keyboardDidHide:(NSNotification *)notification
{
    [self.scrolleView setContentOffset:CGPointMake(0, 0.) animated:YES];
    self.scrolleView.scrollEnabled = NO;
    
}


- (void)registerFunction:(id)sender{
    
    
    
    if (![SpecialRegexKit validateSpecialPassword: self.passWordTextfiled.textField.text]) {
        [WDProgressHUD showTips:@"密码长度必须为6-18位，请重新输入"];
        [self.passWordTextfiled.textField becomeFirstResponder];
        return;
    }
    [WDProgressHUD showInView:nil];
    [self submitPassword];
}


-(void)submitPassword
{
    [WDProgressHUD  showInView:nil];
    [self.viewModel.requestRegisterCommond execute:@1];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    if([HYCountDown shareHelper].registerTime >0 ){
        [self.codeTextfiled.sendCodeButton  removeAllAnimation];
        [self.codeTextfiled.sendCodeButton  loadingAnimation];
    }
    
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
