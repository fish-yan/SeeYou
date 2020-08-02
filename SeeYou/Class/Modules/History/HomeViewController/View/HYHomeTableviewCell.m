//
//  HYHomeTableviewCell.m
//  youbaner
//
//  Created by luzhongchang on 17/7/30.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYHomeTableviewCell.h"
#import "HYHomeCellViewModel.h"
#import "UIImage+blur.h"
@interface HYHomeTableviewCell()

@property(nonatomic ,strong) HYHomeCellViewModel * viewModel;
@property(nonatomic ,strong) UIView         *bgView;
@property(nonatomic ,strong) UIImageView    *photoView;
@property(nonatomic ,strong) UILabel        *isVerifyLabel;
@property(nonatomic ,strong) UIView         *userOprationView;//心动和私信底座
@property(nonatomic ,strong) UIButton       *isBeMovedButton;
@property(nonatomic ,strong) UIButton       *isPrivatrButton;
@property(nonatomic ,strong) UIView         *stickview;
@property(nonatomic ,strong) UILabel        *userNameLabel;
@property(nonatomic ,strong) UIView         *circleView;
@property(nonatomic ,strong) UILabel        *marrayTimeLabel;
@property(nonatomic ,strong) UILabel        *baseInfoLabel;//age.heigth.salary.constellation
@property(nonatomic ,strong) UILabel        *cityLabel;

@property(nonatomic ,strong) UILabel        *interduceLabel;


@end

@implementation HYHomeTableviewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        
        self.backgroundColor=[UIColor whiteColor];
        [self setUpView];
        [self subViewlayout];
        
        [self bindmodel];
        
    }
    return self;
}


#pragma  mark setupview
- (void)setUpView
{

    @weakify(self);
    
    self.photoView =[UIImageView imageViewWithImageName:@"defauleimage1" inView:self.contentView];
    self.photoView.contentMode = UIViewContentModeScaleAspectFit;
    self.photoView.clipsToBounds = YES;
    
    self.isVerifyLabel =[UILabel labelWithText:@"已认证身份" textColor:[UIColor whiteColor] fontSize:14 inView:self.contentView tapAction:nil];
    self.isVerifyLabel.textAlignment = NSTextAlignmentCenter;
    self.isVerifyLabel.backgroundColor =[UIColor bg2Color];
    
    self.userOprationView=[UIView viewWithBackgroundColor:[UIColor bg31313109Color] inView:self.contentView];
    self.userOprationView.backgroundColor =[[UIColor alloc] initWithRed:49.0/255.0 green:49.0/255.0 blue:49.0/255.0 alpha:0.9];
    self.isBeMovedButton =[UIButton buttonWithTitle:@"心动" titleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10) titleColor:[UIColor whiteColor] fontSize:13.0 normalImgName:@"heartNormal" highlightedImageName:@"heartNormal" imageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) bgColor:[UIColor clearColor] normalBgImageName:nil highlightedBgImageName:nil inView:self.contentView action:^(UIButton *btn) {
        @strongify(self);
        if(![self doNextOpration])
        {
            return ;
        }
        
        [self.viewModel.doBeMovedCommand execute:@"1"];
    }];

    self.isPrivatrButton =[UIButton buttonWithTitle:@"私聊" titleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10) titleColor:[UIColor whiteColor] fontSize:13.0 normalImgName:@"chartNormal" highlightedImageName:@"chartNormal" imageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) bgColor:[UIColor clearColor] normalBgImageName:nil highlightedBgImageName:nil inView:self.contentView action:^(UIButton *btn) {
        
        @strongify(self);
        if(![self doNextOpration])
        {
            return ;
        }
        if(![[HYUserContext shareContext].userModel.vipstatus boolValue])
        {
            //todo 购买会员
            [YSMediator pushToViewController:@"HYMembershipVC" withParams:@{} animated:YES callBack:nil];
            return;
        }
        [YSMediator pushToViewController:@"PrivateMessageDetialViewController" withParams:@{@"cantactName":self.viewModel.userName,@"cantactID":self.viewModel.userId,@"avatar":[self.viewModel.phototUrl path] } animated:YES callBack:nil];
        
    }];
    
    self.stickview =[UIView viewWithBackgroundColor:[UIColor bg9b9b9bColor] inView:self.contentView];
    self.userNameLabel = [UILabel labelWithText:@"" textColor:[UIColor tc4a4a4aColor] fontSize:20 inView:self.contentView tapAction:nil];
    self.userNameLabel.textAlignment = NSTextAlignmentLeft;
    
    self.circleView=[UIView viewWithBackgroundColor:[UIColor clearColor] inView:self.contentView];
    
    [self.circleView.layer setMasksToBounds:YES];
    [self.circleView.layer setCornerRadius:4];
    [self.circleView.layer setBorderWidth:0.5];
    [self.circleView.layer setBorderColor:[UIColor tcff8bb1Color].CGColor];
    
    self.marrayTimeLabel = [UILabel labelWithText:@"" textColor:[UIColor tcff8bb1Color] fontSize:15 inView:self.contentView tapAction:nil];
    self.marrayTimeLabel.textAlignment = NSTextAlignmentRight;
    
    self.baseInfoLabel = [UILabel labelWithText:@"" textColor:[UIColor tc464446Color] fontSize:13 inView:self.contentView tapAction:nil];
    self.baseInfoLabel.textAlignment = NSTextAlignmentLeft;
    self.cityLabel  = [UILabel labelWithText:@"" textColor:[UIColor tc6f6f6fColor] fontSize:13 inView:self.contentView tapAction:nil];
    self.cityLabel.textAlignment = NSTextAlignmentRight;
    self.interduceLabel =  [UILabel labelWithText:@"" textColor:[UIColor tc949494Color] fontSize:13 inView:self.contentView tapAction:nil];
    self.interduceLabel.textAlignment = NSTextAlignmentLeft;
    self.interduceLabel.numberOfLines=0;
}


