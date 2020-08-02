//
//  HYTransationDetailsCell.m
//  youbaner
//
//  Created by Joseph Koh on 2018/4/19.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYTransationDetailsCell.h"

@interface HYTransationDetailsCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UILabel *dateLabel;

@end

@implementation HYTransationDetailsCell


#pragma mark - Initialize

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initialize];
        [self setupSubviews];
        [self setupSubviewsLayout];
        [self bind];
    }
    return self;
}

- (void)initialize {
    self.showBottomLine = YES;
}


#pragma mark - Bind

- (void)bind {
    @weakify(self);
    [RACObserve(self, model) subscribeNext:^(HYTransationDetailsModel * _Nullable x) {
        @strongify(self);
        self.titleLabel.text = x.transtype;
        self.infoLabel.text = x.desc;
        self.countLabel.text = x.amount;
        self.dateLabel.text = x.date;
    }];
}


#pragma mark - Setup UI

- (void)setupSubviews {
    _titleLabel = [UILabel labelWithText:@""
                               textColor:[UIColor colorWithHexString:@"#313131"]
                                fontSize:16
                                  inView:self.contentView
                               tapAction:NULL];
    _infoLabel = [UILabel labelWithText:@""
                               textColor:[UIColor colorWithHexString:@"#A6A6A6"]
                                fontSize:14
                                  inView:self.contentView
                               tapAction:NULL];
    _countLabel = [UILabel labelWithText:@""
                               textColor:[UIColor colorWithHexString:@"#313131"]
                                fontSize:20
                                  inView:self.contentView
                               tapAction:NULL];
    _countLabel.font = [UIFont boldSystemFontOfSize:20];
    
    _dateLabel = [UILabel labelWithText:@""
                               textColor:[UIColor colorWithHexString:@"#BCBCBC"]
                                fontSize:13
                                  inView:self.contentView
                               tapAction:NULL];
}

- (void)setupSubviewsLayout {
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20);
        make.left.offset(15);
    }];
    
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(10);
        make.left.offset(15);
    }];
    
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_titleLabel);
        make.right.offset(-15);
    }];
    
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_infoLabel);
        make.right.offset(-15);
    }];
}


#pragma mark - Lazy Loading

@end
