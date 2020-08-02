//
//  HYUserInfoHeaderCell.m
//  youbaner
//
//  Created by Joseph Koh on 2018/6/15.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYUserInfoHeaderCell.h"

@interface HYUserInfoHeaderCell ()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation HYUserInfoHeaderCell

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
    self.clipsToBounds = YES;
}


#pragma mark - Bind

- (void)bind {
    @weakify(self);
    [RACObserve(self, cellModel.value) subscribeNext:^(NSString * _Nullable x) {
        if (!x || x.length == 0) return;
        
        @strongify(self);
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:x]
                        placeholderImage:[UIImage imageNamed:@"user_info_placeholder"]];
    }];
}


#pragma mark - Setup UI

- (void)setupSubviews {
    _imgView = [UIImageView imageViewWithImageName:@"user_info_placeholder" inView:self.contentView];
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)setupSubviewsLayout {
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}


#pragma mark - Lazy Loading

@end
