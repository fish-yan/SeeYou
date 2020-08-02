//
//  NSString+MD5.m
//  youbaner
//
//  Created by luzhongchang on 17/8/12.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "NSString+MD5.h"
#import <CommonCrypto/CommonDigest.h>

#define HY_KEY_SECRECT @"Gwn1zaQtCPUnd688jIruSS6gZvfShvNB"
@implementation NSString (MD5)


+(NSString *) MD5:(NSString*)mdStr
{
    
    const char *original_str = [mdStr UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}


+(NSString * )getBodyString:(NSDictionary *)dic
{
 
    
    
    NSMutableArray *array =[NSMutableArray new];
    
    for (int i=0; i<dic.count; i++)
    {
        if([dic.allValues[i] isEqualToString:@""])
        {
            continue;
        }
        NSString * string=[NSString stringWithFormat:@"%@=%@",dic.allKeys[i],dic.allValues[i]];
        [array addObject:string];
    }
    
    
    NSArray *sortAfterArray =[array sortedArrayUsingComparator:^NSComparisonResult(NSString*  _Nonnull obj1, NSString*  _Nonnull obj2) {
        NSComparisonResult result = [obj1 compare:obj2];
        if(result == NSOrderedSame)
        {
            result =[obj1 compare:obj2];
        }
        return result;
    }];
    
    NSString *md5string =@"";
    for (int i=0; i<sortAfterArray.count; i++)
    {
        md5string = [md5string stringByAppendingString:[sortAfterArray objectAtIndex:i]];
        if(i <sortAfterArray.count-1)
        {
            md5string = [md5string stringByAppendingString:@"&"];
        }
        
    }
    return md5string;
  
    
}


+(NSString*)StringMd5:(NSString*)md5string
{
    
  NSString *   string = [md5string stringByAppendingString:HY_KEY_SECRECT];
    return  [NSString   MD5:string];
    
}
+(NSString * ) AESString:(NSString *) string
{
    return [AESUtility AES256Encrypt:string];
}


@end
