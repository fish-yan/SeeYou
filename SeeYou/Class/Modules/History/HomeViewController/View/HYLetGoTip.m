//
//  HYLetGoTip.m
//  youbaner
//
//  Created by luzhongchang on 17/7/31.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYLetGoTip.h"

@interface HYLetGoTip()
@property(nonatomic ,strong) UIImageView *imgaeview;

@end

@implementation HYLetGoTip

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor =[[UIColor alloc] initWithRed:49.0/255.0 green:49.0/255.0 blue:49.0/255.0 alpha:0.9];;
        [self subViews];
        [self setSubLayout];
        
    }
    return self;
}


- (void)subViews
{
    self.imgaeview =[UIImageView imageViewWithImageName:@"letsGo" inView:self];
   
    
}


- (void)setSubLayout
{
    @weakify(self);
    [self.imgaeview mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(@66);
        make.width.equalTo(@142);
        make.bottom.equalTo(self.mas_bottom).offset(-30);
       
    }];
}
@end
