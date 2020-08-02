//
//  HYRootTabBarViewController.m
//  youbaner
//
//  Created by luzhongchang on 17/7/30.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYRootTabBarViewController.h"
#import "HYRootTabBarViewModel.h"

@interface HYRootTabBarViewController ()

@property(nonatomic ,strong) HYRootTabBarViewModel * viewModel;
@property(nonatomic ,strong) UIImageView *backImageView;

@end

@implementation HYRootTabBarViewController
#pragma mark -- life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialize];
    [self bind];
    
    [[HYUnreadInfoFetcher shareInstance].unreadMsgCmd execute:nil];
//    [self.viewModel.unreadMsgCmd execute:nil];
}


#pragma mark - bind


-(void)bind{
    self.viewModel =[[HYRootTabBarViewModel alloc] init];
    @weakify(self);
    [self.viewModel.configVCSignal subscribeNext:^(NSArray *  _Nullable x) {
        @strongify(self);
        self.viewControllers = x;
    }];
    
}

-(void) initialize
{
    //去掉系统的线
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance] setBarTintColor: [UIColor whiteColor]];  // 修改tabBar颜色
    
    // 设置背景图片
    self.backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49.)];
    self.backImageView.backgroundColor=[UIColor whiteColor];
    self.backImageView.clipsToBounds = YES;
    [self.tabBar insertSubview:self.backImageView atIndex:0];
    
    // 顶部添加线条
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(0, 0, self.tabBar.frame.size.width, 0.5);
    line.backgroundColor = [UIColor bgf7f7f7Color];
    [self.tabBar addSubview:line];
    [self.tabBar bringSubviewToFront:line];
}


 /// 每次点击底部tabBar都请求消息数据
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
//    NSUInteger indexOfTap = [tabBar.items indexOfObject:item];
//    if (indexOfTap == TABBAR_ITEM_INDEX_MESSAGE) return;    // 数据在消息控制器 viewWillAppear中请求, 避免重复请求
    
    [[HYUnreadInfoFetcher shareInstance].unreadMsgCmd execute:nil];
}

@end
