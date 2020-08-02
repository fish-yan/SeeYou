//
//  HYTopPayViewController.h
//  youbaner
//
//  Created by Joseph Koh on 2018/6/19.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYBaseViewController.h"
#import "HYTopPayVM.h"

@interface HYTopPayViewController : HYBaseViewController

//@property (nonatomic, assign) HYPopPayType type;
@property (nonatomic, copy) void(^payResult)(BOOL isSuccess);

@end
