//
//  HYSelectSexViewController.m
//  youbaner
//
//  Created by luzhongchang on 17/8/3.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYSelectSexViewController.h"
#import "HYNavigationBar.h"
@interface HYSelectSexViewController ()

@property(nonatomic ,strong) UIImageView * manImageView;
@property(nonatomic ,strong) UIView      * manBgView;
@property(nonatomic ,strong) UILabel     * manLabel;
@property(nonatomic ,strong) UIImageView * femaleImageView;
@property(nonatomic ,strong) UIView      * femaleBgView;
@property(nonatomic ,strong) UILabel     * femaleLable;
@property(nonatomic ,strong) HYNavigationBar *b;
@property(nonatomic ,strong) UILabel * mtitleLabel;
@property(nonatomic ,assign) int gotController; //1 去注册 2 去逛一逛

@end

@implementation HYSelectSexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.b =[[HYNavigationBar alloc] initWithFrame:CGRectMake(0, SCREEN_STATUSBAR_HEIGHT -20, SCREEN_WIDTH, 64)];
    self.b.mtitleLabel.textColor=[UIColor blackColor];
    self.b.mtitleLabel.text=@"选择性别";
//    [self.b.rightBarButton setTitle:@"逛一逛" forState:UIControlStateNormal];
//    [self.b.rightBarButton setTitle:@"逛一逛" forState:UIControlStateHighlighted];
//    self.b.rightBarButton.hidden=YES;
    self.b.block=^{
        [super popBack];
    };
//    self.b.doNextblock=^()
//    {
//        [YSMediator pushViewControllerClassName:@"HYHomeViewController" withParams:@{@"source":@"1"} animated:YES callBack:nil];
//    };
    [self.view addSubview:self.b];
    
    
    
    [self setUpview];
    [self subviewLayout];
    
    // Do any additional setup after loading the view.
}
-(void)popBack
{
    [super  popBack];
}



- (void)setUpview
{
    self.mtitleLabel =[UILabel labelWithText:@"请问您的性别是？" textColor:[UIColor tc31Color] fontSize:20 inView:self.view tapAction:nil];
    
    
    self.manBgView =[UIView viewWithBackgroundColor:[UIColor clearColor] inView:self.view];
    self.manImageView =[UIImageView imageViewWithImageName:@"male_sel_normal" inView:self.view];
    self.manLabel = [UILabel labelWithText:@"男" textColor:[UIColor tc31Color] fontSize:18 inView:self.view tapAction:nil];
    
    
    self.femaleBgView =[UIView viewWithBackgroundColor:[UIColor clearColor] inView:self.view];
    self.femaleImageView =[UIImageView imageViewWithImageName:@"female_sel_normal" inView:self.view];
    self.femaleLable = [UILabel labelWithText:@"女" textColor:[UIColor tc31Color] fontSize:18 inView:self.view tapAction:nil];
    
    self.mtitleLabel.textAlignment=NSTextAlignmentCenter;
    self.manLabel.textAlignment = NSTextAlignmentCenter;
    self.femaleLable.textAlignment = NSTextAlignmentCenter;
    
    [self.manBgView.layer setMasksToBounds:YES];
    [self.manBgView.layer setCornerRadius:50];
    [self.femaleBgView.layer setMasksToBounds:YES];
    [self.femaleBgView.layer setCornerRadius:50];
    
    
    @weakify(self);
    UITapGestureRecognizer *tapman = [[UITapGestureRecognizer alloc] init];
    [self.manBgView addGestureRecognizer:tapman];
    [[tapman rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        
        @strongify(self);
//        [HYUserContext shareContext].defalutsex=1;
        [[NSUserDefaults  standardUserDefaults] setObject:@"1" forKey:USER_SEX_STATUES_KEY];
//        self.b.rightBarButton.hidden=YES;
        self.manImageView.image =[UIImage imageNamed:@"male_sel_selected"];
        self.femaleImageView.image =[UIImage imageNamed:@"female_sel_normal"];
        
        if(self.gotController==1)
        {
               [YSMediator pushToViewController:@"HYRegisterViewController" withParams:@{} animated:YES callBack:nil];
        }
        else
        {
            [YSMediator pushToViewController:@"HYHomeViewController" withParams:@{@"source":@"1",@"sex":@"男" } animated:YES callBack:nil];
        }
        
    }];
    
    UITapGestureRecognizer *tapfemale = [[UITapGestureRecognizer alloc] init];
    [self.femaleBgView addGestureRecognizer:tapfemale];
    [[tapfemale rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
         @strongify(self);
//        [HYUserContext shareContext].defalutsex=2;
         [[NSUserDefaults  standardUserDefaults] setObject:@"2" forKey:USER_SEX_STATUES_KEY];
        self.manImageView.image =[UIImage imageNamed:@"male_sel_normal"];
        self.femaleImageView.image =[UIImage imageNamed:@"female_sel_selected"];
        
        if(self.gotController==1)
        {
               [YSMediator pushToViewController:@"HYRegisterViewController" withParams:@{} animated:YES callBack:nil];
        }
        else
        {
            [YSMediator pushToViewController:@"HYHomeViewController" withParams:@{@"source":@"1",@"sex":@"女" } animated:YES callBack:nil];
        }
    }];
    
    
}


- (void)subviewLayout
{
    @weakify(self);
     [self.manLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         @strongify(self);
         make.left.equalTo(self.view.mas_left);
         make.right.equalTo(self.view.mas_right);
         make.bottom.equalTo(self.view.mas_centerY).offset(32);
         make.height.equalTo(@18);
     }];
    
    [self.manBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@100);
        make.height.equalTo(@100);
        make.bottom.equalTo(self.manLabel.mas_top).offset(-25);
        
    }];
    
    [self.manImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.equalTo(self.manBgView);
    }];
    
    
    [self.mtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@20);
        make.bottom.equalTo(self.manBgView.mas_top).offset(-55);
    }];
    
    
    
    [self.femaleBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@100);
        make.height.equalTo(@100);
        make.top.equalTo(self.view.mas_centerY).offset(65);
        
    }];
    
    [self.femaleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.equalTo(self.femaleBgView);
    }];
    
    [self.femaleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.femaleBgView.mas_bottom).offset(25);
        make.height.equalTo(@18);
    }];
    
   
    
   
    
    
    
    
    
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [self.navigationController setNavigationBarHidden:YES animated:YES];
}
-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
