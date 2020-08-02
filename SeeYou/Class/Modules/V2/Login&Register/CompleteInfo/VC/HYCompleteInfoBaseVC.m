//
//  HYCompleteInfoBaseVC.m
//  youbaner
//
//  Created by Joseph Koh on 2018/4/18.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYCompleteInfoBaseVC.h"

@interface HYCompleteInfoBaseVC()

@end

@implementation HYCompleteInfoBaseVC

#pragma mark - Life Circle

- (instancetype)init {
    if (self = [super init]) {
        self.viewModel = [HYCompleteInfoVM new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubviews];
    [self setupSubviewsLayout];
}

#pragma mark - Setup Subviews

- (void)setupSubviews {
    _titleLabel = [UILabel labelWithText:nil
                               textColor:[UIColor whiteColor]
                           textAlignment:NSTextAlignmentCenter
                                fontSize:30
                                  inView:self.view
                               tapAction:NULL];
    _stepLabel = [UILabel labelWithText:nil
                               textColor:[UIColor whiteColor]
                           textAlignment:NSTextAlignmentCenter
                                fontSize:14
                                  inView:self.view
                               tapAction:NULL];
    _infoLabel = [UILabel labelWithText:nil
                               textColor:[UIColor whiteColor]
                           textAlignment:NSTextAlignmentCenter
                                fontSize:20
                                  inView:self.view
                               tapAction:NULL];
    _descLabel = [UILabel labelWithText:nil
                               textColor:[UIColor whiteColor]
                           textAlignment:NSTextAlignmentCenter
                                fontSize:16
                                  inView:self.view
                               tapAction:NULL];
}

- (void)setupSubviewsLayout {
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.offset(80);
    }];
    
    [_stepLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_titleLabel.mas_bottom).offset(10);
    }];
    
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_stepLabel.mas_bottom).offset(25);
    }];
    
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_infoLabel.mas_bottom).offset(10);
    }];

}


#pragma mark - Lazy Loading

@end
