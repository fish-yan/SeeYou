//
//  CommitCerifyView.m
//  youbaner
//
//  Created by luzhongchang on 17/7/31.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "CommitCerifyView.h"
#import "PotocolView.h"
#import "HYAlertViewController.h"
@interface CommitCerifyView()
@property(nonatomic,strong) UILabel * mLabel1;
@property(nonatomic,strong) UILabel * mLabel2;
@property(nonatomic,strong) UILabel * mLabel3;
@property(nonatomic,strong) UILabel * mLableTip1;
@property(nonatomic,strong) UILabel * mLabelTip2;
@property(nonatomic,strong) UILabel * mLabelPay;
@property(nonatomic,strong) UIView * throghView;
@property(nonatomic,strong) UILabel * potocalLabel;
@property(nonatomic,strong) UIButton * buttonCommit;
@property(nonatomic,strong) UIButton * showTipButton;
@property(nonatomic ,strong) UIImageView * arrowview;
@property(nonatomic,strong) PotocolView * tipviews ;
@property(nonatomic ,assign) BOOL isshow;

@property(nonatomic ,strong)UILabel * limitLabel;
@property(nonatomic ,strong)UILabel * youhuiLabel;


@end

@implementation CommitCerifyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if(self)
    {
        self.isshow=NO;
        self.backgroundColor =[UIColor clearColor];
        [self setUpView];
        [self sunviewsLayout];
        [self showprotocolViews];
        [self bindmodel];
    
    }
    return self;
}

- (void) bindmodel
{
    
    
    @weakify(self);
    [RACObserve(self, numberPeople) subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        if(x)
            self.mLableTip1.text =[NSString stringWithFormat:@"%@位优质单身人士已付费认证身份",x];
    }];
    
    
    [RACObserve(self, originalprice) subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        if(x)
            self.mLabelPay.text =[NSString stringWithFormat:@"永久认证仅需：%@",x];
    }];
    
    [RACObserve(self, productprice2) subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        if(x)
            self.youhuiLabel.text =[NSString stringWithFormat:@"现价：%@",x];
    }];
    
    
    [RACObserve(self, discount) subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        if(x)
        self.limitLabel.text =[NSString stringWithFormat:@"限时%@折",x];
        NSRange range = NSMakeRange(2, x.length);
        
        NSMutableAttributedString * attrStr =[[NSMutableAttributedString alloc] initWithString:self.limitLabel.text];
        [attrStr addAttribute :NSForegroundColorAttributeName value:[UIColor bgff8bb1Color] range:range];
        self.limitLabel.attributedText = attrStr;
    }];
    
    
    
    
    
}

