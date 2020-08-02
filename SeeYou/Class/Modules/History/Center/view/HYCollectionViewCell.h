//
//  HYCollectionViewCell.h
//  youbaner
//
//  Created by luzhongchang on 17/8/8.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYShoePhotosViewModel.h"

@interface HYCollectionViewCell : UICollectionViewCell
@property( nonatomic ,strong) UIImageView * mImageView;
@property( nonatomic ,strong) UIView *bgView;
@property(nonatomic ,strong) UIButton *deleteButton;
@property(nonatomic ,strong) HYShoePhotosViewModel * viewModel;


- (void)bindWithViewModel:(HYBaseViewModel*)vm;


@end
