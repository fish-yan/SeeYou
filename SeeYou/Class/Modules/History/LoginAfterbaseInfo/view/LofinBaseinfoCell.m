//
//  LofinBaseinfoCell.m
//  youbaner
//
//  Created by luzhongchang on 2017/9/5.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "LofinBaseinfoCell.h"

@interface LofinBaseinfoView()<UITextFieldDelegate>

@property(nonatomic ,strong) UILabel * siginLabel;

@property(nonatomic ,strong) UIView  * arrowView;

@property(nonatomic ,strong) UIView * lineView;
@end

@implementation LofinBaseinfoView
- (id)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if(self)
    {
        self.showArrow = YES;
        self.maxlength=0;
        
        self.backgroundColor =[UIColor whiteColor];
        [self setUpView];
        self.contextflied.enabled =NO;
        [self subviewslayout];
        [self bindmodel];
        [self.contextflied addTarget:self action:@selector(limit) forControlEvents:UIControlEventEditingChanged];
        
        UITapGestureRecognizer * ges =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doaction)];
        [self addGestureRecognizer:ges];
    }
    return self;
}



- (void)doaction
{
    
    [self.contextflied resignFirstResponder];
    
    if(self.openViewblock)
    {
        self.openViewblock();
    }
}

-(void) limit
{
    
    if(self.maxlength==0)
    {
        return;
    }
    
    if(self.contextflied.text.length>self.maxlength)
    {
        self.contextflied.text = [self.contextflied.text substringToIndex:self.maxlength];
    }
    
}

- (void) setUpView
{
    
    self.iconImage  =[UIImageView imageViewWithImageName:@"" inView:self];
    self.siginLabel =[UILabel labelWithText:@"" textColor:[UIColor tc7d7d7dColor] fontSize:14 inView:self tapAction:nil];
    
    self.contextflied =[UITextField textFieldWithText:@"" textColor:[UIColor tc7d7d7dColor] fontSize:14 andDelegate:self inView:self];
    self.contextflied.textAlignment =NSTextAlignmentRight;
    
    self.contextflied.returnKeyType=UIReturnKeyDone;
    self.arrowView = [UIImageView imageViewWithImageName:@"arrowright" inView:self];
    self.lineView =[UIView viewWithBackgroundColor:[UIColor line0Color] inView:self];
}


- (void)subviewslayout
{
    
    @weakify(self);
    
    
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(18, 18));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.siginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.iconImage.mas_right).offset(15);
        make.top.equalTo(self.mas_top).offset(14);
        make.bottom.equalTo(self.mas_bottom).offset(-14);
        
    }];
    
    
    
    
    [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerY.equalTo(self.siginLabel.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.equalTo(@15);
        make.width.equalTo(@8);
    }];
    
    [self.contextflied mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.siginLabel.mas_right).offset(10);
        make.centerY.equalTo(self.siginLabel.mas_centerY);
        make.right.equalTo(self.arrowView).offset(-15);
        make.height.equalTo(@16);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.mas_left).offset(20);
        make.bottom.equalTo(self.mas_bottom);
        make.top.equalTo(self.mas_bottom).offset(-0.5);
        make.right.equalTo(self.mas_right);
    }];
    
}


-(void)bindmodel
{
    
    RAC(self.siginLabel,text) = RACObserve(self, viewTitle);
    RAC(self.contextflied,text) =RACObserve(self, viewContent);
    
    @weakify(self);
    [RACObserve(self,showArrow) subscribeNext:^(NSNumber *  _Nullable x) {
        
        if([x boolValue])
        {
            
            
            self.arrowView.hidden=NO;
            [self.contextflied mas_remakeConstraints:^(MASConstraintMaker *make) {
                @strongify(self);
                make.left.equalTo(self.siginLabel.mas_right).offset(10);
                make.centerY.equalTo(self.siginLabel.mas_centerY);
                make.right.equalTo(self.arrowView).offset(-15);
                make.height.equalTo(@16);
            }];
        }
        else
        {
            
            self.arrowView.hidden=YES;
            [self.contextflied mas_remakeConstraints:^(MASConstraintMaker *make) {
                @strongify(self);
                make.left.equalTo(self.siginLabel.mas_right).offset(10);
                make.centerY.equalTo(self.siginLabel.mas_centerY);
                make.right.equalTo(self.mas_right).offset(-15);
                make.height.equalTo(@16);
            }];
            
        }
    }];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    return YES;
    
}

@end
