//
//  NSDictionary+Convert.m
//  youbaner
//
//  Created by luzhongchang on 17/8/14.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "NSDictionary+Convert.h"

@implementation NSDictionary (Convert)

+ (NSDictionary *)convertParams:(NSString *)urlcode dic:(NSDictionary *)dic {
    NSLog(@"=========> 请求接口为: %@", urlcode);
    NSLog(@"=========> 请求参数为: %@", dic);

    if (dic.allValues.count == 0) {
        NSDictionary *basedic   = [WDSignatureManager baseDic];
        NSMutableDictionary *dm = [NSMutableDictionary new];
        [dm addEntriesFromDictionary:basedic];
        NSDictionary *rem = @{
            @"code": urlcode,
            @"ver": [NSDictionary returnVer:urlcode],
            @"sign": [NSString StringMd5:[NSString getBodyString:[dm copy]]]
        };

        NSMutableDictionary *targetDic = [NSMutableDictionary new];
        [targetDic addEntriesFromDictionary:basedic];
        [targetDic addEntriesFromDictionary:rem];

        return [targetDic copy];
    }


    NSString *json          = [NSDictionary dictionaryToJson:dic];
    json                    = [json stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *jsonAes       = [NSString AESString:json];
    NSDictionary *basedic   = [WDSignatureManager baseDic];
    NSMutableDictionary *dm = [NSMutableDictionary new];
    [dm addEntriesFromDictionary:basedic];
    [dm addEntriesFromDictionary:@{ @"body": jsonAes }];
    NSDictionary *rem = @{
        @"body": jsonAes,
        @"code": urlcode,
        @"ver": [NSDictionary returnVer:urlcode],
        @"sign": [NSString StringMd5:[NSString getBodyString:[dm copy]]]
    };

    NSMutableDictionary *targetDic = [NSMutableDictionary new];
    [targetDic addEntriesFromDictionary:basedic];
    [targetDic addEntriesFromDictionary:rem];

    return [targetDic copy];
}

+ (NSString *)dictionaryToJson:(NSDictionary *)dic

{
    NSError *parseError = nil;

    NSData *jsonData =
    [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];

    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (NSNumber *)returnVer:(NSString *)urlcode {
    NSArray *codeArray = @[
        @"msg-getMessage",
        @"msg-getMsglist",
        @"getuserinfo",
        @"executewechatpaybytype",
        @"executealipay",
        @"rechargememeservicebyapple"
    ];
    NSInteger inter = [codeArray indexOfObject:urlcode];
    if (inter == NSNotFound) {
        return @1;
    } else {
        return [WDSignatureManager getAPIVersion];
    }
}

@end
