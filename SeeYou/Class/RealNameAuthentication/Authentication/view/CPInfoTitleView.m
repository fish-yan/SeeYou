//
//  CPInfoTitleView.m
//  CPPatient
//
//  Created by luzhongchang on 2017/8/30.
//  Copyright © 2017年 Jam. All rights reserved.
//

#import "CPInfoTitleView.h"

@interface  CPInfoTitleView()
@property(nonatomic ,strong)UILabel * titleLabel;
@property(nonatomic ,strong)UIButton * doButton;
@end

@implementation CPInfoTitleView

- (id) initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if(self)
    {
        self.ishideButton=NO;
        [self setUpview];
        [self bindModel];

    
    }
    return self;
}

- (void) setUpview
{
    @weakify(self);
    self.titleLabel =[UILabel labelWithText:@"" textColor:[UIColor redColor] fontSize:14 inView:self tapAction:nil];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.doButton =[UIButton buttonWithTitle:@"示例参考" titleColor:[UIColor redColor] fontSize:14 bgColor:[UIColor clearColor] inView:self action:^(UIButton *btn) {
        @strongify(self)
        if(self.block)
        {
            self.block();
        }
        
    }];

 
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.top.equalTo(self.mas_top).offset(13);
        make.bottom.equalTo(self.mas_bottom).offset(-13);
      
        
    }];
    
    [self.doButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.equalTo(self.mas_right).offset(-15);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.width.equalTo(@60);
        
    }];
    
}

-(void)setTitleString:(NSString *)titleString
{
    self.titleLabel.text = titleString;
}

-(void) bindModel
{

    RAC(self.doButton ,hidden) = RACObserve(self, ishideButton);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
