//
//  HYWithdarwMoneyVC.m
//  youbaner
//
//  Created by Joseph Koh on 2018/4/23.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYWithdarwMoneyVC.h"
#import "HYMoneyInfoView.h"

@interface HYWithdarwMoneyVC ()<UITextFieldDelegate>

@property (nonatomic, strong) HYMoneyInfoView *infoView;
@property (nonatomic, strong) UILabel *tipsLabel;
@property (nonatomic, strong) UIButton *submitBtn;

@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UITextField *inputView;
@property (nonatomic, strong) UILabel *alipayLabel;
@property (nonatomic, strong) UITextField *alipayInputV;

@property (nonatomic, assign) BOOL hasAuth;

@end

@implementation HYWithdarwMoneyVC

+ (void)load {
    [self mapName:kModuleMoneyWithdarw withParams:nil];
}

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialize];
    [self setupSubviews];
    [self setupSubviewsLayout];
    [self bind];
    self.hasAuth = YES;
}


#pragma mark - Action

- (void)submitAction {
    
    [WDProgressHUD showTips:@"暂无可提现 收益" ];
    return;
    
    if (self.hasAuth) {
        NSLog(@"确认提现");
    }
    else {
        NSLog(@"授权");
    }
}

#pragma mark - Bind

- (void)bind {
    @weakify(self);
    [RACObserve(self, hasAuth) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        BOOL b = [x boolValue];
        self.moneyLabel.hidden = !b;
        self.inputView.hidden = !b;
        self.alipayLabel.hidden = !b;
        self.alipayInputV.hidden = !b;
        self.tipsLabel.hidden = b;
    }];
}


#pragma mark - Initialize

- (void)initialize {
    self.navigationItem.title = @"提现";
}


#pragma mark - Setup Subviews

- (void)setupSubviews {
    _infoView = [HYMoneyInfoView viewWithType:InfoViewTypeCenter
                                     andFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    _infoView.title = @"收益余额";
    _infoView.money = self.money;
    [self.view addSubview:_infoView];
    
    
    _tipsLabel = [UILabel labelWithText:@"提现前请先进行支付宝授权，授权后，提现金额实时到你授权的支付宝账户"
                              textColor:[UIColor grayColor]
                               fontSize:13
                                 inView:self.view
                              tapAction:NULL];
    _tipsLabel.numberOfLines = 0;
    _tipsLabel.hidden = YES;
    
    @weakify(self);
    _submitBtn = [UIButton buttonWithTitle: self.hasAuth ? @"确认提现" : @"支付宝授权"
                                titleColor:[UIColor whiteColor]
                                  fontSize:16
                                   bgColor:nil
                                    inView:self.view
                                    action:^(UIButton *btn) {
                                        @strongify(self);
                                        [self submitAction];
                                    }];
    _submitBtn.clipsToBounds = YES;
    _submitBtn.layer.cornerRadius = 45 * 0.5;
    [_submitBtn setBackgroundImage:[UIImage gradientImageOfSize:CGSizeMake(315, 45)] forState:UIControlStateNormal];
    
    // 已经授权
    _moneyLabel = [UILabel labelWithText:@"提现金额"
                          textColor:[UIColor colorWithHexString:@"#4A4A4A"]
                           fontSize:18
                             inView:self.view tapAction:NULL];
    _moneyLabel.hidden = YES;
    
    _inputView = [UITextField textFieldWithText:nil
                                      textColor:[UIColor colorWithHexString:@"#313131"]
                                       fontSize:16
                                    placeHolder:@"请输入提现金额"
                               placeHolderColor:[UIColor colorWithHexString:@"#BCBCBC"]
                                    andDelegate:self
                                         inView:self.view];
    _inputView.hidden = YES;
    _inputView.keyboardType = UIKeyboardTypeNumberPad;
    _inputView.textAlignment = NSTextAlignmentRight;
    [_inputView becomeFirstResponder];
    
    
    _alipayLabel = [UILabel labelWithText:@"支付宝账号"
                               textColor:[UIColor colorWithHexString:@"#4A4A4A"]
                                fontSize:18
                                  inView:self.view tapAction:NULL];
    _alipayLabel.hidden = YES;
    _alipayInputV = [UITextField textFieldWithText:nil
                                      textColor:[UIColor colorWithHexString:@"#313131"]
                                       fontSize:16
                                    placeHolder:@"请输入支付宝账号"
                               placeHolderColor:[UIColor colorWithHexString:@"#BCBCBC"]
                                    andDelegate:self
                                         inView:self.view];
    _alipayInputV.hidden = YES;
    _alipayInputV.textAlignment = NSTextAlignmentRight;

    
}

- (UIView *)line {
    UIView *line = [UIView viewWithBackgroundColor:[UIColor colorWithHexString:@"#FAFAFA"] inView:self.view];
    return line;
}

- (void)setupSubviewsLayout {
    [_tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.top.equalTo(_infoView.mas_bottom).offset(20);
    }];
    
    [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tipsLabel.mas_bottom).offset(100);
        make.left.offset(30);
        make.right.offset(-30);
        make.height.mas_equalTo(45);
    }];
    
    //
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.equalTo(_infoView.mas_bottom).offset(30);
    }];
    
    [_inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_moneyLabel);
        make.right.offset(-15);
        make.width.mas_equalTo(200);
    }];
    
    UIView *line1 = [self line];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.height.mas_equalTo(0.5);
        make.top.equalTo(_moneyLabel.mas_bottom).offset(15);
    }];
    
    //
    
    [_alipayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.equalTo(line1.mas_bottom).offset(15);
    }];
    
    [_alipayInputV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_alipayLabel);
        make.right.width.equalTo(_inputView);
    }];
    
    
    UIView *line2 = [self line];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.height.mas_equalTo(0.5);
        make.top.equalTo(_alipayLabel.mas_bottom).offset(15);
    }];
}

@end
