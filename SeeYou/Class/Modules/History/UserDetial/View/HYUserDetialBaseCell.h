//
//  HYUserDetialBaseCell.h
//  youbaner
//
//  Created by luzhongchang on 17/8/2.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseTableViewCell.h"

@interface HYUserDetialBaseCell : HYBaseTableViewCell

- (void)bindWithViewModel:(HYBaseViewModel*)vm;

+(CGFloat) getHeight:(HYBaseViewModel *)vm;
@end

