//
//  HYTransferMondeyVC.m
//  youbaner
//
//  Created by Joseph Koh on 2018/4/23.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYTransferMondeyVC.h"
#import "HYMoneyInfoView.h"
#import "HYTransferMoneyVM.h"

@interface HYTransferMondeyVC ()<UITextFieldDelegate>

@property (nonatomic, strong) HYTransferMoneyVM *viewModel;

@property (nonatomic, strong) HYMoneyInfoView *infoView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextField *inputView;
@property (nonatomic, strong) UIButton *actionBtn;
@property (nonatomic, strong) UIButton *submitBtn;

@end

@implementation HYTransferMondeyVC

+ (void)load {
    [self mapName:kModuleMoneyTransfer withParams:nil];
}

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialize];
    [self setupSubviews];
    [self setupSubviewsLayout];
    [self bind];
}


#pragma mark - Action

- (void)submitAction {
    double a = [_inputView.text doubleValue];
    if (_inputView.text.length == 0 || a == 0)
    {
      [WDProgressHUD showTips:@"请输入正确金额"];
          return;
    }
    
    if (a > [self.money doubleValue]) {
        [WDProgressHUD showTips:@"转入金额不能大于余额"];
        return;
    }
    self.viewModel.money = _inputView.text;
    [self.viewModel.transferCmd execute:nil];
}

- (void)transferAllAction {
    self.inputView.text = self.infoView.money;
}


#pragma mark - Bind

- (void)bind {
    @weakify(self);
    [[self.viewModel.transferCmd.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        @strongify(self);
        if ([x boolValue]) {
            [WDProgressHUD showInView:self.view];
        }
    }];
    
    [[[self.viewModel.transferCmd executionSignals] switchToLatest] subscribeNext:^(id  _Nullable x) {
        [WDProgressHUD hiddenHUD];
        
        @strongify(self);
        double f = [self.money doubleValue] - [self.viewModel.money doubleValue];
        self.infoView.money = [NSString stringWithFormat:@"%.2f", f];
    }];
    
    [self.viewModel.transferCmd.errors subscribeNext:^(NSError * _Nullable x) {
        [WDProgressHUD showTips:x.localizedDescription];
    }];
}


#pragma mark - Initialize

- (void)initialize {
    self.navigationItem.title = @"收益转入钱包";
    self.viewModel = [HYTransferMoneyVM new];
}


#pragma mark - Setup Subviews

- (void)setupSubviews {
    _infoView = [HYMoneyInfoView viewWithType:InfoViewTypeCenter andFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    _infoView.title = @"收益余额";
    _infoView.money = self.money;
    [self.view addSubview:_infoView];
    
    _label = [UILabel labelWithText:@"转入金额"
                          textColor:[UIColor blackColor]
                           fontSize:18
                             inView:self.view tapAction:NULL];
    _inputView = [UITextField textFieldWithText:@""
                                     textColor:[UIColor colorWithHexString:@"#313131"]
                                      fontSize:14
                                   placeHolder:@"请输入转入金额"
                              placeHolderColor:[UIColor colorWithHexString:@"#BCBCBC"]
                                   andDelegate:self
                                        inView:self.view];
    _inputView.keyboardType = UIKeyboardTypeNumberPad;
    _inputView.textAlignment = NSTextAlignmentRight;
    [_inputView becomeFirstResponder];
    
    @weakify(self);
    _actionBtn = [UIButton buttonWithTitle:@"全部金额"
                                titleColor:[UIColor colorWithHexString:@"#3DA8F5"]
                                  fontSize:14
                                   bgColor:nil
                                    inView:self.view
                                    action:^(UIButton *btn) {
                                        @strongify(self);
                                        [self transferAllAction];
                                    }];
    
    _submitBtn = [UIButton buttonWithTitle:@"确认转入钱包"
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
}

- (void)setupSubviewsLayout {
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.equalTo(_infoView.mas_bottom).offset(30);
    }];
    
    [_inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_label);
        make.right.offset(-15);
        make.width.mas_equalTo(200);
    }];
    
    UIView *line = [UIView viewWithBackgroundColor:[UIColor colorWithHexString:@"#FAFAFA"] inView:self.view];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(0.5);
        make.top.equalTo(_label.mas_bottom).offset(20);
    }];
    
    [_actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.top.equalTo(line.mas_bottom).offset(10);
    }];
    
    [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_actionBtn.mas_bottom).offset(40);
        make.left.offset(30);
        make.right.offset(-30);
        make.height.mas_equalTo(45);
    }];
}


#pragma mark - Lazy Loading

@end
