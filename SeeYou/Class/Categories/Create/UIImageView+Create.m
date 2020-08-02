//
//  UIImageView+Create.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/1.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "UIImageView+Create.h"

@implementation UIImageView (Create)

+ (instancetype)imageViewWithImageName:(NSString *)imgName
                                inView:(__kindof UIView *)inView {
    UIImageView *imgView = [[UIImageView alloc] init];
    if (imgName && ![imgName isEqualToString:@""]) {
        imgView.image = [UIImage imageNamed:imgName];
    }
    if (inView && [inView isKindOfClass:[UIView class]]) {
        [inView addSubview:imgView];
    }
    return imgView;
}

+ (instancetype)imageViewWithImageName:(NSString *)imgName
                                inView:(__kindof UIView *)inView
                             tapAction:(void(^)(UIImageView *imgView, UIGestureRecognizer *tap))tapAction {
    UIImageView *imgView = [self imageViewWithImageName:imgName inView:inView];
    imgView.userInteractionEnabled = YES;
    
    if (tapAction) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [imgView addGestureRecognizer:tap];
        [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            tapAction(imgView, x);
        }];
    }
    
    return imgView;
}

@end
