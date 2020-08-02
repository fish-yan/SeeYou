//
//  PotocolView.m
//  youbaner
//
//  Created by luzhongchang on 17/8/1.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "PotocolView.h"

@interface PotocolView()
@property(nonatomic,strong) UIView *dot1View;
@property(nonatomic,strong) UIView *dot2View;
@property(nonatomic,strong) UILabel *protocal1label;
@property(nonatomic,strong) UILabel *protocal2label;
@property(nonatomic,strong) UIImageView * closeimageView;
@end


@implementation PotocolView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if(self)
    {
        //305 //220
        
        [self.layer setMasksToBounds:YES];
        [self.layer setCornerRadius:5];
        
        self.backgroundColor =[UIColor whiteColor];
        [self setUpView];
        [self subViewslayout];
        
        
        
        
    }
    return self;
}


- (void)setUpView
{
    
    @weakify(self);
    self.protocal1label=[UILabel labelWithText:@"" textColor:[UIColor tc31Color] fontSize:15 inView:self tapAction:nil];
    self.protocal1label.attributedText = [self getNSMutableAttributedString:@"花缘致力于打造最真实的婚恋交友平台，通过收取基本的认证费用可以筛选掉大部分的虚假用户。"];
    
    
    
    self.protocal2label=[UILabel labelWithText:@"" textColor:[UIColor tc31Color] fontSize:15 inView:self tapAction:nil];
    
    self.protocal2label.attributedText = [self getNSMutableAttributedString:@"进行严格的身份认证需要消耗大量的人力成本，收取基本的认证费用可以保证花缘的持续稳定运营。"];
    
    self.protocal1label.numberOfLines=0;
    self.protocal2label.numberOfLines=0;
    
    self.dot1View= [UIView viewWithBackgroundColor:[UIColor bgff8bb1Color] inView:self];
    self.dot2View= [UIView viewWithBackgroundColor:[UIColor bgff8bb1Color] inView:self];
    [self.dot1View.layer setMasksToBounds:YES];
    [self.dot2View.layer setMasksToBounds:YES];
    [self.dot1View.layer setCornerRadius:4];
    [self.dot2View.layer setCornerRadius:4];
    
    self.closeimageView =[UIImageView imageViewWithImageName:@"close" inView:self];
    
    

    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [self addGestureRecognizer:tap];
    [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        @strongify(self);
        if(self.block)
        {
            self.block();
        }
    }];
}


-(NSMutableAttributedString*)getNSMutableAttributedString:(NSString *)string
{

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:0];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
    return attributedString;
}

- (void)subViewslayout
{

    @weakify(self);
    [self.protocal1label mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.mas_left).offset(45);
        make.right.equalTo(self.mas_right).offset(-27);
        make.top.equalTo(self.mas_top).offset(25);
    }];
    
    [self.protocal2label mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.mas_left).offset(45);
        make.right.equalTo(self.mas_right).offset(-27);
        make.top.equalTo(self.protocal1label.mas_bottom).offset(20);
    }];
    
    [self.dot1View mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.size.mas_equalTo(CGSizeMake(8, 8));
        make.left.equalTo(self.mas_left).offset(25);
        make.top.equalTo(self.protocal1label.mas_top).offset(3);
    }];
    [self.dot2View mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.size.mas_equalTo(CGSizeMake(8, 8));
        make.left.equalTo(self.mas_left).offset(25);
        make.top.equalTo(self.protocal2label.mas_top).offset(3);
    }];
    
    [self.closeimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.size.mas_equalTo(CGSizeMake(23, 23));
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
    
    
}


@end
