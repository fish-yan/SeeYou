//
//  AuthenticationIngCommitSuccessViewController.m
//  CPPatient
//
//  Created by luzhongchang on 2017/8/31.
//  Copyright © 2017年 Jam. All rights reserved.
//

#import "AuthenticationIngCommitSuccessViewController.h"
#import "CPInformationView.h"

#import "CPAuthenticationFailedViewController.h"
#import "RealNameAuthenticationViewController.h"

@interface AuthenticationIngCommitSuccessViewController ()

@property(nonatomic ,strong) NSString * username;
@property(nonatomic ,strong) NSString * useridentify;
@property(nonatomic ,strong) NSString * type;//type==@"1" 提交成功页面 type==@“2” 审核中页面 type==@“3” 审核成功页面
@property(nonatomic,strong) UIImageView * imageiconView;
@property(nonatomic ,strong) UILabel * labletitle ;
@property(nonatomic ,strong) UILabel * labledesc;
@property(nonatomic ,strong) CPInformationView * userNameView;
@property(nonatomic ,strong) CPInformationView * identifyView;
@property(nonatomic ,strong) UILabel * tipLabel;
@property(nonatomic ,strong) UILabel * desLabel;

@property(nonatomic ,strong) UIButton * backButton;

@end

@implementation AuthenticationIngCommitSuccessViewController

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
    
    
    self.tipLabel =[UILabel labelWithText:@"温馨提示" textColor:[UIColor redColor] fontSize:14 inView:self.view tapAction:nil];
    self.tipLabel.textAlignment=NSTextAlignmentLeft;
    self.desLabel =[UILabel labelWithText:@"您已成功提交实名认证申请，请耐心等待审核" textColor:[UIColor redColor] fontSize:12 inView:self.view tapAction:nil];
    self.desLabel.numberOfLines=0;

    self.backButton =[UIButton buttonWithTitle:@"返回" titleColor:[UIColor whiteColor] fontSize:16 bgColor:[UIColor redColor]  inView:self.view action:^(UIButton *btn) {
        @strongify(self);
        [self popBack];
    }];
    [self.backButton.layer setMasksToBounds:YES];
    [self.backButton.layer setCornerRadius:5];
    
    if ([self.type isEqualToString:@"1"])
    {
        self.imageiconView.image =[UIImage imageNamed:@"成功"];
        self.labletitle.text=@"提交成功";
        
    }
    else if ([self.type isEqualToString:@"2"])
    {
    
        self.imageiconView.image =[UIImage imageNamed:@"审核中"];
        self.labletitle.text=@"审核中";
    }
    else {
        self.imageiconView.image =[UIImage imageNamed:@"认证成功"];
        self.labletitle.text=@"认证成功";
        self.labledesc = [UILabel labelWithText:@"您的实名认证已通过"
                                      textColor:[UIColor redColor]
                                       fontSize:14 inView:self.view tapAction:nil];
        self.labledesc.textAlignment  = NSTextAlignmentCenter;

        self.tipLabel.hidden = YES;
        self.desLabel.hidden = YES;
    }
    
}

-(void) subviewslauout
{
    @weakify(self);
    
    CGSize size = [self.type isEqualToString:@"3"] ? CGSizeMake(122, 84.5) : CGSizeMake(91, 91);
    [self.imageiconView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.view.mas_top).offset(58);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(size);
    }];
    
    CGFloat offset = [self.type isEqualToString:@"3"] ? 9 : 15;
    [self.labletitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.equalTo(@16);
        make.top.equalTo(self.imageiconView.mas_bottom).offset(offset);
    }];
    
    if (self.labledesc) {
        [self.labledesc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(15);
            make.right.equalTo(self.view.mas_right).offset(-15);
            make.height.equalTo(@16);
            make.top.equalTo(self.labletitle.mas_bottom).offset(10);
        }];
        
        [self.userNameView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.height.equalTo(@44);
            make.top.equalTo(self.labledesc.mas_bottom).offset(82);
        }];
    }
    else {
        [self.userNameView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.height.equalTo(@44);
            make.top.equalTo(self.labletitle.mas_bottom).offset(63);
        }];
    }
    
    [self.identifyView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@44);
        make.top.equalTo(self.userNameView.mas_bottom);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left).offset(25);
        make.right.equalTo(self.view.mas_right).offset(-25);
        make.top.equalTo(self.identifyView.mas_bottom).offset(10);
        make.height.equalTo(@14);
    }];
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(25);
        make.right.equalTo(self.view.mas_right).offset(-25);
        make.top.equalTo(self.tipLabel.mas_bottom).offset(8);
    }];
    
    [self. backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.equalTo(@44);
        make.bottom.equalTo(self.view.mas_bottom).offset(-15);
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
