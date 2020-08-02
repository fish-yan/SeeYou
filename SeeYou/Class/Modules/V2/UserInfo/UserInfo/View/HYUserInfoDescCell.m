//
//  HYUserInfoDescCell.m
//  youbaner
//
//  Created by Joseph Koh on 2018/6/17.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYUserInfoDescCell.h"

@interface HYUserInfoDescCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *infoLabel;

@end
@implementation HYUserInfoDescCell


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
    self.showBottomLine = NO;
}


#pragma mark - Bind

- (void)bind {
//    @weakify(self);
//    [RACObserve(self, cellModel) subscribeNext:^(HYUserInfoCellModel * _Nullable x) {
//        @strongify(self);
//        self.titleLabel.text = x.title;
//        self.infoLabel.text = x.desc;
//    }];
    RAC(self.titleLabel, text) = RACObserve(self, cellModel.title);
    RAC(self.infoLabel, text) = RACObserve(self, cellModel.desc);
}


#pragma mark - Setup UI

- (void)setupSubviews {
    _titleLabel = [UILabel labelWithText:nil
                               textColor:[UIColor colorWithHexString:@"#313131"]
                                fontSize:14
                                  inView:self.contentView
                               tapAction:NULL];
    
    _infoLabel = [UILabel labelWithText:nil
                              textColor:[UIColor colorWithHexString:@"#7D7D7D"]
                               fontSize:14
                                 inView:self.contentView
                              tapAction:NULL];
    _infoLabel.numberOfLines = 0;
}

- (void)setupSubviewsLayout {
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(20);
    }];
    
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(15);
        make.left.equalTo(_titleLabel);
        make.right.offset(-15);
        make.bottom.offset(-20);
    }];
    
}


@end
