//
//  HYSetPasswordVC.m
//  youbaner
//
//  Created by Joseph Koh on 2018/4/18.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYSetPasswordVC.h"
#import "HYLoginRegisterVM.h"

@interface HYSetPasswordVC ()

@property (nonatomic, strong) HYLoginRegisterVM *viewModel;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *infoLabel1;
@property (nonatomic, strong) UITextField *tf1;
@property (nonatomic, strong) UIButton *switchModeBtn1;

@property (nonatomic, strong) UILabel *infoLabel2;
@property (nonatomic, strong) UITextField *tf2;
@property (nonatomic, strong) UIButton *switchModeBtn2;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation HYSetPasswordVC

+ (void)load {
    [self mapName:kModuleSetPwd withParams:nil];
}

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialize];
    [self setupSubviews];
    [self bind];
    
    [self addGesture];
}



- (void)addGesture {
    UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
    [self.view addGestureRecognizer:tap];
    
    [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        [self closeKeyboard];
    }];
}

#pragma mark - Action

- (void)closeKeyboard {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

#pragma mark - Bind

- (void)bind {
 
}


#pragma mark - Initialize

- (void)initialize {
    
}


#pragma mark - Setup Subviews

- (void)setupSubviews {
    _titleLabel = [UILabel labelWithText:@"设置密码"
                               textColor:[UIColor whiteColor]
                                fontSize:30
                                  inView:self.view
                               tapAction:NULL];
    CGFloat padding = 30;
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(padding);
        make.top.offset(80);
    }];
    
    _infoLabel1 = [UILabel labelWithText:@"请设置密码 (6-15位数字或字母)"
                              textColor:[UIColor whiteColor]
                               fontSize:15
                                 inView:self.view
                              tapAction:NULL];

    [_infoLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel);
        make.top.equalTo(_titleLabel.mas_bottom).offset(30);
    }];
    
    _tf1 = [UITextField new];
    _tf1.font = [UIFont boldSystemFontOfSize:20];
    _tf1.textColor = [UIColor whiteColor];
    _tf1.secureTextEntry = YES;
    [self.view addSubview:_tf1];
    [_tf1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(padding);
        make.right.offset(-padding);
        make.top.equalTo(_infoLabel1.mas_bottom);//.offset(25);
        make.height.mas_equalTo(50);
    }];

    @weakify(self);
    _switchModeBtn1 = [UIButton buttonWithNormalImgName:@"ic_login_eye"
                                                bgColor:nil
                                                 inView:self.view
                                                 action:^(UIButton *btn) {
                                                     @strongify(self);
                                                     self.tf1.secureTextEntry = !self.tf1.secureTextEntry;
                                                 }];
    [_switchModeBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_tf1);
        make.right.offset(-padding);
    }];
    
    UIView *line1 = [UIView viewWithBackgroundColor:[UIColor whiteColor] inView:self.view];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(padding);
        make.right.offset(-padding);
        make.top.equalTo(_tf1.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    //
    _infoLabel2 = [UILabel labelWithText:@"请确认密码"
                               textColor:[UIColor whiteColor]
                                fontSize:15
                                  inView:self.view
                               tapAction:NULL];
    
    [_infoLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(padding);
        make.top.equalTo(line1.mas_bottom).offset(40);
    }];
    
    _tf2 = [UITextField new];
    _tf2.font = [UIFont boldSystemFontOfSize:20];
    _tf2.textColor = [UIColor whiteColor];
    [self.view addSubview:_tf2];
    [_tf2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(padding);
        make.right.offset(-padding);
        make.top.equalTo(_infoLabel2.mas_bottom);//.offset(25);
        make.height.mas_equalTo(50);
    }];
    
    _switchModeBtn2 = [UIButton buttonWithNormalImgName:@"ic_login_eye"
                                                bgColor:nil
                                                 inView:self.view
                                                 action:^(UIButton *btn) {
                                                     @strongify(self);
                                                     self.tf2.secureTextEntry = !self.tf2.secureTextEntry;
                                                 }];
    [_switchModeBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_tf2);
        make.right.offset(-padding);
    }];
    
    UIView *line2 = [UIView viewWithBackgroundColor:[UIColor whiteColor] inView:self.view];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(padding);
        make.right.offset(-padding);
        make.top.equalTo(_tf2.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    //
    _nextBtn = [UIButton buttonWithTitle:@"下一步"
                              titleColor:[UIColor redColor]
                                fontSize:18
                                 bgColor:[UIColor whiteColor]
                                  inView:self.view
                                  action:^(UIButton *btn) {
                                      @strongify(self);
                                      [self closeKeyboard];
                                      [YSMediator pushToViewController:kModuleCompleteInfoGender
                                                            withParams:nil
                                                              animated:YES
                                                              callBack:NULL];
                                  }];
    _nextBtn.clipsToBounds = YES;
    _nextBtn.layer.cornerRadius = 45 * 0.5;
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom).offset(60);
        make.left.offset(padding);
        make.right.offset(-padding);
        make.height.mas_equalTo(45);
    }];
}




#pragma mark - Lazy Loading

@end
