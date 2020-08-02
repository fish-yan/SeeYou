//
//  WDRefreshGifHeader.m
//  HCDoctor
//
//  Created by Joseph Gao on 2017/6/8.
//  Copyright © 2017年 WondersGroup.com. All rights reserved.
//

#import "WDRefreshGifHeader.h"

@implementation WDRefreshGifHeader

#pragma mark - 重写方法
#pragma mark 基本设置

- (void)prepare {
    [super prepare];
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (int i = 1; i < 15 ; i++) {
        NSString *imageString = [NSString stringWithFormat:@"下拉加载%d",i];
        UIImage *image = [UIImage imageNamed:imageString];
        [images addObject:image];
    }
    
    // 设置普通状态
    [self setImages:@[images[0]] forState:MJRefreshStateIdle];
    [self setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态
    [self setImages:images forState:MJRefreshStatePulling];
    [self setImages:images duration:0.6 forState:MJRefreshStatePulling];
    [self setTitle:@"松开后刷新" forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:images forState:MJRefreshStateRefreshing];
    [self setImages:images duration:0.5 forState:MJRefreshStateRefreshing];
    [self setTitle:@"正在刷新中..." forState:MJRefreshStateRefreshing];
    
    // 设置字体和颜色
    self.stateLabel.font = [UIFont systemFontOfSize:12];
    self.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:10];
    self.stateLabel.textColor = [UIColor tc31Color];
    self.lastUpdatedTimeLabel.textColor = [UIColor tc69Color];
    
    // 设置自动切换透明度,下拉时alpha属性从0-1
    self.automaticallyChangeAlpha = YES;
}
@end
