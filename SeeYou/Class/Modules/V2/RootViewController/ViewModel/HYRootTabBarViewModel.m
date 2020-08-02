//
//  HYRootTabBarViewModel.m
//  youbaner
//
//  Created by luzhongchang on 17/7/30.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYRootTabBarViewModel.h"
#import "HYNavigationController.h"



@implementation HYRootTabBarViewModel
-(instancetype)init
{
    if(self =[super init])
    {
        [self initialize];
    }
    return self;
}

-(void)initialize
{
    @weakify(self);
    self.configVCSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self);
        [subscriber sendNext:[self configControllers]];
        [subscriber sendCompleted];
        return nil;
    }];
}

/*配置controller and icon*/

-(NSArray *) configControllers
{
    NSString * configPath = [[NSBundle mainBundle] pathForResource:@"RootTabBarConfig.json" ofType:nil];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:configPath]
                                                     options:NSJSONReadingMutableContainers
                                                       error:nil];
    __block NSMutableArray *controllers = [NSMutableArray arrayWithCapacity:array.count];
    [array enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImage *normalImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_n", obj[@"img"]]];
        UIImage *selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_s", obj[@"img"]]];
        UIViewController *vc = [self viewControllerWithControllerClassString:obj[@"vcName"]
                                                                       title:obj[@"title"]
                                                       tabBarItemNormalImage:normalImage
                                                               selectedImage:selectedImage];
        vc.view.tag = idx + 88;
        [controllers addObject:vc];
    }];
    return controllers;
}


- (__kindof UIViewController *)viewControllerWithControllerClassString:(NSString *)classStr
                                                                 title:(NSString *)title
                                                 tabBarItemNormalImage:(UIImage *)normalImage
                                                         selectedImage:(UIImage *)selectedImage
{
    UIViewController *vc = [[NSClassFromString(classStr) alloc] init];
    vc.title = title;
    HYNavigationController *nav = [[HYNavigationController alloc] initWithRootViewController:vc];
    nav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, 100);
    nav.tabBarItem.imageInsets = UIEdgeInsetsMake(8, 0, -8, 0);
    [nav.tabBarItem setSelectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [nav.tabBarItem setImage:[normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [nav.tabBarItem setBadgeValue:nil];
    [nav.tabBarItem setBadgeTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:5]}
                                  forState:UIControlStateNormal];
    return nav;
}

@end
