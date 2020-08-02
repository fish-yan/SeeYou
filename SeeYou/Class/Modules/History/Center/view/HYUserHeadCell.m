//
//  HYUserHeadCell.m
//  youbaner
//
//  Created by luzhongchang on 17/8/2.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYUserHeadCell.h"
#import "HYUserHeadViewModel.h"
#import "UIImage+blur.h"
@interface HYUserHeadCell()
@property(nonatomic ,strong) UIView         *bgView;
@property(nonatomic ,strong) UIImageView    *photoView;
@property(nonatomic ,strong) UILabel        *userNameLabel;
@property(nonatomic ,strong) UILabel        *marrayTimeLabel;
@property(nonatomic ,strong) UIView         *circleView;
@property(nonatomic ,strong) UILabel        *baseInfoLabel;//age.heigth.salary.constellation
@property(nonatomic ,strong) UILabel        *cityLabel;
@property(nonatomic ,strong) HYUserHeadViewModel * viewModel;
@end

@implementation HYUserHeadCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self setUpview];
        [self subviewsLayout];
        [self bindmodel];
    
    }
    return self;
}


- (void)setUpview
{
    
    self.bgView =[UIView viewWithBackgroundColor:[UIColor whiteColor] inView:self.contentView];
    
    self.photoView =[UIImageView imageViewWithImageName:@"defauleimage1" inView:self.bgView];
    self.userNameLabel = [UILabel labelWithText:@"" textColor:[UIColor tc4a4a4aColor] fontSize:20 inView:self.bgView tapAction:nil];
    self.userNameLabel.textAlignment = NSTextAlignmentLeft;
    self.circleView=[UIView viewWithBackgroundColor:[UIColor clearColor] inView:self.bgView];
    [self.circleView.layer setMasksToBounds:YES];
    [self.circleView.layer setCornerRadius:4];
    [self.circleView.layer setBorderWidth:0.5];
    [self.circleView.layer setBorderColor:[UIColor tcff8bb1Color].CGColor];
    self.marrayTimeLabel = [UILabel labelWithText:@"" textColor:[UIColor tcff8bb1Color] fontSize:15 inView:self.bgView tapAction:nil];
    self.marrayTimeLabel.textAlignment = NSTextAlignmentRight;
    self.baseInfoLabel = [UILabel labelWithText:@"" textColor:[UIColor tc464446Color] fontSize:13 inView:self.bgView tapAction:nil];
    self.baseInfoLabel.textAlignment = NSTextAlignmentLeft;
    self.cityLabel  = [UILabel labelWithText:@"" textColor:[UIColor tc6f6f6fColor] fontSize:13 inView:self.bgView tapAction:nil];
    self.cityLabel.textAlignment = NSTextAlignmentRight;
}

- (void)subviewsLayout
{
    @weakify(self);
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH));
    }];
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.bgView.mas_left).offset(15);
        make.top.equalTo(self.photoView.mas_bottom).offset(20);
        make.height.equalTo(@20);
    }];
    
    [self.marrayTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.equalTo(self.bgView.mas_right).offset(-15);
        make.centerY.equalTo(self.userNameLabel.mas_centerY);
        make.height.equalTo(@15);
        make.left.equalTo(self.userNameLabel.mas_right);
    }];
    
    [self.baseInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.bgView.mas_left).offset(15);
        make.top.equalTo(self.userNameLabel.mas_bottom).offset(18);
        make.height.equalTo(@13);
        make.bottom.equalTo(self.bgView.mas_bottom).offset(-18).priorityLow();
    }];
    [self.cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.equalTo(self.bgView.mas_right).offset(-15);
        make.centerY.equalTo(self.baseInfoLabel.mas_centerY);
        make.height.equalTo(@14);
        make.left.equalTo(self.baseInfoLabel.mas_right).offset(10);
    }];
    [self.circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.equalTo(self.marrayTimeLabel.mas_left).offset(-5);
        make.centerY.equalTo(self.marrayTimeLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(8, 8));
    }];
    


}


- (void) bindWithViewModel:(HYBaseViewModel *)vm
{
    if(vm && [vm isKindOfClass:[HYUserHeadViewModel class]])
    {
       self.viewModel =(HYUserHeadViewModel*)vm;
    }
        
    
}

-(void)bindmodel
{

    
    @weakify(self);
    [RACObserve(self,viewModel.avatar ) subscribeNext:^(NSURL * _Nullable x) {
        
        @strongify(self);
        if(x)
        {
            [self.photoView sd_setImageWithURL:x placeholderImage:[UIImage imageNamed:@"defauleimage1"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if(image)
                {
                    @strongify(self);
                    self.photoView.image = [self cutImage:image];
                }
            }];
            
        }
        
   
        
    }];
    
    
    RAC(self.userNameLabel,text)  =RACObserve(self, viewModel.username);
    RAC(self.marrayTimeLabel,text)  =RACObserve(self, viewModel.marraytime);
    RAC(self.baseInfoLabel,attributedText)  =RACObserve(self, viewModel.baseInfostring);
    RAC(self.cityLabel,text)  =RACObserve(self, viewModel.city);
    
    [RACObserve(self, viewModel.marraytime)subscribeNext:^(NSString *  _Nullable x) {
       
         @strongify(self);
        if(x.length>0)
        {
            self.circleView.hidden=NO;
        }
        else
        {
            self.circleView.hidden=YES;
        }
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
