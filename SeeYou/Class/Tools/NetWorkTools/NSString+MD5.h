//
//  NSString+MD5.h
//  youbaner
//
//  Created by luzhongchang on 17/8/12.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (MD5)

+(NSString *) MD5:(NSString*)mdStr;
+(NSString * )getBodyString:(NSDictionary *)dic;
+(NSString*)StringMd5:(NSString*)md5string;
+(NSString * ) AESString:(NSString *) string;


@end
