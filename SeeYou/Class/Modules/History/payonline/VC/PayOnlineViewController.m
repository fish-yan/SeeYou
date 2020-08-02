//
//  PayOnlineViewController.m
//  youbaner
//
//  Created by 卢中昌 on 2018/6/23.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "PayOnlineViewController.h"
#import "PayInstance.h"
#import "HYPayViewModel.h"
#import "alipayModel.h"
#import "HYPopDataModel.h"
@interface PayOnlineViewController ()
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) UIView *parttopBg;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UIView *part1topBg;
@property (nonatomic, strong) UIImageView *aliPayicon;
@property (nonatomic, strong) UILabel *alipayLabel;
@property (nonatomic, strong) UIImageView *aliSelectedImageview;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *wechatPayicon;
@property (nonatomic, strong) UILabel *wechatLabel;
@property (nonatomic, strong) UIImageView *wechatSelectedImageview;


@property (nonatomic, strong) UIView *bgView1;
@property (nonatomic, strong) UILabel *extraLabel;
@property (nonatomic, strong) UILabel *moneylabel;


@property (nonatomic, strong) UIButton *alipayButton;
@property (nonatomic, strong) UIButton *wechatButton;

@property (nonatomic, strong) UIButton *payButton;
@property (nonatomic, assign) int type;    // 1 是支付宝 2 微信
@property (nonatomic, strong) HYPopDataModel *basedatamodel;
@property (nonatomic, strong) prepayappointmentModel *WDmodel;
@property (nonatomic, strong) HYPayViewModel *payViewmodel;

@end


@implementation PayOnlineViewController

+ (void)load {
    [self mapName:kModuleOnLinePay withParams:nil];
}

- (void)initialize {
    self.navigationItem.title = @"在线支付";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.payViewmodel = [HYPayViewModel new];
    [self initialize];
    [self setUpview];
    [self subviewLayout];
    [self bindModel];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


- (void)setUpview {
    self.type      = 1;
    self.parttopBg = [UIView viewWithBackgroundColor:[UIColor whiteColor] inView:self.view];

    self.titleLabel = [UILabel labelWithText:self.basedatamodel.name
                                   textColor:[UIColor tc31Color]
                                    fontSize:15
                                      inView:self.parttopBg
                                   tapAction:nil];
    self.priceLabel = [UILabel labelWithText:[NSString stringWithFormat:@"%@元", self.basedatamodel.price2]
                                   textColor:[UIColor tc31Color]
                                    fontSize:45
                                      inView:self.parttopBg
                                   tapAction:nil];
    NSMutableAttributedString *richText = [[NSMutableAttributedString alloc] initWithString:self.priceLabel.text];


    [richText addAttribute:NSFontAttributeName
                     value:Font_PINGFANG_SC(20)
                     range:NSMakeRange(self.priceLabel.text.length - 1, 1)];    //设置字体大小
    self.priceLabel.attributedText = richText;

    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.priceLabel.textAlignment = NSTextAlignmentCenter;


    self.bgView1 = [UIView viewWithBackgroundColor:[UIColor whiteColor] inView:self.view];

    self.extraLabel =
    [UILabel labelWithText:@"余额抵扣" textColor:[UIColor tc31Color] fontSize:14 inView:self.bgView1 tapAction:nil];
    self.moneylabel = [UILabel labelWithText:self.WDmodel.balance
                                   textColor:[UIColor tc31Color]
                                    fontSize:14
                                      inView:self.bgView1
                                   tapAction:nil];

    self.moneylabel.textAlignment = NSTextAlignmentRight;


    self.part1topBg  = [UIView viewWithBackgroundColor:[UIColor whiteColor] inView:self.view];
    self.aliPayicon  = [UIImageView imageViewWithImageName:@"aliicon" inView:self.part1topBg];
    self.alipayLabel = [UILabel labelWithText:@"支付宝支付"
                                    textColor:[UIColor tc31Color]
                                     fontSize:16
                                       inView:self.part1topBg
                                    tapAction:nil];
    self.alipayLabel.textAlignment = NSTextAlignmentLeft;
    self.aliSelectedImageview      = [UIImageView imageViewWithImageName:@"payseled" inView:self.part1topBg];
    self.lineView                  = [UIView viewWithBackgroundColor:[UIColor line0Color] inView:self.part1topBg];
    self.wechatPayicon             = [UIImageView imageViewWithImageName:@"wechaticon" inView:self.part1topBg];
    self.wechatLabel =
    [UILabel labelWithText:@"微信支付" textColor:[UIColor tc31Color] fontSize:16 inView:self.part1topBg tapAction:nil];
    self.wechatLabel.textAlignment = NSTextAlignmentLeft;
    self.wechatSelectedImageview   = [UIImageView imageViewWithImageName:@"payseled" inView:self.part1topBg];

    @weakify(self);
    self.payButton = [UIButton
    buttonWithTitle:[NSString stringWithFormat:@"确认支付%@", self.WDmodel.payamount]
         titleColor:[UIColor whiteColor]
           fontSize:14
            bgColor:[UIColor bgff8bb1Color]
             inView:self.view
             action:^(UIButton *btn) {
                 @strongify(self);
                 if (self.type == 1) {
                     [WDProgressHUD showInView:self.view];
                     [self.payViewmodel.doCommand execute:@{ @"id": self.WDmodel.orderid }];

                 } else {
                     [WDProgressHUD showInView:self.view];
                     [self.payViewmodel.doWechatCommand execute:@{ @"id": self.WDmodel.orderid, @"apptype": @"1" }];
                 }

             }];
    [self.payButton.layer setMasksToBounds:YES];
    [self.payButton.layer setCornerRadius:2];


    self.alipayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.part1topBg addSubview:self.alipayButton];

    [self.alipayButton addTarget:self action:@selector(choicePayType:) forControlEvents:UIControlEventTouchUpInside];

    self.wechatButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.part1topBg addSubview:self.wechatButton];
    [self.wechatButton addTarget:self action:@selector(choicePayType:) forControlEvents:UIControlEventTouchUpInside];

    self.aliSelectedImageview.alpha    = 1;
    self.wechatSelectedImageview.alpha = 0;
}


