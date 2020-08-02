//
//  WDProgressHUD.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/11.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDProgressHUD.h"
#import "MBProgressHUD.h"

#define TIPS_DURATION 1.5

@interface WDProgressHUD ()

@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation WDProgressHUD

+ (instancetype)shareHUD {
    static dispatch_once_t onceToken;
    static WDProgressHUD *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[WDProgressHUD alloc] init];
    });
    return instance;
}

+ (void)showTips:(NSString *)tips {
    WDProgressHUD *obj = [WDProgressHUD shareHUD];
    [obj.hud hideAnimated:YES];
    
    obj.hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    obj.hud.label.text = tips;
    obj.hud.mode = MBProgressHUDModeText;
    obj.hud.contentColor = [UIColor whiteColor];
    obj.hud.bezelView.color = [UIColor colorWithWhite:0.0 alpha:0.6];
    obj.hud.margin = 10.0;
    obj.hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(TIPS_DURATION * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [obj.hud hideAnimated:YES];
    });
    
//    UIView * bgview =[UIView viewWithBackgroundColor:[UIColor clearColor] inView:[UIApplication sharedApplication].keyWindow];
//    bgview.frame = SCREEN_BOUNDS;
//
//
//    UILabel * label = [UILabel labelWithText:tips textColor:[UIColor whiteColor] fontSize:14 inView:bgview  tapAction:nil];
//    label.textAlignment = NSTextAlignmentCenter;
//
//    CGSize titleSize = [tips sizeWithFont:label.font constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
//
//    float width = titleSize.width;
//    if(width >SCREEN_WIDTH-70)
//    {
//        width =SCREEN_WIDTH -70;
//    }
//
//
//    [label.layer setMasksToBounds:YES];
//    [label.layer setCornerRadius:5];
//    label.backgroundColor =[[UIColor  alloc] initWithRed:0 green:0 blue:0 alpha:0.7];
//    label.frame =CGRectMake((SCREEN_WIDTH-width-40)/2, SCREEN_HEIGHT/2-20, width+40, 40);
//
//
//    if(tips.length ==0)
//    {
//        label.alpha=0;
//    }
//
////    WDProgressHUD *obj = [WDProgressHUD shareHUD];
////    [obj.hud hideAnimated:YES];
////    obj.hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
////    obj.hud.customView = [UILabel labelWithText:tips textColor:[UIColor grayColor] fontSize:16 inView:[UIApplication sharedApplication].keyWindow tapAction:nil];
////
//////    obj.hud.label.text = tips;
//////    obj.hud.button.alpha=0;
//////    obj.hud.mode = MBProgressHUDModeText;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(TIPS_DURATION * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        [UIView animateWithDuration:0.3 animations:^{
//            bgview.alpha=0;
//            [bgview removeFromSuperview];
//        }];
//
//
//    });
}

+ (void)showInView:(UIView *)inView {
    if (!inView) {
        inView = [UIApplication sharedApplication].keyWindow;
    }
    return [self showInView:inView withTitle:@"努力加载中..."];
}

+ (void)showInView:(UIView *)inView withTitle:(NSString *)title {
    WDProgressHUD *obj = [WDProgressHUD shareHUD];    
    [obj.hud hideAnimated:YES];
    obj.hud = [MBProgressHUD showHUDAddedTo:inView animated:YES];
    obj.hud.animationType = MBProgressHUDAnimationFade;
    obj.hud.mode = MBProgressHUDModeCustomView;
    obj.hud.button.alpha=0;
    obj.hud.bezelView.color = [UIColor clearColor];
    obj.hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    
    if (title) {
        obj.hud.label.text = title;
        obj.hud.label.font = [UIFont systemFontOfSize:14.];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
//        UIImageView *imageView = [[UIImageView alloc] init];
//
//        NSArray *animationImages = [self animationImages];
//        imageView.animationImages = animationImages;
//        imageView.animationDuration = 0.12 * animationImages.count;
//        imageView.animationRepeatCount = 0;
//        [imageView startAnimating];
        
        UIActivityIndicatorView * v= [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [v startAnimating];
        
        obj.hud.customView = v;
    });
}

+ (NSArray *)animationImages {
    NSMutableArray *imgs = [NSMutableArray arrayWithCapacity:8];
    for (int i = 0; i < 8; i++) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"loading_%d", i+1]];
        if (img) [imgs addObject:img];
    }
    
    return imgs;
}

+ (void)hiddenHUD {
    WDProgressHUD *obj = [WDProgressHUD shareHUD];
    [obj.hud hideAnimated:YES];
}

+ (void)showIndeterminate {
    [self showIndeterminateWithTitle:nil];
}

+ (void)showIndeterminateWithTitle:(NSString *)title {
    WDProgressHUD *obj = [WDProgressHUD shareHUD];
    [obj.hud hideAnimated:YES];

    
    obj.hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    obj.hud.animationType = MBProgressHUDAnimationFade;
    obj.hud.label.font = [UIFont systemFontOfSize:14.];
    obj.hud.bezelView.color = [UIColor colorWithWhite:0.4 alpha:0.35];
    obj.hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    
    if (title) obj.hud.label.text = title;
}

@end
