//
//  HYShowPicCell.h
//  youbaner
//
//  Created by luzhongchang on 17/8/8.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseTableViewCell.h"

typedef void(^clickImageBlock)(int index); //index==10000 说明是添加按钮

@interface HYShowPicCell : HYBaseTableViewCell<UICollectionViewDataSource, UICollectionViewDelegate>
@property(nonatomic ,strong) UILabel * titleLabel;
@property(nonatomic ,strong) UICollectionView * collectView;
@property(nonatomic ,strong) NSArray * MyServiceArray;
@property(nonatomic ,assign) BOOL isShowAdd;
@property(nonatomic ,strong) UIButton * button ;
@property(nonatomic ,assign) BOOL delButton;

@property(nonatomic ,strong) clickImageBlock block;






+(CGFloat)GetHeight:( NSInteger)serviceCount;
-(void)updateArray:(NSArray *)array;
@end
