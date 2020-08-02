//
//  HYPayViewController.m
//  youbaner
//
//  Created by luzhongchang on 17/8/7.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYPayViewController.h"
#import "HYPayViewModel.h"
#import "PayInstance.h"

@interface HYPayViewController ()


@property (nonatomic ,strong) UIView * parttopBg;
@property (nonatomic ,strong) UILabel * titleLabel;
@property (nonatomic ,strong) UILabel * priceLabel;

@property (nonatomic ,strong) UIView * part1topBg;
@property (nonatomic ,strong) UIImageView * aliPayicon;
@property (nonatomic ,strong) UILabel     * alipayLabel;
@property (nonatomic ,strong) UIImageView * aliSelectedImageview;
@property (nonatomic ,strong) UIView *lineView;
@property (nonatomic ,strong) UIImageView * wechatPayicon;
@property (nonatomic ,strong) UILabel     * wechatLabel;
@property (nonatomic ,strong) UIImageView * wechatSelectedImageview;

@property (nonatomic ,strong) UIButton * alipayButton;
@property (nonatomic ,strong) UIButton * wechatButton;

@property (nonatomic ,strong) UIButton * payButton;
@property (nonatomic ,assign) int type; //1 是支付宝 2 微信

@property(nonatomic ,strong) NSString * price;
@property(nonatomic ,strong) NSString * orderId;

@property(nonatomic ,strong) HYPayViewModel * viewModel;

@end

@implementation HYPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor bgf5f5f5Color];
    self.canBack=YES;
    self.navigationItem.title=@"在线支付";
    self.type=1;
    [self setUpview];
    [self subviewLayout];
    self.viewModel = [HYPayViewModel new];
    [self bindModel];
    // Do any additional setup after loading the view.
}

-(void)setUpview
{
    self.parttopBg =[UIView viewWithBackgroundColor:[UIColor whiteColor] inView:self.view];
    
    self.titleLabel =[UILabel labelWithText:@"会员认证费用" textColor:[UIColor tc31Color] fontSize:15 inView:self.parttopBg tapAction:nil];
    self.priceLabel =[UILabel labelWithText:[NSString stringWithFormat:@"%@元",self.price] textColor:[UIColor tc31Color] fontSize:45 inView:self.parttopBg tapAction:nil];
    NSMutableAttributedString *richText = [[NSMutableAttributedString alloc] initWithString:self.priceLabel.text];
    
    
    [richText addAttribute:NSFontAttributeName value:Font_PINGFANG_SC(20) range:NSMakeRange(self.priceLabel.text.length-1 , 1)];//设置字体大小
    self.priceLabel.attributedText = richText;
    
    self.titleLabel.textAlignment= NSTextAlignmentCenter;
    self.priceLabel.textAlignment = NSTextAlignmentCenter;
    
    self.part1topBg =[UIView viewWithBackgroundColor:[UIColor whiteColor] inView:self.view];
    self.aliPayicon =[UIImageView imageViewWithImageName:@"aliicon" inView:self.part1topBg];
    self.alipayLabel =[UILabel labelWithText:@"支付宝支付" textColor:[UIColor tc31Color] fontSize:16 inView:self.part1topBg tapAction:nil];
    self.alipayLabel.textAlignment = NSTextAlignmentLeft;
    self.aliSelectedImageview =[UIImageView imageViewWithImageName:@"payseled" inView:self.part1topBg];
    self.lineView =[UIView viewWithBackgroundColor:[UIColor line0Color] inView:self.part1topBg];
    self.wechatPayicon =[UIImageView imageViewWithImageName:@"wechaticon" inView:self.part1topBg];
    self.wechatLabel =[UILabel labelWithText:@"微信支付" textColor:[UIColor tc31Color] fontSize:16 inView:self.part1topBg tapAction:nil];
    self.wechatLabel.textAlignment = NSTextAlignmentLeft;
    self.wechatSelectedImageview =[UIImageView imageViewWithImageName:@"payseled" inView:self.part1topBg];

    @weakify(self);
    self.payButton =[UIButton buttonWithTitle:@"确认支付" titleColor:[UIColor whiteColor] fontSize:14 bgColor:[UIColor bgff8bb1Color] inView:self.view action:^(UIButton *btn) {
        @strongify(self);
        
        
        if(self.type==1)
        {
            [WDProgressHUD showInView:self.view];
            [self.viewModel.doCommand execute:@"1"];
            
        }
        else
        {
            [WDProgressHUD showInView:self.view];
            [self.viewModel.doWechatCommand execute:@"1"];
        }
        
    }];
    [self.payButton.layer setMasksToBounds:YES];
    [self.payButton.layer setCornerRadius:2];
    
    
    self.alipayButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [self.part1topBg addSubview:self.alipayButton];
    
    [self.alipayButton addTarget:self action:@selector(choicePayType:) forControlEvents:UIControlEventTouchUpInside];

    self.wechatButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [self.part1topBg addSubview:self.wechatButton];
    [self.wechatButton addTarget:self action:@selector(choicePayType:) forControlEvents:UIControlEventTouchUpInside];
    
    self.aliSelectedImageview.alpha=1;
    self.wechatSelectedImageview.alpha=0;
}


