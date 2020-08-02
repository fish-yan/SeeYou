//
//  CPAuthentionExample.m
//  CPPatient
//
//  Created by luzhongchang on 2017/8/31.
//  Copyright © 2017年 Jam. All rights reserved.
//

#import "CPAuthentionExample.h"
@interface CPAuthentionExample()
@property(nonatomic ,strong) UIView *maskView;
@property(nonatomic ,strong) UIView *bgView;
@property(nonatomic ,strong) UILabel * titleLabel;
@property(nonatomic ,strong) UIImageView * imageview;
@property(nonatomic ,strong) UIButton * closeButton;
@property(nonatomic ,strong) UIView * lineView;
@end



@implementation CPAuthentionExample

- (id) initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor =[UIColor clearColor];
        self.maskView =[UIView viewWithBackgroundColor:[[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0.4] inView:self];
        self.maskView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
        self.bgView =[UIView viewWithBackgroundColor:[UIColor whiteColor] inView:self];
        self.bgView.frame =CGRectMake((SCREEN_WIDTH-295)/2, (SCREEN_HEIGHT-347)/2-64, 295, 347);
        [self.bgView.layer setMasksToBounds:YES];
        [self.bgView.layer setCornerRadius:5];
        [self setUpView];
        [self subviewLayout];
        
        UITapGestureRecognizer * ges =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesTap)];
        [self.maskView addGestureRecognizer:ges];
        
        
        
    }
    return self;
}

- (void)setUpView
{
    @weakify(self);
    self.titleLabel =[UILabel labelWithText:@"示例图片" textColor:[UIColor redColor] fontSize:16 inView:self.bgView tapAction:nil];
    self.titleLabel.textAlignment =NSTextAlignmentCenter;
    self.imageview =[UIImageView imageViewWithImageName:@"合照" inView:self.bgView];
    self.imageview.contentMode =UIViewContentModeScaleAspectFit;
    self.lineView =[UIView viewWithBackgroundColor:[UIColor redColor] inView:self.bgView];
    self.closeButton =[UIButton buttonWithTitle:@"关闭" titleColor:[UIColor redColor] fontSize:18 bgColor:[UIColor clearColor] inView:self.bgView action:^(UIButton *btn) {
        @strongify(self);
        [self removeFromSuperview];
    }];
}


- (void)gesTap
{
    [self removeFromSuperview];
}

- (void)subviewLayout
{
    @weakify(self);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.bgView.mas_left);
        make.right.equalTo(self.bgView.mas_right);
        make.top.equalTo(self.bgView.mas_top).offset(23);
        make.height.equalTo(@16);
    }];
    
    [self.imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.bgView.mas_left).offset(15);
        make.right.equalTo(self.bgView.mas_right).offset(-15);
        make.top.equalTo(self.bgView.mas_top).offset(62);
        make.height.equalTo(@220);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.bgView.mas_left);
        make.right.equalTo(self.bgView.mas_right);
        make.top.equalTo(self.imageview.mas_bottom).offset(16);
        make.height.equalTo(@0.5);
        
    }];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.bgView.mas_left);
        make.right.equalTo(self.bgView.mas_right);
        make.top.equalTo(self.lineView.mas_bottom);
        make.height.equalTo(@44);
    }];
}


-(void) setType:(AuthentionPhotoType)type
{
    switch (type) {
        case fordwardType:
            self.imageview.image =[UIImage imageNamed:@"正面照"];
            break;
        case backwardType:
            self.imageview.image =[UIImage imageNamed:@"反面照"];
            break;
        case allType:
            self.imageview.image =[UIImage imageNamed:@"合照"];
            break;
        default:
            break;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