- (void)subViewlayout
{
    @weakify(self);
    [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH));
    }];
    
    self.isVerifyLabel.frame =CGRectMake(0, 20, 93, 30);
    self.isVerifyLabel.layer.masksToBounds = true;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.isVerifyLabel.bounds byRoundingCorners:(UIRectCornerTopRight | UIRectCornerBottomRight) cornerRadii:CGSizeMake(15,15)];//圆角大小
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.isVerifyLabel.bounds;
    maskLayer.path = maskPath.CGPath;
    self.isVerifyLabel.layer.mask = maskLayer;
    
    

    [self.userOprationView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.bottom.equalTo(self.photoView.mas_bottom);
        make.left.equalTo(self.photoView.mas_left);
        make.right.equalTo(self.photoView.mas_right);
        make.top.equalTo(self.photoView.mas_bottom).offset(-45.);
    }];
    
    [self.isBeMovedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.userOprationView.mas_left);
        make.top.equalTo(self.userOprationView.mas_top);
        make.bottom.equalTo(self.userOprationView.mas_bottom);
        make.right.equalTo(self.userOprationView.mas_centerX);
    }];

    [self.isPrivatrButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.equalTo(self.userOprationView.mas_right);
        make.top.equalTo(self.userOprationView.mas_top);
        make.bottom.equalTo(self.userOprationView.mas_bottom);
        make.left.equalTo(self.userOprationView.mas_centerX);
    }];

    [self.stickview mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.equalTo(self.userOprationView.mas_centerX);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(0.5);
        make.centerY.equalTo(self.userOprationView.mas_centerY);
    }];

    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.top.equalTo(self.photoView.mas_bottom).offset(20);
        make.height.equalTo(@20);
    }];

    
    
    [self.marrayTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.centerY.equalTo(self.userNameLabel.mas_centerY);
        make.height.equalTo(@15);
        make.left.equalTo(self.userNameLabel.mas_right);
    }];
    [self.circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.equalTo(self.marrayTimeLabel.mas_left).offset(-5);
        make.centerY.equalTo(self.marrayTimeLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(8, 8));
    }];
    

    [self.baseInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.top.equalTo(self.userNameLabel.mas_bottom).offset(17);
        make.height.equalTo(@15);
    }];
    [self.cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.top.equalTo(self.userNameLabel.mas_bottom).offset(17);
        make.height.equalTo(@15);
        make.left.equalTo(self.baseInfoLabel.mas_right).offset(10);
    }];

    [self.interduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       @strongify(self);
        make.top.equalTo(self.baseInfoLabel.mas_bottom).offset(18);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15).priorityLow();
    }];
}

- (void)bindWithViewModel:(HYBaseViewModel*)vm
{
    if(vm && [vm isKindOfClass:[HYHomeCellViewModel class]])
    {
      
            self.viewModel =(HYHomeCellViewModel*)vm;
    }
}

