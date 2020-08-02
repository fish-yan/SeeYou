//
//  NSString+Ext.m
//  CNHealthCloudPatient
//
//  Created by Joseph Gao on 16/5/24.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "NSString+Ext.h"

@implementation NSString (Ext)

-(NSString *)hiddenMiddleStringOfIdCard {
    if (self.length < 16) return self;

    NSMutableString *str = [NSMutableString stringWithString:self];    
    [str replaceCharactersInRange:NSMakeRange(4, self.length - 7) withString:@"***********"];
    return str;
}

-(NSString *)hiddenMiddleStringOfPhoneNumber {
    if (self.length < 11) return self;

    NSMutableString *str = [NSMutableString stringWithString:self];
    [str replaceCharactersInRange:NSMakeRange(3, self.length - 7) withString:@"****"];
    
    return str;
}

- (NSString *)delMiddleSapce{

    return  [self stringByReplacingOccurrencesOfString:@" " withString:@""];

}
//手机号格式数据
- (NSString *)PhoneNumberFormatString{

    NSMutableString * str = [NSMutableString stringWithString:self];
    if(str.length >3){
        [str insertString:@" " atIndex:3];
    }
    if (str.length > 8) {
        [str insertString:@" " atIndex:8];
    }

    return [NSString stringWithString:str];
}
@end
