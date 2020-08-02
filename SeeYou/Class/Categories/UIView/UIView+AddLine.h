//
//  UIView+AddLine.h
//  HCDoctor
//
//  Created by Joseph Gao on 2017/5/19.
//  Copyright © 2017年 Jam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AddLine)

/**
 添加线条

 @param lineColor 线条颜色, 默认灰色
 @param width 线条宽度
 @param height 线条高度
 @return 线条对象本身
 */
- (UIView *)addLineWithColor:(UIColor *)lineColor width:(CGFloat)width height:(CGFloat)height;

/**
 添加线条
 
 @param lineColor 线条颜色, 默认灰色
 @param width 线条宽度
 @param height 线条高度
 @return 线条对象本身
 */
+ (UIView *)lineViewWithColor:(UIColor *)lineColor
                        width:(CGFloat)width
                       height:(CGFloat)height
                       inView:(UIView *)inView;

@end
