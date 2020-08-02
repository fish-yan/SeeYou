//
//  NSString+Ext.h
//  CNHealthCloudPatient
//
//  Created by Joseph Gao on 16/5/24.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Ext)

-(NSString *)hiddenMiddleStringOfIdCard;
-(NSString *)hiddenMiddleStringOfPhoneNumber;

- (NSString *)delMiddleSapce;
//手机号格式数据
- (NSString *)PhoneNumberFormatString;

@end
