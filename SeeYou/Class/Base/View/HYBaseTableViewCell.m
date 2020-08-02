//
//  HYBaseTableViewCell.m
//  youbaner
//
//  Created by luzhongchang on 17/7/29.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseTableViewCell.h"


@interface HYBaseTableViewCell ()
@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic ,strong) UIView *shortBottomLine;

@end

@implementation HYBaseTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self setupSeperatorLine];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if ([self respondsToSelector:@selector(setSeparatorInset:)] ||
            [self respondsToSelector:@selector(setLayoutMargins:)]) {
            [self setSeparatorInset:UIEdgeInsetsZero];
        }
        
        [self setupSeperatorLine];
    }
    return self;
}

- (void)setupSeperatorLine {
    self.topLine = [self addLine];
    self.topLine.hidden = YES;
    
    self.bottomLine = [self addLine];
    self.bottomLine.hidden = YES;
    
    self.shortBottomLine = [self addLine];
    self.shortBottomLine.hidden = YES;
    
    
    
    CGFloat lineH = 0.5;
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(lineH);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(lineH);
    }];
    
    [self.shortBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.height.mas_equalTo(lineH);
    }];
}

- (UIView *)addLine {
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor line0Color];
    [self.contentView addSubview:v];
    return v;
}


- (void)setShowTopLine:(BOOL)showTopLine {
    _showTopLine = showTopLine;
    self.topLine.hidden = !showTopLine;
}

- (void)setShowBottomLine:(BOOL)showBottomLine {
    _showBottomLine = showBottomLine;
    self.bottomLine.hidden = !showBottomLine;
}

-(void) setShowShortBottonLine:(BOOL)showShortBottonLine
{
    
    _showShortBottonLine = showShortBottonLine;
    self.shortBottomLine.hidden = !showShortBottonLine;

}

@end
