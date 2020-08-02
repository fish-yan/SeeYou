//
//  UIColor+Random.m
//  YSKit
//
//  Created by Joseph Gao on 16/4/25.
//  Copyright © 2016年 Joseph. All rights reserved.
//

#import "UIColor+Random.h"

@implementation UIColor (Random)

+ (UIColor *)randomColor {
    NSInteger aRedValue = arc4random() % 255;
    NSInteger aGreenValue = arc4random() % 255;
    NSInteger aBlueValue = arc4random() % 255;
    UIColor *randColor = [UIColor colorWithRed:aRedValue / 255.0f
                                         green:aGreenValue / 255.0f
                                          blue:aBlueValue / 255.0f
                                         alpha:1.0f];
    return randColor;
}

@end
