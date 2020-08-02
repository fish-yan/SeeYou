//
//  HYLoginViewController.m
//  youbaner
//
//  Created by luzhongchang on 17/7/30.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYLoginViewController.h"



@interface HYLoginViewController ()
@property(nonatomic ,strong) UIImageView * bgImageview;
@property(nonatomic ,strong) UILabel  * mainTitleLable;
@property(nonatomic ,strong) UILabel * subtitleLable;
@property(nonatomic ,strong) UIButton * registerButton;
@property(nonatomic ,strong) UIButton * loginButton;
@property(nonatomic ,strong) UIButton * letgoButton;

@end

@implementation HYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpview];
    [self subviewLayout];
    // Do any additional setup after loading the view.
}

-(void)setUpview
{
    
    self.bgImageview =[UIImageView imageViewWithImageName:@"loginBg" inView:self.view];
    self.bgImageview.backgroundColor =[UIColor greenColor];
    
    self.mainTitleLable =[UILabel labelWithText:@"花缘" textColor:[UIColor whiteColor] fontSize:60 inView:self.view tapAction:nil];
    
    self.subtitleLable =[UILabel labelWithText:@"愿君多采撷，此物最相思" textColor:[UIColor whiteColor] fontSize:20 inView:self.view tapAction:nil];
    
    
    self.registerButton =[UIButton buttonWithTitle:@"注册" titleColor:[UIColor tc31Color] fontSize:14 bgColor:[UIColor bt1Color] inView:self.view action:^(UIButton *btn) {
        
        if([HYUserContext shareContext].defalutsex ==0)
            [YSMediator pushToViewController:@"HYSelectSexViewController" withParams:@{@"gotController":@1 } animated:YES callBack:nil];
        else
            [YSMediator pushToViewController:@"HYRegisterViewController" withParams:@{} animated:YES callBack:nil];
    }];
    
    self.loginButton =[UIButton buttonWithTitle:@"登录" titleColor:[UIColor whiteColor] fontSize:14 bgColor:[UIColor bt0Color] inView:self.view action:^(UIButton *btn) {
       
         [YSMediator pushToViewController:@"HYLoginViewSubViewController" withParams:@{} animated:YES callBack:nil];
    }];
    
    
    self.letgoButton =[UIButton buttonWithTitle:@"偷看一下" titleColor:[UIColor whiteColor] fontSize:16 bgColor:[UIColor clearColor] inView:self.view action:^(UIButton *btn) {
        
//        if([HYUserContext shareContext].defalutsex ==0)
             [YSMediator pushToViewController:@"HYSelectSexViewController" withParams:@{} animated:YES callBack:nil];
//        else
//            [YSMediator pushViewControllerClassName:@"HYHomeViewController" withParams:@{@"source":@"1"} animated:YES callBack:nil];
    }];
    [self.letgoButton.layer setMasksToBounds:YES];
    [self.letgoButton.layer setBorderWidth:1.0];
    [self.letgoButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.letgoButton.layer setCornerRadius:5];
    
}


-(void)subviewLayout
{
    @weakify(self);
    [self.bgImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.equalTo(self.view);
    }];
    
    [self.mainTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.view.mas_top).offset(150);
        make.height.equalTo(@60);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [self.subtitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.mainTitleLable.mas_bottom).offset(26);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.equalTo(@20);
    }];
    
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_centerX);
        make.height.equalTo(@50);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_centerX);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@50);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    [self.letgoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.equalTo(@50);
        make.bottom.equalTo(self.loginButton.mas_top).offset(-40);
        
    }];
}



-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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
