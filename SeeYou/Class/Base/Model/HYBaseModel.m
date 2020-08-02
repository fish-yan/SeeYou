//
//  HYBaseModel.m
//  youbaner
//
//  Created by luzhongchang on 17/7/29.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseModel.h"

@implementation HYBaseModel

- (NSString *)debugDescription {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    uint count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i<count; i++) {
        objc_property_t property = properties[i];
        NSString *name = @(property_getName(property));
        id value = [self valueForKey:name] ?: [NSNull null];
        [dictionary setObject:value forKey:name];
    }
    
    free(properties);
    
    return [NSString stringWithFormat:@"<%@: %p>\n%@", [self class], self,dictionary];
}

@end
