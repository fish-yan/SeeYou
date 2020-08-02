//
//  CPAuthenticationSuccessController.m
//  CPPatient
//
//  Created by luzhongchang on 2017/8/31.
//  Copyright © 2017年 WondersGroup.com. All rights reserved.
//

#import "CPAuthenticationSuccessController.h"
#import "CPInformationView.h"


@interface CPAuthenticationSuccessController ()

@property(nonatomic ,strong) NSString * username;
@property(nonatomic ,strong) NSString * useridentify;
//@property(nonatomic ,strong) NSString * type;//type==@"1" 认证成功 type==@“2” 认证失败
@property(nonatomic,strong) UIImageView * imageiconView;
@property(nonatomic ,strong) UILabel * labletitle ;
@property(nonatomic ,strong) UILabel * desLabel;
@property(nonatomic ,strong) CPInformationView * userNameView;
@property(nonatomic ,strong) CPInformationView * identifyView;


@property(nonatomic ,strong) UIButton * backButton;

@end

@implementation CPAuthenticationSuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"实名认证";
    [self setupSubviews];
    [self subviewslauout];
    // Do any additional setup after loading the view.
}


- (void)popBack
{
    [super popBack];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) setupSubviews
{
    
    @weakify(self);
    self.imageiconView = [UIImageView imageViewWithImageName:@"" inView:self.view];
    self.labletitle =[UILabel labelWithText:@"成功" textColor:[UIColor redColor] fontSize:18 inView:self.view tapAction:nil];
    self.labletitle.textAlignment  = NSTextAlignmentCenter;
    self.userNameView = [CPInformationView new];
    self.userNameView.siginLabel.text=@"真实姓名";
    self.userNameView.contextflied.enabled=NO;
    self.userNameView.contextflied.text = self.username;
    [self.view addSubview:self.userNameView];
    self.identifyView = [CPInformationView new];
    self.identifyView.siginLabel.text=@"身份证号";
    self.identifyView.contextflied.enabled=NO;
    NSString * strinh = self.useridentify;
    self.identifyView.contextflied.text = strinh;
    [self.view addSubview:self.identifyView];
    
    UIView * line =[UIView viewWithBackgroundColor:[UIColor redColor] inView:self.identifyView];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.identifyView.mas_top);
        make.height.equalTo(@0.5);
    }];
    
    self.desLabel =[UILabel labelWithText:@"您已成功提交实名认证申请，请耐心等待审核" textColor:[UIColor redColor] fontSize:12 inView:self.view tapAction:nil];
    self.desLabel.textAlignment = NSTextAlignmentCenter;
    self.desLabel.numberOfLines=0;
    
    self.backButton =[UIButton buttonWithTitle:@"返回" titleColor:[UIColor whiteColor] fontSize:16 bgColor:[UIColor redColor]  inView:self.view action:^(UIButton *btn) {
        @strongify(self);
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [self.backButton.layer setMasksToBounds:YES];
    [self.backButton.layer setCornerRadius:5];
    
//    if([self.type isEqualToString:@"1"])
//    {
        self.imageiconView.image =[UIImage imageNamed:@"认证成功"];
        self.labletitle.text=@"认证成功";
        self.desLabel.text=@"您的实名认证已通过";
        
//    }
//    else
//    {
//        
//        self.imageiconView.image =[UIImage imageNamed:@"认证失败"];
//        self.labletitle.text=@"认证成功";
//        self.desLabel.text=@"您的实名认证已通过";
//    }
    
    
}

-(void) subviewslauout
{
    @weakify(self);
    
    
    [self.imageiconView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.view.mas_top).offset(77);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(122, 85));
    }];
    
    [self.labletitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@16);
        make.top.equalTo(self.imageiconView.mas_bottom).offset(9);
    }];
    
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         @strongify(self);
        make.left.equalTo(self.view.mas_left).offset(25);
        make.right.equalTo(self.view.mas_right).offset(-25);
        make.top.equalTo(self.labletitle.mas_bottom).offset(10);
    }];
    
    [self.userNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@44);
        make.top.equalTo(self.desLabel.mas_bottom).offset(82.5);
    }];
    
    [self.identifyView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@44);
        make.top.equalTo(self.userNameView.mas_bottom);
    }];
    
 
    
    [self. backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.equalTo(@44);
        make.bottom.equalTo(self.view.mas_bottom).offset(-15);
    }];
    
    
    
    
}



@end
