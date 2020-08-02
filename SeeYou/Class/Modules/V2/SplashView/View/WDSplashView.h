//
//  WDSplashView.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/3.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "HYBaseView.h"

@interface WDSplashView : HYBaseView

@property (nonatomic, strong) RACCommand *showCommand;
- (void)bindWithViewModel:(HYBaseViewModel *)vm;
@end