-(void) bindModel
{
    @weakify(self);
    [RACObserve(self, type) subscribeNext:^(NSNumber *  _Nullable x) {
        @strongify(self);
        if([x intValue]==0)
        {
            self.payButton.alpha=0.5;
            self.payButton.enabled=NO;
        }
        else
        {
            self.payButton.alpha=1.0;
            self.payButton.enabled=YES;
        }
    }];
    
    
    [[self.viewModel.doCommand.executionSignals switchToLatest] subscribeNext:^(WDResponseModel *  _Nullable x) {
        
       [WDProgressHUD hiddenHUD];
        PayInstance *s =[PayInstance sharedInstance];
        s.block=^(int status){
           
        };
        [s doPay:x.data];
        
       
        
    }];
    [self.viewModel.doCommand.errors subscribeNext:^(NSError * _Nullable x) {
       
         [WDProgressHUD hiddenHUD];
        [WDProgressHUD showTips:x.localizedDescription];
    }];
    
    
    [[self.viewModel.doWechatCommand.executionSignals switchToLatest] subscribeNext:^(WDResponseModel *  _Nullable x) {
        [WDProgressHUD hiddenHUD];
        PayInstance *s =[PayInstance sharedInstance];
        s.block=^(int status){
            
        };
        [s doWechatPay:x.data];
        
      
        
    }];
    [self.viewModel.doWechatCommand.errors subscribeNext:^(NSError * _Nullable x) {
        
        [WDProgressHUD hiddenHUD];
        [WDProgressHUD showTips:x.localizedDescription];
    }];
    
    
    
    
    
}

-(void) choicePayType:(UIButton *)sender
{
    if(sender == self.alipayButton)
    {
        self.aliSelectedImageview.alpha=1;
        self.wechatSelectedImageview.alpha=0;
        self.type=1;
    }
    else
    {
        self.aliSelectedImageview.alpha=0;
        self.wechatSelectedImageview.alpha=1;
        self.type=2;
    }
    

}


-(void)subviewLayout
{
    @weakify(self);
    [self.parttopBg mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.height.equalTo(@170);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.parttopBg.mas_top).offset(40);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.equalTo(@15);
        
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(24);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.equalTo(@45);
    }];
    
    [self.part1topBg mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.parttopBg.mas_bottom).offset(10);
        make.height.equalTo(@121.0);
        
    }];
    
    [self.aliPayicon mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left).offset(14);
        make.top.equalTo(self.part1topBg.mas_top).offset(18);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    
    [self.alipayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.aliPayicon.mas_right).offset(10);
        make.centerY.equalTo(self.aliPayicon.mas_centerY);
        make.height.equalTo(@15);
        make.width.equalTo(@150);
        
    }];
    [self.aliSelectedImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.equalTo(self.view.mas_right).offset(-14);
        make.centerY.equalTo(self.aliPayicon.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left).offset(14);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@0.5);
        make.bottom.equalTo(self.part1topBg.mas_top).offset(60);
    }];
    
    
    [self.wechatPayicon mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left).offset(14);
        make.top.equalTo(self.lineView.mas_top).offset(18);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    
    [self.wechatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.wechatPayicon.mas_right).offset(10);
        make.centerY.equalTo(self.wechatPayicon.mas_centerY);
        make.height.equalTo(@15);
        make.width.equalTo(@150);
        
    }];
    [self.wechatSelectedImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.equalTo(self.view.mas_right).offset(-14);
        make.centerY.equalTo(self.wechatPayicon.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    
    
    
    [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.equalTo(@45);
        make.top.equalTo(self.part1topBg.mas_bottom).offset(90);
    }];

    
    [self.alipayButton mas_makeConstraints:^(MASConstraintMaker *make) {
         @strongify(self);
        make.left.equalTo(self.part1topBg.mas_left);
        make.right.equalTo(self.part1topBg.mas_right);
        make.top.equalTo(self.part1topBg.mas_top);
        make.bottom.equalTo(self.lineView.mas_top);
    }];
    
    [self.wechatButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.part1topBg.mas_left);
        make.right.equalTo(self.part1topBg.mas_right);
        make.top.equalTo(self.lineView.mas_bottom);
        make.bottom.equalTo(self.part1topBg.mas_bottom);
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
