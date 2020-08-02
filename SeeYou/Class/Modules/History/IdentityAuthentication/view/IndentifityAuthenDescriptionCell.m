//
//  IndentifityAuthenDescriptionCell.m
//  youbaner
//
//  Created by luzhongchang on 17/8/1.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "IndentifityAuthenDescriptionCell.h"
#import "IndentifityAuthenDescriptionModel.h"
@interface  IndentifityAuthenDescriptionCell()
@property(nonatomic ,strong) UIImageView *iconImageview;
@property(nonatomic ,strong) UILabel *titleLabel;
@property(nonatomic ,strong) UILabel *descriptionLabel;
@end
//97-64 //33
@implementation IndentifityAuthenDescriptionCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self setUpview];
        [self subviewLayout];
    }
    return self;
}



- (void)setUpview
{//26


    self.iconImageview =[UIImageView imageViewWithImageName:@"" inView:self.contentView];
    self.titleLabel =[UILabel labelWithText:@"为什么要身份认证" textColor:[UIColor tc4a4a4aColor] fontSize:16 inView:self.contentView tapAction:nil];
    self.descriptionLabel =[UILabel labelWithText:@"为神马要身份认证" textColor:[UIColor tc7d7d7dColor] fontSize:14 inView:self.contentView tapAction:nil];
    self.descriptionLabel.numberOfLines=0;
    self.descriptionLabel.textAlignment=NSTextAlignmentLeft;
    
}


- (void)subviewLayout
{
    @weakify(self);
    [self.iconImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.contentView.mas_top).offset(33);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(20, 18));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.contentView.mas_top).offset(33);
        make.left.equalTo(self.iconImageview.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.height.equalTo(@16);
    }];
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         @strongify(self);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
        make.left.equalTo(self.titleLabel.mas_left);
        make.right.equalTo(self.titleLabel.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}


- (void)BindModel:(IndentifityAuthenDescriptionModel*)model
{

    self.iconImageview.image =[UIImage imageNamed:model.iconName];
    self.titleLabel.text =model.title;
    self.descriptionLabel.attributedText = [IndentifityAuthenDescriptionCell getNSMutableAttributedString:model.des];
    
    
}

+(NSMutableAttributedString*)getNSMutableAttributedString:(NSString *)string
{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:0];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
    return attributedString;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
