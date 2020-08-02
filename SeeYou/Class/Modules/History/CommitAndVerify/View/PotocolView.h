//
//  PotocolView.h
//  youbaner
//
//  Created by luzhongchang on 17/8/1.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^closeBlock)();
@interface PotocolView : UIView

@property(nonatomic ,copy)closeBlock block;
@end
