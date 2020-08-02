//
//  HYHomeContentVC.h
//  youbaner
//
//  Created by Joseph Koh on 2018/4/16.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYBaseViewController.h"
#import "HYHomeContentVM.h"


@interface HYHomeContentVC : HYBaseViewController

@property (nonatomic, assign) HomeContentType type;

- (void)updataWithFilterInfos:(NSDictionary *)filterInfos;

@end
