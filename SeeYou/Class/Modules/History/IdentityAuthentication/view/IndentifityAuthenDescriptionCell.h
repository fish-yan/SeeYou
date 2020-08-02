//
//  IndentifityAuthenDescriptionCell.h
//  youbaner
//
//  Created by luzhongchang on 17/8/1.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseTableViewCell.h"
@class IndentifityAuthenDescriptionModel;
@interface IndentifityAuthenDescriptionCell : HYBaseTableViewCell

- (void)BindModel:(IndentifityAuthenDescriptionModel*)model;
+(NSMutableAttributedString*)getNSMutableAttributedString:(NSString *)string;
@end
