//
//  UIColor+Config.m
//  youbaner
//
//  Created by luzhongchang on 17/7/29.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "UIColor+Config.h"

@implementation UIColor (Config)
static const char *colorNameDB=","
"tc0#ffffff,tc31#313131,tc69#696969,tcFC#fc78a6,tc949494#949494,tc46aa78#46aa78,tcff8bb1#ff8bb1,tc6f6f6f#6f6f6f,tc4a4a4a#4a4a4a,#tc464446#464446,#tca6a6a6#a6a6a6,tcbcbcbc#bcbcbc,tc7d7d7d#7d7d7d,tca9a9a9#a9a9a9,tcfd5492#fd5492,"
"bg0#000000,bg2#fd5492,bg9b9b9b#9b9b9b,bg31313109#313131#0.3,bgdbdbdbd#dbdbdbd,bgff473d#ff473d,bgf5f5f5#f5f5f5,bgff8bb1#ff8bb1,bgf7f7f7#f7f7f7,bge5e7e9#e5e7e9,bgf6f6f6#f6f6f6,bga1e65b#a1e65b,"
"bt0#f97ba6,bt1#e7e7e7,"
"sptc0#fff5be,"
"line0#e7e7e7,linec3c3c3#c3c3c3,"
;
+(UIColor*)searchForColorByName:(NSString*)cssColorName
{
    UIColor *result = nil;
    const char *searchString = [[NSString stringWithFormat:@",%@#", cssColorName] UTF8String];
    const char *found = strstr(colorNameDB, searchString);
    if (found) {
        const char *after = found + strlen(searchString);
        int hex;
        if (sscanf(after, "%x", &hex) == 1) {
            result = [self colorWithHex:hex];
        }
    }
    
    return result;
}


#pragma mark color
+(UIColor*)tc0Color
{
    return [UIColor searchForColorByName:@"tc0"];
}


+(UIColor*)tc31Color
{
    return [UIColor searchForColorByName:@"tc31"];
}


+(UIColor*)tcFCColor
{
    return [UIColor searchForColorByName:@"tcFC"];
}

+(UIColor *)tc69Color
{
    return [UIColor searchForColorByName:@"tc69"];
}
+(UIColor *)tc949494Color
{
    return [UIColor searchForColorByName:@"tc949494"];
}

+(UIColor *)tc6f6f6fColor
{
     return [UIColor searchForColorByName:@"tc6f6f6f"];
}
+(UIColor *)tc46aa78Color
{
    return [UIColor searchForColorByName:@"tc46aa78"];
}

+(UIColor *)tcbcbcbcColor
{
    return [UIColor searchForColorByName:@"tcbcbcbc"];
}

+(UIColor*)tc7d7d7dColor
{
    return [UIColor searchForColorByName:@"tc7d7d7d"];
}



+(UIColor*) tcfd5492Color
{
    return [UIColor searchForColorByName:@"tcfd5492"];
}


+(UIColor*)tcff8bb1Color
{
    return [UIColor searchForColorByName:@"tcff8bb1"];
}
+(UIColor*)tc4a4a4aColor
{
    return [UIColor searchForColorByName:@"tc4a4a4a"];
}
+(UIColor*)tc464446Color
{
    return [UIColor searchForColorByName:@"tc464446"];
}
+(UIColor*)tca6a6a6Color
{
    return [UIColor searchForColorByName:@"tca6a6a6"];
}

+(UIColor*)tca9a9a9Color
{
    return [UIColor searchForColorByName:@"tca9a9a9"];
}

+(UIColor *)bge5e7e9Color
{
    return [UIColor searchForColorByName:@"bge5e7e9"];
}

+(UIColor*)bg0Color
{
     return [UIColor searchForColorByName:@"bg0"];
}

+(UIColor*)bg2Color
{
    return [UIColor searchForColorByName:@"bg2"];
}

+(UIColor*)bt0Color
{
     return [UIColor searchForColorByName:@"bt0"];
}

+(UIColor*)bg31313109Color
{
    return [UIColor searchForColorByName:@"bg31313109"];
}

+(UIColor*)bg9b9b9bColor
{
    return [UIColor searchForColorByName:@"bg9b9b9b"];
}
+(UIColor *)bgf6f6f6Color
{
    return [UIColor searchForColorByName:@"bgf6f6f6"];
}

+(UIColor *)bga1e65bColor
{
    return [UIColor searchForColorByName:@"bga1e65b"];
}


+(UIColor*)bgdbdbdbdColor
{
    return [UIColor searchForColorByName:@"bgdbdbdbd"];
}


+(UIColor *)bgff473dColor
{
    return [UIColor searchForColorByName:@"bgff473d"];
}

+(UIColor *)bgf5f5f5Color
{
    return [UIColor searchForColorByName:@"bgf5f5f5"];
}
+(UIColor *)bgff8bb1Color
{
    return [UIColor searchForColorByName:@"bgff8bb1"];
}
+(UIColor *)bgf7f7f7Color
{
    return [UIColor searchForColorByName:@"bgf7f7f7"];
}


+(UIColor*)bt1Color
{
    return  [UIColor searchForColorByName:@"bt1"];
}

+(UIColor*)sptc0Color
{
     return [UIColor searchForColorByName:@"sptc0"];
}

+(UIColor*)line0Color
{
    return [UIColor searchForColorByName:@"line0"];
}
+(UIColor*) linec3c3c3Color
{
    return [UIColor searchForColorByName:@"linec3c3c3"];
}

@end
