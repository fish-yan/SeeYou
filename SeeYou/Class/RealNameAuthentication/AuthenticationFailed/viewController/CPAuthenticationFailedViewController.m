//
//  CPAuthenticationFailedViewController.m
//  CPPatient
//
//  Created by luzhongchang on 2017/8/31.
//  Copyright © 2017年 WondersGroup.com. All rights reserved.
//

#import "CPAuthenticationFailedViewController.h"
#import "CPInformationView.h"

#import "AuthenticationManager.h"
#import "RealNameAuthenticationViewController.h"

@interface CPAuthenticationFailedViewController ()



@property(nonatomic ,strong) UIScrollView *  mscroview;
@property(nonatomic ,strong) UIView * verticalContainerView;

@property(nonatomic ,strong) NSString * username;
@property(nonatomic ,strong) NSString * useridentify;
@property(nonatomic ,strong) NSString * reason;
//@property(nonatomic ,strong) NSString * type;//type==@"1" 认证成功 type==@“2” 认证失败
@property(nonatomic,strong) UIImageView * imageiconView;
@property(nonatomic ,strong) UILabel * labletitle ;
@property(nonatomic ,strong) UILabel * desLabel;

@property(nonatomic ,strong) UIView * reasonBg;
@property(nonatomic ,strong) UILabel * reasontitleLabel;
@property(nonatomic ,strong) UILabel *reasonLabel;
@property(nonatomic ,strong) CPInformationView * userNameView;
@property(nonatomic ,strong) CPInformationView * identifyView;

@property(nonatomic ,strong) UIButton * backButton;

@end

@implementation CPAuthenticationFailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"实名认证";
    [self setupSubviews];
    [self subviewslauout];
    // Do any additional setup after loading the view.
}


- (void)popBack {
    NSArray *list = [self.navigationController viewControllers];
    NSInteger backIndex = -1;
    for (int i=0; i<list.count; i++) {
        UIViewController *vc = list[i];
        if ([vc isKindOfClass:[CPAuthenticationFailedViewController class]]) {
            backIndex = i;
            break;
        }
    }
    if (backIndex>0) {
        [self.navigationController popToViewController:list[backIndex-1] animated:YES];
    }
    else {
        backIndex = -1;
        for (int i=0; i<list.count; i++) {
            UIViewController *vc = list[i];
            if ([vc isKindOfClass:[RealNameAuthenticationViewController class]]) {
                backIndex = i;
                break;
            }
        }
        if (backIndex>0) {
            [self.navigationController popToViewController:list[backIndex-1] animated:YES];
        }
        else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void) setupSubviews
{
    
    @weakify(self);
    
    
    self.mscroview =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.mscroview setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:self.mscroview];
    
    self.verticalContainerView =[UIView viewWithBackgroundColor:[UIColor clearColor] inView:self.mscroview];
    
    
    self.imageiconView = [UIImageView imageViewWithImageName:@"认证失败" inView:self.verticalContainerView];
    self.labletitle =[UILabel labelWithText:@"认证失败" textColor:[UIColor redColor] fontSize:18 inView:self.verticalContainerView tapAction:nil];
   
    self.desLabel =[UILabel labelWithText:@"您的实名认证未通过" textColor:[UIColor redColor] fontSize:12 inView:self.verticalContainerView tapAction:nil];
    self.desLabel.textAlignment = NSTextAlignmentCenter;
    self.desLabel.numberOfLines=0;
    
    
    self.reasonBg =[UIView viewWithBackgroundColor:[UIColor whiteColor] inView:self.verticalContainerView];
    
    self.reasontitleLabel = [UILabel labelWithText:@"未通过原因:" textColor:[UIColor redColor] fontSize:14 inView:self.reasonBg tapAction:nil];
    
    self.reasonLabel = [UILabel labelWithText:self.reason textColor:[UIColor redColor] fontSize:14 inView:self.reasonBg tapAction:nil];
    
    self.reasonLabel.numberOfLines=0;
    
    [self.reasonBg.layer setMasksToBounds:YES];
    [self.reasonBg.layer setCornerRadius:5];
    
    
    self.labletitle.textAlignment  = NSTextAlignmentCenter;
    self.userNameView = [CPInformationView new];
    self.userNameView.siginLabel.text=@"真实姓名";
    self.userNameView.contextflied.enabled=NO;
    self.userNameView.contextflied.text = self.username;
    [self.verticalContainerView addSubview:self.userNameView];
    self.identifyView = [CPInformationView new];
    self.identifyView.siginLabel.text=@"身份证号";
    self.identifyView.contextflied.enabled=NO;
    NSString * strinh = self.useridentify;
    self.identifyView.contextflied.text = strinh;
    [self.verticalContainerView addSubview:self.identifyView];
    
    UIView * line =[UIView viewWithBackgroundColor:[UIColor redColor] inView:self.identifyView];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.identifyView.mas_top);
        make.height.equalTo(@0.5);
    }];
    

    
    self.backButton =[UIButton buttonWithTitle:@"重新申请" titleColor:[UIColor whiteColor] fontSize:16 bgColor:[UIColor redColor]  inView:self.verticalContainerView action:^(UIButton *btn) {
//        @strongify(self);
//        [self.navigationController popToRootViewControllerAnimated:YES];
#pragma mark - James
        [YSMediator pushToViewController:@"RealNameAuthenticationViewController" withParams:nil animated:YES callBack:nil];
    }];
    [self.backButton.layer setMasksToBounds:YES];
    [self.backButton.layer setCornerRadius:5];
    

    
}

-(void) subviewslauout
{
    @weakify(self);
    
    [self.verticalContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.left.bottom.and.right.equalTo(self.mscroview).with.insets(UIEdgeInsetsZero);
        make.width.equalTo(self.mscroview);
    }];
    
    [self.imageiconView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.verticalContainerView.mas_top).offset(77);
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
    
    [self.reasonBg mas_makeConstraints:^(MASConstraintMaker *make) {
         @strongify(self);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.top.equalTo(self.desLabel.mas_bottom).offset(75);
    }];
    
    [self.reasontitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.reasonBg.mas_left).offset(20);
        make.top.equalTo(self.reasonBg.mas_top).offset(20);
        make.width.equalTo(@84);
        make.height.equalTo(@16);
    }];
    
    [self.reasonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.reasontitleLabel.mas_right).offset(5);
        make.right.equalTo(self.reasonBg.mas_right).offset(-15);
        make.top.equalTo(self.reasontitleLabel.mas_top);
        make.bottom.equalTo(self.reasonBg.mas_bottom).offset(-20);
    }];
    
    
    
    
    [self.userNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@44);
        make.top.equalTo(self.reasonBg.mas_bottom).offset(25);
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
        make.bottom.equalTo(self.identifyView.mas_bottom).offset(68);
    }];
    
    
    [self. verticalContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backButton.mas_bottom).offset(80);
    }];
    
    
    
    
}

@end
