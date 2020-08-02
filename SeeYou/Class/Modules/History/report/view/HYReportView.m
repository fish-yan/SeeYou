//
//  HYReportView.m
//  youbaner
//
//  Created by luzhongchang on 2017/9/20.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYReportView.h"

@interface HYReportView()
@property(nonatomic,strong) UILabel * titleLabel;

@property(nonatomic,strong) UILabel * tipLabel;
@property(nonatomic ,strong) UILabel * ImageNUmberLabel;
@property(nonatomic ,strong) UILabel * ImageInstructLabel;

@property(nonatomic ,strong) UIImageView * arrowImageview;


@end
/*230*/
@implementation HYReportView

-(id)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if(self)
    {
        [self setUpview];
        [self subviewLayout];
    
        [self bindmodel];
    }
    return self;
}


-(void)setUpview
{

   
    self.titleLabel =[UILabel labelWithText:@"上传证明材料" textColor:[ UIColor tc31Color] fontSize:16 inView:self tapAction:nil];
    self.imageBG =[UIView viewWithBackgroundColor:[UIColor clearColor] inView:self];
    [self.imageBG.layer setMasksToBounds:YES];
    [self.imageBG.layer setCornerRadius:5];
    [self.imageBG.layer setBorderWidth:0.5];
    [self.imageBG.layer setBorderColor:[UIColor bgdbdbdbdColor].CGColor];
    
    UITapGestureRecognizer * ges =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showactionsheet) ];
    [self.imageBG addGestureRecognizer:ges];
    
    
    self.tipLabel =[UILabel labelWithText:@"上传图片"
                                textColor:[UIColor tc7d7d7dColor]
                                 fontSize:16
                                   inView:self
                                tapAction:nil];
    
    self.ImageNUmberLabel =[UILabel labelWithText:@"已选择1张"
                                textColor:[UIColor tc7d7d7dColor]
                                 fontSize:16
                                   inView:self
                                tapAction:nil];
    
    
    self.arrowImageview=[UIImageView imageViewWithImageName:@"arrowright" inView:self.imageBG];
    
    
    
    self.ImageInstructLabel=[UILabel labelWithText:@"请上传1-6张可以证明投诉内容的照片"
                                         textColor:[UIColor tc7d7d7dColor]
                                          fontSize:12
                                            inView:self
                                         tapAction:nil];
    
    
    self.textView =[[WDNumTextView  alloc] initWithFrame:CGRectMake(15, 130, SCREEN_WIDTH-30, 70)];
    self.textView.placeholder=@"描述内容(非必填)";
    self.textView.limitNum=100;
    [self addSubview:self.textView];
    
}

-(void)subviewLayout
{
    @weakify(self);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_top).offset(18);
        make.height.equalTo(@16);
    }];
    
    [self.imageBG mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(18);
        make.height.equalTo(@35);
    }];
    
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.imageBG.mas_left).offset(8);
        make.centerY.equalTo(self.imageBG.mas_centerY);
        make.height.equalTo(@16);
    }];
    
    [self.arrowImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.equalTo(self.imageBG.mas_right).offset(-8);
        make.centerY.equalTo(self.imageBG.mas_centerY);
        make.height.equalTo(@14);
        make.width.equalTo(@8);
    }];
    
    [self.ImageNUmberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.equalTo(self.arrowImageview.mas_left).offset(-8);
        make.centerY.equalTo(self.imageBG.mas_centerY);
        make.height.equalTo(@16);
    }];
    
    [self.ImageInstructLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.mas_left).offset(15);
        make.height.equalTo(@14);
        make.right.equalTo(self.mas_right).offset(-15);
        make.top.equalTo(self.imageBG.mas_bottom).offset(13);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.top.equalTo(self.ImageInstructLabel.mas_bottom).offset(13);
        make.height.equalTo(@70);
    }];
    
    
    
    
    
    
    
}

-(void) showactionsheet
{
    
    if(self.block)
    {
        self.block();
    }
}

-(void)bindmodel
{
    @weakify(self);
    [RACObserve(self,picNumber ) subscribeNext:^(NSString *   _Nullable x) {
        
        @strongify(self);
        if(x)
        {
            self.ImageNUmberLabel.text =[NSString stringWithFormat:@"已选择%@张",x ];
        }
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
