//
//  HYUserBaseInfoCell.h
//  youbaner
//
//  Created by luzhongchang on 17/8/2.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseTableViewCell.h"

@interface HYUserBaseInfoCell : HYBaseTableViewCell
@property(nonatomic ,strong) UILabel * infoLabel;
- (void) bindWithViewModel:(HYBaseViewModel *)vm;
@end
