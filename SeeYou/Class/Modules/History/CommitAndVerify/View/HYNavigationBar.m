//
//  HYNavigationBar.m
//  youbaner
//
//  Created by luzhongchang on 17/7/31.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYNavigationBar.h"

@interface HYNavigationBar()



@end

@implementation HYNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if(self)
    {
        [self setUpView];
        [self bindmodel];
        
    }
    return self;
}


-(void) setUpView
{
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height)];
    aView.backgroundColor = [UIColor clearColor];
    [self addSubview:aView];
    
    self.mtitleLabel =[UILabel labelWithText:@"" textColor:[UIColor whiteColor] fontSize:18 inView:self tapAction:^(UILabel *label, UIGestureRecognizer *tap) {
        
    }];
    @weakify(self);
    [self.mtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@17);
        make.top.equalTo(@32);
    }];
    
    
    self.leftBarButtonm = [UIButton buttonWithType:UIButtonTypeCustom];
     self.leftBarButton.frame =CGRectMake(0, 0, 44+50, 64);
    [self.leftBarButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.leftBarButton];
    
    
    self.leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftBarButton setImage:[UIImage imageNamed:@"top_back"] forState:UIControlStateNormal];
    self.leftBarButton.frame =CGRectMake(15, 20, 44, 44);
    self.leftBarButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
    [self.leftBarButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.leftBarButton];
    
    
    
    self.rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBarButton.frame =CGRectMake(SCREEN_WIDTH-60, 20, 60, 44);
    self.rightBarButton.titleLabel.font =[UIFont systemFontOfSize:16];
    [self.rightBarButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.rightBarButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    self.rightBarButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentCenter;
    [self.rightBarButton addTarget:self action:@selector(doNext) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.rightBarButton];
    self.rightBarButton.hidden=YES;
}


-(void)bindmodel
{
    RAC(self.leftBarButtonm,hidden) = RACObserve(self.leftBarButton, isHidden);
}

-(void)back
{
    if(self.block)
    {
        self.block();
    }
}

-(void)doNext
{
    if(self.doNextblock)
    {
        self.doNextblock();
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
