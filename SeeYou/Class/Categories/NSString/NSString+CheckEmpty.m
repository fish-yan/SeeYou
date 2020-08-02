//
//  NSString+CheckEmpty.m
//  YSKit
//
//  Created by Joseph Gao on 16/4/22.
//  Copyright © 2016年 Joseph. All rights reserved.
//

#import "NSString+CheckEmpty.h"

@implementation NSString (CheckEmpty)

- (BOOL)isEmpty {
    /*
    NSString *checkContentMsg = self;
    checkContentMsg = [checkContentMsg stringByReplacingOccurrencesOfString:@" " withString:@""];
    checkContentMsg = [checkContentMsg stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    checkContentMsg = [checkContentMsg stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    
    if (checkContentMsg == nil || [checkContentMsg isEqualToString:@""]) {
        return YES;
    }
     
    return NO;
     
     */
    
    if (self == nil
        || [self isEqualToString:@""]
        || ![self isKindOfClass:[NSString class]] ) {
        return YES;
    }
    
    return NO;
}

- (NSString *)stringByTrimmingWhitespace {
    NSString *replaceStr = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return  replaceStr;
}

@end
