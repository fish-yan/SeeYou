//
//  WDRefresher.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/12.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDRefresher.h"
#import "WDRefreshNormalHeader.h"
#import "WDRefreshGifHeader.h"
#import "WDRefreshFooter.h"

@implementation WDRefresher

#pragma mark - Header Refresh

+ (__kindof MJRefreshHeader *)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action {
    return [WDRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:action];
//    return [WDRefreshGifHeader headerWithRefreshingTarget:target refreshingAction:action];
}

+ (__kindof MJRefreshHeader *)headerWithRefreshingBlock:(void(^)(void))refreshingBlock {
    return [WDRefreshNormalHeader headerWithRefreshingBlock:refreshingBlock];
//    return [WDRefreshGifHeader headerWithRefreshingBlock:refreshingBlock];
}


#pragma mark - Footer Refresh

+ (__kindof MJRefreshFooter *)footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action {
    return [WDRefreshFooter footerWithRefreshingTarget:target refreshingAction:action];
}

+ (__kindof MJRefreshFooter *)footerWithRefreshingBlock:(void(^)(void))refreshingBlock {
    return [WDRefreshFooter footerWithRefreshingBlock:refreshingBlock];
}



@end