-(void)setUpView
{
    @weakify(self);
    self.mLabel1=[UILabel labelWithText:@"您已提交身份认证资料" textColor:[UIColor whiteColor] fontSize:24 inView:self tapAction:nil];
    self.mLabel2=[UILabel labelWithText:@"离幸福只差一步" textColor:[UIColor whiteColor] fontSize:35 inView:self tapAction:nil];
    self.mLabel3=[UILabel labelWithText:@"即刻付费认证，和优质的TA约会" textColor:[UIColor whiteColor] fontSize:16 inView:self tapAction:nil];
    
    self.mLableTip1=[UILabel labelWithText:@"******位优质单身人士已付费认证身份" textColor:[UIColor whiteColor] fontSize:14 inView:self tapAction:nil];
    self.mLabelTip2=[UILabel labelWithText:@"绝无酒托、饭托、婚托" textColor:[UIColor whiteColor] fontSize:14 inView:self tapAction:nil];
    self.mLabelPay =[UILabel labelWithText:@"永久认证仅需：￥100" textColor:[UIColor whiteColor] fontSize:15 inView:self tapAction:nil];
    self.throghView =[UIView viewWithBackgroundColor:[UIColor whiteColor] inView:self.mLabelPay];
    
    
    
    self.limitLabel =[UILabel labelWithText:@"限时2.9折" textColor:[UIColor whiteColor] fontSize:15 inView:self tapAction:nil];
    
    NSRange range = NSMakeRange(2, 3);
    
    NSMutableAttributedString * attrStr =[[NSMutableAttributedString alloc] initWithString:self.limitLabel.text];
    [attrStr addAttribute :NSForegroundColorAttributeName value:[UIColor bgff8bb1Color] range:range];
    self.limitLabel.attributedText = attrStr;
    
    
    self.limitLabel.textAlignment=NSTextAlignmentRight;
    self.youhuiLabel=[UILabel labelWithText:@"现价:0.01" textColor:[UIColor whiteColor] fontSize:15 inView:self tapAction:nil];
    
    
    
    self.potocalLabel= [UILabel labelWithText:@"为什么需要缴纳认证费？" textColor:[UIColor whiteColor] fontSize:15 inView:self tapAction:nil];
    self.buttonCommit =[UIButton buttonWithTitle:@"立即认证" titleColor:[UIColor whiteColor] fontSize:16 bgColor:[UIColor bgff8bb1Color] inView:self action:^(UIButton *btn) {
        
        @strongify(self);
        if([[HYUserContext shareContext].vipverifystatus boolValue])
        {
            [YSMediator popToViewControllerName:@"HYUserCenterViewController" animated:YES];
            return;
        }
        
        [YSMediator pushToViewController:@"HYPayViewController" withParams:@{@"price":self.price} animated:YES callBack:nil];
        
    }];
    
    
    
    self.showTipButton =[UIButton buttonWithNormalImgName:@"" bgColor:[UIColor clearColor] inView:self action:^(UIButton *btn) {
        @strongify(self);
        [self showprotocolViews];
    }];
    
    [self.buttonCommit.layer setMasksToBounds:YES];
    [self.buttonCommit.layer setCornerRadius:2];
    
    
    
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:@"为什么需要缴纳认证费？"];
    NSRange contentRange = {0,[content length]};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    self.potocalLabel.attributedText = content;
    
    self.mLabel1.textAlignment =NSTextAlignmentCenter;
    self.mLabel2.textAlignment =NSTextAlignmentCenter;
    self.mLabel3.textAlignment =NSTextAlignmentCenter;
    self.mLableTip1.textAlignment = NSTextAlignmentCenter;
    self.mLabelTip2.textAlignment = NSTextAlignmentCenter;
    self.mLabelPay.textAlignment = NSTextAlignmentCenter;
    self.potocalLabel.textAlignment = NSTextAlignmentCenter;
    
    
    
    self.tipviews =[[PotocolView alloc] initWithFrame:CGRectMake(0, 0, 305, 220)];
    [self addSubview:self.tipviews];
    
    self.tipviews.block=^{
        @strongify(self);
       
        [self showprotocolViews];
    };
    
    
    self.arrowview =[ UIImageView imageViewWithImageName:@"downarrow" inView:self];
    [self.arrowview mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.tipviews.mas_bottom).offset(-1);
        make.size.mas_equalTo(CGSizeMake(41, 21));
    }];
    self.arrowview.hidden=YES;
    


}


-(void)sunviewsLayout
{
    @weakify(self);
    [self.mLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top).offset(117);
        make.height.equalTo(@24);
    }];
    [self.mLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mLabel1.mas_bottom).offset(35);
        make.height.equalTo(@35);
    }];
    
    [self.mLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mLabel2.mas_bottom).offset(10);
        make.height.equalTo(@16);
    }];
    
    
    
    
    [self.buttonCommit mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.height.equalTo(@45.0);
        make.bottom.equalTo(self.mas_bottom).offset(-73);
    }];
    
    [self.potocalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@15);
        make.bottom.equalTo(self.buttonCommit.mas_top).offset(-27);
    }];
    
    [self.mLabelPay mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
//        make.left.equalTo(self.mas_left).offset(20);
//        make.right.equalTo(self.mas_right).offset(-20);
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@15);
        make.bottom.equalTo(self.potocalLabel.mas_top).offset(-54);
    }];
    
    [self.throghView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.equalTo(self.mLabelPay.mas_right);
        make.height.equalTo(@1.0);
        make.centerY.equalTo(self.mLabelPay.mas_centerY);
        make.width.equalTo(@37);
        
    }];
    
    
    
    [self.limitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_centerX).offset(-15);
        make.top.equalTo(self.mLabelPay.mas_bottom).offset(15);
        make.height.equalTo(@15);
    }];
    
    [self.youhuiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.equalTo(self.mas_right).offset(-20);
        make.left.equalTo(self.mas_centerX).offset(15);
        make.top.equalTo(self.mLabelPay.mas_bottom).offset(15);
        make.height.equalTo(@15);
    }];
    
    
    [self.mLabelTip2 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.height.equalTo(@13);
        make.bottom.equalTo(self.mLabelPay.mas_top).offset(-15);
        
    }];
    
    [self.mLableTip1 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.height.equalTo(@13);
        make.bottom.equalTo(self.mLabelTip2.mas_top).offset(-15);
        
    }];
    
    [self.showTipButton mas_makeConstraints:^(MASConstraintMaker *make) {
         @strongify(self);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 44));
        make.centerX.equalTo(self.potocalLabel.mas_centerX);
        make.centerY.equalTo(self.potocalLabel.mas_centerY);
    }];
    
    
    [self.tipviews mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.size.mas_equalTo(CGSizeMake(305,220));
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.potocalLabel.mas_top).offset(-30);
    }];
    
    
    
}


- (void) showprotocolViews
{
    self.tipviews.hidden =!self.isshow;
    self.isshow =!self.isshow;
    self.arrowview.hidden =self.isshow;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
