//
//  HYNavigationController.m
//  youbaner
//
//  Created by luzhongchang on 17/7/29.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYNavigationController.h"

@interface HYNavigationController ()<UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@end

@implementation HYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //左滑返回
    @weakify(self);
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        @strongify(self);
        self.interactivePopGestureRecognizer.delegate = self;
        
        self.delegate = self;
    }
    [self setNavigationBarAppearance];
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    return [super popToRootViewControllerAnimated:animated];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    return [super popToViewController:viewController animated:animated];
}


#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        if (self.viewControllers.count < 2 || self.visibleViewController == [self.viewControllers objectAtIndex:0]) {
            return NO;
        }
    }
    
    return YES;
}

- (void)setNavigationBarAppearance {
    [self.navigationBar setBackgroundImage:[self barBackgroundImage] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setTitleTextAttributes:@{
        NSFontAttributeName: Font_PINGFANG_SC(18),
        NSForegroundColorAttributeName: [UIColor tc31Color]
    }];
    [self setBackButtonWithImage];

    if ([UINavigationBar instancesRespondToSelector:@selector(setShadowImage:)]) {
        [[UINavigationBar appearance]
        setShadowImage:[self imageWithColor:[UIColor bgf6f6f6Color] size:CGSizeMake(SCREEN_WIDTH, 1)]];
    }
}

- (void)setBackButtonWithImage {
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-100, 0) forBarMetrics:UIBarMetricsDefault];
    UIImage *img = [UIImage imageNamed:@"top_back"];
    [UINavigationBar appearance].backIndicatorImage = img;
    [UINavigationBar appearance].backIndicatorTransitionMaskImage = img;
    [UINavigationBar appearance].tintColor = [UIColor colorWithHexString:@"#313131"];

}

- (UIImage *)barBackgroundImage {
    return [UIImage imageOfGradientColorWithColors:@[[UIColor colorWithHexString:@"ffffff"],
                                                     [UIColor colorWithHexString:@"ffffff"]]
                                         locations:@[@0, @1.0]
                                      andImageSize:CGSizeMake(SCREEN_WIDTH, 64)];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size

{
    
    
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
        UIGraphicsBeginImageContext(rect.size);
    
        CGContextRef context = UIGraphicsGetCurrentContext();
    
        CGContextSetFillColorWithColor(context,
                                       
                                       color.CGColor);
    
        CGContextFillRect(context, rect);
    
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
        UIGraphicsEndImageContext();
    
    
    
        return img;
    
}


@end
