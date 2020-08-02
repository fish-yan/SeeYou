//
//  CommitVerfifyViewController.m
//  youbaner
//
//  Created by luzhongchang on 17/7/31.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "CommitVerfifyViewController.h"
#import "HYNavigationBar.h"
#import "CommitCerifyView.h"
#import "COmmitVerfifyViewModel.h"
@interface CommitVerfifyViewController ()
@property(nonatomic ,strong) COmmitVerfifyViewModel * viewModel;
@end

@implementation CommitVerfifyViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIImageView * v =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    v.image=[UIImage imageNamed:@"verficodeBg"];
    [self.view addSubview:v];
    
    
    self.viewModel =[[COmmitVerfifyViewModel alloc] init];
  
    
    CommitCerifyView * view = [[CommitCerifyView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:view];
    
    RAC(view,price) =RACObserve(self.viewModel, price);
    RAC(view,numberPeople) = RACObserve(self.viewModel, peopleNumber);
    RAC(view,orderID)  = RACObserve(self.viewModel, orderID);
    RAC(view,discount)  = RACObserve(self.viewModel, discount);
    RAC(view,productprice2)  = RACObserve(self.viewModel, productprice2);
    RAC(view,originalprice)  = RACObserve(self.viewModel, originalprice);

    
    @weakify(self);
    HYNavigationBar *b =[[HYNavigationBar alloc] initWithFrame:CGRectMake(0, SCREEN_STATUSBAR_HEIGHT -20, SCREEN_WIDTH, 64)];
    [b.leftBarButton setImage:[UIImage imageNamed:@"whiteBack"] forState:UIControlStateNormal];
    b.mtitleLabel.text=@"提交认证申请";
    b.block=^{
        @strongify(self);
        
        [self showAlert];
        
    };
    [self.view addSubview:b];
    
    [self bindModel];
    [WDProgressHUD showInView:nil];
    [self.viewModel.doRaccommand execute:@"1"];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void) bindModel
{
    @weakify(self);
    
    [[self.viewModel.doRaccommand.executionSignals switchToLatest]subscribeNext:^(id  _Nullable x) {
        [WDProgressHUD hiddenHUD];
        
    }];
    
    [self.viewModel.doRaccommand.errors subscribeNext:^(NSError * _Nullable x) {
        [WDProgressHUD hiddenHUD];
        @strongify(self);
        self.viewModel.price=@"29.90";
        self.viewModel.peopleNumber=@"*********";
        self.viewModel.orderID=@"";
    }];
}

-(void)showAlert
{

    
    
    id cancelBlock=^()
    {
        NSLog(@"1231");
        [super popBack];
    };
    id sureBlock=^()
    {
          [YSMediator pushToViewController:@"HYPayViewController" withParams:@{@"price":self.viewModel.price} animated:YES callBack:nil];
    };
    
    
    [YSMediator presentToViewController:@"HYAlertViewController"  withParams:@{@"message":@"提交身份认证才能遇见同样身份认证的Ta",
                                                                                      @"type":@2,
                                                                                      @"rightButtonTitle":@"继续提交",
                                                                                      @"leftButtonTitle":@"狠心离开",
                                                                                      @"rightTitleColor":[UIColor tcff8bb1Color],
                                                                                      @"cancelBlock":cancelBlock,
                                                                                      @"sureBlock":sureBlock
                                                                                      } animated:YES callBack:nil];
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
