//
//  LofinBaseinfoCell.h
//  youbaner
//
//  Created by luzhongchang on 2017/9/5.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseTableViewCell.h"

typedef void(^viewClickEvent)();
@interface LofinBaseinfoView : UIView
@property(nonatomic ,strong) UIImageView * iconImage;
@property(nonatomic ,strong) NSString * viewTitle;
@property(nonatomic ,strong) NSString * viewContent;
@property(nonatomic ,strong) UITextField * contextflied;
@property(nonatomic ,assign) Boolean  showArrow;
@property(nonatomic ,assign) int maxlength;
@property(nonatomic ,copy)viewClickEvent openViewblock;
@end
