//
//  HYExclusiveGreetVC.h
//  youbaner
//
//  Created by Joseph Koh on 2018/4/17.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYBaseViewController.h"

@interface HYExclusiveGreetVC : HYBaseViewController

@property (nonatomic, copy) void(^cancleClickHandler)(void);
@property (nonatomic, copy) void(^submitClickHandler)(NSString *content);

@end
