//
//  HYCollectionViewCell.m
//  youbaner
//
//  Created by luzhongchang on 17/8/8.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYCollectionViewCell.h"


@interface HYCollectionViewCell()

@end

@implementation HYCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if(self)
    {
        [self setup];
 
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTapAction:)];
        longPress.minimumPressDuration = 0.8; //定义按的时间
        longPress.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:longPress];
        
        
        @weakify(self);
        self.deleteButton =[UIButton buttonWithNormalImgName:@"deleteButton" bgColor:[UIColor clearColor] inView:self action:^(UIButton *btn) {
            @strongify(self);
            [WDProgressHUD showInView:nil];
            [self.viewModel.doCommand execute:@"1"];
        }];
        
        CGFloat width = (SCREEN_WIDTH-4)/3.0 ;
        self.deleteButton.frame =CGRectMake(width -20,4 , 16, 16);
        
        self.deleteButton.hidden=YES;
        [self bindemodel];
    }
    return self;
}

- (void)longTapAction:(id)tap
{
    if(self.viewModel.delButton )
    {
        return;
    }
    
    self.viewModel.deleteStatus =YES;
    self.deleteButton.hidden=NO;
}


-(void)setup
{

    @weakify(self);
    self.bgView =[[UIView alloc] init];
    [self.contentView addSubview:self.bgView];
 
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.contentView.mas_left).offset(0.5);
        make.right.equalTo(self.contentView.mas_right).offset(-0.5);
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-1);
    }];
    
    
    self.mImageView =[UIImageView imageViewWithImageName:@"defauleimage1" inView:self.contentView];
    [self.mImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.contentView.mas_left).offset(0.5);
        make.right.equalTo(self.contentView.mas_right).offset(-0.5);
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-1);
    }];
}


- (void)bindWithViewModel:(HYBaseViewModel*)vm
{
    if(vm && [vm isKindOfClass:[HYShoePhotosViewModel class]])
    {
        self.viewModel =(HYShoePhotosViewModel*)vm;
    }
}

-(void)bindemodel
{

    @weakify(self);
    [RACObserve(self, viewModel.url) subscribeNext:^(NSURL *  _Nullable x) {
       
        if(x)
        {
            [self.mImageView sd_setImageWithURL:x placeholderImage:[UIImage imageNamed:@"defauleimage1"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
                @strongify(self);
                if(image)
                {
                    self.mImageView.image =[self cutImage:image];
                }
//
                
            }];
//            [self.mImageView sd_setImageWithURL:x placeholderImage:[UIImage imageNamed:@""]];
        }
    }];
    
    
    [RACObserve(self, viewModel.deleteStatus) subscribeNext:^(NSNumber *  _Nullable x) {
        
        if([x boolValue])
        {
            self.deleteButton.hidden = NO;
        }
        else
        {
            self.deleteButton.hidden = YES;
        }
    }];
    
    
    
    
    [[self.viewModel.doCommand.executionSignals switchToLatest] subscribeNext:^(WDResponseModel*  _Nullable x) {
       
        [WDProgressHUD hiddenHUD];
//        [WDProgressHUD showTips:x.msg];
        [[NSNotificationCenter defaultCenter] postNotificationName:LOGOUT_UPDATE_USERINFOKEY object:nil];
    }];
    
    [self.viewModel.doCommand.errors subscribeNext:^(NSError * _Nullable x) {
        [WDProgressHUD hiddenHUD];
        [WDProgressHUD showTips:x.localizedDescription];
    }];
    
    
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
