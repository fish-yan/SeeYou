//
//  UIColor+Config.h
//  youbaner
//
//  Created by luzhongchang on 17/7/29.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import <UIKit/UIKit.h>
#define LBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
@interface UIColor (Config)
/// 文字颜色
+(UIColor*)tc0Color;
+(UIColor*)tc31Color;
+(UIColor*)tc69Color;
+(UIColor*)tcFCColor;
+(UIColor*)tc46aa78Color;
+(UIColor *)tcff8bb1Color;
+(UIColor*) tcfd5492Color;
+(UIColor *)tc6f6f6fColor;
+(UIColor *)tc949494Color;
+(UIColor*)tc4a4a4aColor;
+(UIColor*)tc464446Color;
+(UIColor*)tc7d7d7dColor;

+(UIColor*)tca6a6a6Color;
+(UIColor *)tcbcbcbcColor;
+(UIColor*)tca9a9a9Color;


//背景颜色
+(UIColor*)bg0Color;
+(UIColor*)bg2Color;
+(UIColor *)bgf5f5f5Color;
+(UIColor*)bg9b9b9bColor;
+(UIColor*)bg31313109Color;
+(UIColor *)bgff8bb1Color;
+(UIColor *)bgf7f7f7Color;
+(UIColor *)bge5e7e9Color;
+(UIColor *)bgf6f6f6Color;
+(UIColor *)bga1e65bColor;

+(UIColor *)bgff473dColor;

+(UIColor*)bgdbdbdbdColor;

//按钮颜色
+(UIColor*)bt0Color;

+(UIColor*)bt1Color;

//特殊颜色
+(UIColor*)sptc0Color;

+(UIColor*)line0Color;

+(UIColor*) linec3c3c3Color;
@end