- (void)bindModel {
    @weakify(self);
    [RACObserve(self, type) subscribeNext:^(NSNumber *_Nullable x) {
        @strongify(self);
        if ([x intValue] == 0) {
            self.payButton.alpha   = 1.0;
            self.payButton.enabled = YES;
        } else {
            self.payButton.alpha   = 1.0;
            self.payButton.enabled = YES;
        }
    }];


    [[self.payViewmodel.doCommand.executionSignals switchToLatest] subscribeNext:^(WDResponseModel *_Nullable x) {

        [WDProgressHUD hiddenHUD];

        PayInstance *s = [PayInstance sharedInstance];
        s.block        = ^(int status) {
            self.block([NSString stringWithFormat:@"%d", status]);
        };
        [s doPay:x.data];

    }];
    [self.payViewmodel.doCommand.errors subscribeNext:^(NSError *_Nullable x) {
        @strongify(self);
        [WDProgressHUD hiddenHUD];
        [WDProgressHUD showTips:x.localizedDescription];
        if (self.block) {
            @strongify(self);
            self.block([NSString stringWithFormat:@"%d", 1]);
        }
    }];


    [[self.payViewmodel.doWechatCommand.executionSignals switchToLatest] subscribeNext:^(WDResponseModel *_Nullable x) {

        @strongify(self);
        [WDProgressHUD hiddenHUD];

        PayInstance *s = [PayInstance sharedInstance];
        s.block        = ^(int status) {
            @strongify(self);
            self.block([NSString stringWithFormat:@"%d", status]);
        };
        [s doWechatPay:x.data];


    }];
    [self.payViewmodel.doWechatCommand.errors subscribeNext:^(NSError *_Nullable x) {

        [WDProgressHUD hiddenHUD];
        [WDProgressHUD showTips:x.localizedDescription];
        if (self.block) {
            self.block([NSString stringWithFormat:@"%d", 1]);
        }
    }];
}

- (void)choicePayType:(UIButton *)sender {
    if (sender == self.alipayButton) {
        self.aliSelectedImageview.alpha    = 1;
        self.wechatSelectedImageview.alpha = 0;
        self.type                          = 1;
    } else {
        self.aliSelectedImageview.alpha    = 0;
        self.wechatSelectedImageview.alpha = 1;
        self.type                          = 2;
    }
}


- (void)subviewLayout {
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


    [self.bgView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.parttopBg.mas_bottom).offset(10);
        make.height.equalTo(@44.0);
    }];
    [self.extraLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.bgView1.mas_left).offset(10);
        make.centerY.equalTo(self.bgView1.mas_centerY);
        make.height.equalTo(@15);
        make.width.equalTo(@150);
    }];
    [self.moneylabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.equalTo(self.bgView1.mas_right).offset(-15);
        make.centerY.equalTo(self.bgView1.mas_centerY);
        make.height.equalTo(@15);
        make.width.equalTo(@150);
    }];


    [self.part1topBg mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.bgView1.mas_bottom).offset(10);
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
