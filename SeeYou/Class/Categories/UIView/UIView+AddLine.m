//
//  UIView+AddLine.m
//  HCDoctor
//
//  Created by Joseph Gao on 2017/5/19.
//  Copyright © 2017年 Jam. All rights reserved.
//

#import "UIView+AddLine.h"

@implementation UIView (AddLine)

- (UIView *)addLineWithColor:(UIColor *)lineColor width:(CGFloat)width height:(CGFloat)height {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    line.backgroundColor = lineColor ?: [UIColor grayColor];
    
    [self addSubview:line];
    
    return line;
}

+ (UIView *)lineViewWithColor:(UIColor *)lineColor
                        width:(CGFloat)width
                       height:(CGFloat)height
                       inView:(UIView *)inView {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    line.backgroundColor = lineColor ?: [UIColor grayColor];
    
    if (inView && [inView isKindOfClass:[UIView class]]) {
        [inView addSubview:line];
    }
    
    return line;
}
@end