- (void)bindmodel
{
  
   
    @weakify(self);
    [RACObserve(self, viewModel)subscribeNext:^( HYHomeCellViewModel  * x){
        @strongify(self);
        if(x)
        {
            
            SDImageCache *imageCache = [SDImageCache sharedImageCache];
            [imageCache diskImageExistsWithKey:x.Url completion:^(BOOL isInCache) {
                if(isInCache)
                    self.photoView.image = [self cutImage:[imageCache imageFromDiskCacheForKey:x.Url]];
                else
                {
                    [self.photoView sd_setImageWithURL:x.phototUrl placeholderImage:[UIImage imageNamed:@"defauleimage1"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                        if(image)
                        {
                            @strongify(self);
                            
                            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                                 @strongify(self);
                               UIImage *imagem =   [self cutImage:image];
                                dispatch_async(dispatch_get_main_queue(), ^{
                                     @strongify(self);
                                    self.photoView.image =imagem;
                                });
                                
                            });
                            
                        }
                    }];
                }
            }];
           
            
           

        }
    }];

    [RACObserve(self, viewModel.isVerify) subscribeNext:^(NSNumber *  _Nullable x) {
        self.isVerifyLabel.hidden = ![x boolValue];
    }];
    
   
    [RACObserve(self, viewModel.isBeMoved) subscribeNext:^(NSNumber  * x) {
        @strongify(self);
       if([x boolValue])
       {
           [self.isBeMovedButton setImage:[UIImage imageNamed:@"heartSel"] forState:UIControlStateNormal];
           [self.isBeMovedButton setImage:[UIImage imageNamed:@"heartSel"] forState:UIControlStateHighlighted];
       }
       else
       {
           [self.isBeMovedButton setImage:[UIImage imageNamed:@"heartNormal"] forState:UIControlStateNormal];
           [self.isBeMovedButton setImage:[UIImage imageNamed:@"heartNormal"] forState:UIControlStateHighlighted];
       }
        
    }];
    

    
    
    RAC(self.userNameLabel, text)= RACObserve(self,viewModel.userName) ;
    RAC(self.marrayTimeLabel, text)= RACObserve(self,viewModel.wantToMarrayTime);
    RAC(self.baseInfoLabel, attributedText)= RACObserve(self,viewModel.baseinfoString);
    RAC(self.cityLabel, text)= RACObserve(self,viewModel.city);
    RAC(self.interduceLabel, text)= RACObserve(self,viewModel.interduce);
    
    
    [[self.viewModel.doBeMovedCommand.executionSignals switchToLatest] subscribeNext:^(WDResponseModel*  _Nullable x) {
       [WDProgressHUD showTips:x.msg];
    }];
    [self.viewModel.doBeMovedCommand.errors subscribeNext:^(NSError * _Nullable x) {
       
        [WDProgressHUD showTips:x.localizedDescription];
    }];
    
}

- (BOOL)doNextOpration
{
    
    if(![HYUserContext shareContext].login)
    {
        
                id cancelBlock=^()
                {
                    
                };
                id sureBlock=^()
                {
                    [[AppDelegateUIAssistant shareInstance].setLoginVCASRootVCComand execute:@"1"];
                };
        
        
                [YSMediator presentToViewController:@"HYAlertViewController"  withParams:@{@"message":@"为了保护会员隐私，登录后才可查看会员详情",
                                                                                                  @"type":@2,
                                                                                                  @"rightButtonTitle":@"去登录",
                                                                                                  @"leftButtonTitle":@"取消",
                                                                                                  @"rightTitleColor":[UIColor tcff8bb1Color],
                                                                                                  @"cancelBlock":cancelBlock,
                                                                                                  @"sureBlock":sureBlock
                                                                                                  } animated:YES callBack:nil];
        
        return NO;
    }
    
    
    if([[HYUserContext shareContext].vipverifystatus intValue] ==0)
    {
        
        
                id cancelBlock=^()
                {
                  
                };
                id sureBlock=^()
                {
                    [YSMediator pushToViewController:@"IdentityAuthenticationViewController" withParams:@{} animated:YES callBack:nil];
                };
        
        
                [YSMediator presentToViewController:@"HYAlertViewController"  withParams:@{@"message":@"为了保护会员隐私，认证后才可以发送私信",
                                                                                                  @"type":@2,
                                                                                                  @"rightButtonTitle":@"立即认证",
                                                                                                  @"leftButtonTitle":@"取消",
                                                                                                  @"rightTitleColor":[UIColor tcff8bb1Color],
                                                                                                  @"cancelBlock":cancelBlock,
                                                                                                  @"sureBlock":sureBlock
                                                                                                  } animated:YES callBack:nil];
        
        return NO;
    }
    return YES;
}



- (UIImage *)cutImage:(UIImage*)image1{
    
    if (image1.size.height>image1.size.width){
        image1 = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([image1 CGImage],CGRectMake(0,fabs(image1.size.height - image1.size.width)/2.0,              image1.size.width, image1.size.width))];
        
    }else{
        image1 = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([image1   CGImage],CGRectMake(fabs(image1.size.height - image1.size.width)/2.0,0,             image1.size.height, image1.size.height))];
    }
    
    return image1;
}
@end
