//
//  HYCompleteInfoBaseVC.h
//  youbaner
//
//  Created by Joseph Koh on 2018/4/18.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYLoginRegisterBaseVC.h"
#import "HYCompleteInfoVM.h"

@interface HYCompleteInfoBaseVC : HYLoginRegisterBaseVC

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *stepLabel;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UILabel *descLabel;

@property (nonatomic, strong) HYCompleteInfoVM *viewModel;

- (void)setupSubviews;
- (void)setupSubviewsLayout;
@end
