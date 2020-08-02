//
//  HYBaseInfocell.m
//  youbaner
//
//  Created by luzhongchang on 17/8/3.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseInfocell.h"
#import "HYBaseInfoVeiwModel.h"

@interface HYBaseInfocell()
@property(nonatomic ,strong) HYBaseInfoVeiwModel * viewModel;
@property(nonatomic ,strong) UILabel * titleLabel;
@property(nonatomic ,strong) UIImageView *iconImageView;
@property(nonatomic ,strong) UILabel *valueLabel;
@property(nonatomic ,strong) UIImageView *arrowView;
@property(nonatomic ,strong) UIView *lineView;


@end

@implementation HYBaseInfocell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self setUpView];
        [self subviewLayout];
        [self binmodel];
    }
    return self;
}


- (void) setUpView
{
    self.iconImageView =[UIImageView imageViewWithImageName:@"" inView:self.contentView];
    self.titleLabel =[UILabel labelWithText:@"" textColor:[UIColor tc7d7d7dColor] fontSize:14 inView:self.contentView tapAction:nil];
    self.titleLabel.textAlignment=NSTextAlignmentLeft;
    self.valueLabel =[UILabel labelWithText:@"" textColor:[UIColor tc7d7d7dColor] fontSize:14 inView:self.contentView tapAction:nil];
    self.valueLabel.textAlignment=NSTextAlignmentRight;
    self.arrowView = [UIImageView imageViewWithImageName:@"arrowright" inView:self.contentView];
   
    
    self.lineView =[UIView viewWithBackgroundColor:[UIColor line0Color] inView:self.contentView];
    
    
}

-(void)subviewLayout
{
    @weakify(self);
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    @strongify(self);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@100);
        make.height.equalTo(@14);
    }];
    
    [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
       @strongify(self);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(8, 14));
    }];
    
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.titleLabel.mas_right).offset(10);
        make.right.equalTo(self.arrowView.mas_right).offset(-15);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.equalTo(@14);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(@0.5);
        make.bottom.equalTo(self.contentView.mas_bottom);
        
    }];
    
}

- (void)bindWithViewModel:(HYBaseViewModel*)vm
{
    if(vm && [vm isKindOfClass:[HYBaseInfoVeiwModel class]])
    {
        
            self.viewModel =(HYBaseInfoVeiwModel*)vm;
            self.iconImageView.image =[UIImage imageNamed:self.viewModel.iconName];
    }
}


-(void) binmodel
{
    
    RAC(self.titleLabel,text) = [RACObserve(self, viewModel.title) distinctUntilChanged];
    RAC(self.valueLabel,text)= [RACObserve(self,viewModel.value) distinctUntilChanged];
    
}

@end
