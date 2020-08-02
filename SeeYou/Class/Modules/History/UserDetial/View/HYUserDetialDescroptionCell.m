//
//  HYUserDetialDescroptionCell.m
//  youbaner
//
//  Created by luzhongchang on 17/8/2.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYUserDetialDescroptionCell.h"
#import "HYDetialDescriptionViewModel.h"
@interface HYUserDetialDescroptionCell()
@property(nonatomic ,strong) UILabel * titleLable;
@property(nonatomic ,strong) UILabel *descriotionLabel;
@property(nonatomic ,strong) HYDetialDescriptionViewModel * viewModel;
@end

@implementation HYUserDetialDescroptionCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self setUpviews];
        [self subviewslayout];
        [self bindmodel];
    
    }
    return self;
}


- (void)setUpviews
{
    self.titleLable =[UILabel labelWithText:@"交友条件" textColor:[UIColor tc31Color] fontSize:15 inView:self.contentView tapAction:nil];
    self.descriotionLabel = [UILabel labelWithText:@"" textColor:[UIColor tc7d7d7dColor] fontSize:15 inView:self.contentView tapAction:nil];
    self.descriotionLabel.textAlignment = NSTextAlignmentLeft;
    self.descriotionLabel.numberOfLines=0;
    
//    self.descriotionLabel.attributedText = [IndentifityAuthenDescriptionCell getNSMutableAttributedString:self.descriotionLabel.text];
}


- (void)subviewslayout
{
    @weakify(self);
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.contentView.mas_top).offset(20);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.width.equalTo(@60);
        make.height.equalTo(@15);
    }];
    
    
//    self.descriotionLabel.backgroundColor =[UIColor redColor];
    
    [self.descriotionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.titleLable.mas_top);
        make.left.equalTo(self.contentView.mas_left).offset(95);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
//        make.height.equalTo(@15);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-20).priorityLow();
    }];
    
}

- (void)bindWithViewModel:(HYBaseViewModel *)vm
{

    if(vm && [vm isKindOfClass:[HYDetialDescriptionViewModel class]])
    {
        self.viewModel =(HYDetialDescriptionViewModel*)vm;
    }
}

-(void)bindmodel
{

    [RACObserve(self, viewModel) subscribeNext:^(HYDetialDescriptionViewModel*  _Nullable x) {
        if(x)
        {
            self.titleLable.text = x.title;
            self.descriotionLabel.attributedText = x.des;
        }
        
    }];
    
//    RAC(self.titleLable,text) =RACObserve(self,viewModel.title);
//    RAC(self.descriotionLabel, attributedText) = RACObserve(self,viewModel.des);
}
@end
