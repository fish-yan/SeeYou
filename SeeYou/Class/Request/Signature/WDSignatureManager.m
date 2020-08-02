//
//  WDSignatureManager.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/2.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDSignatureManager.h"
#import <sys/sysctl.h>
#import <sys/utsname.h>
#import <CommonCrypto/CommonHMAC.h>
#import "WDRequestManager.h"



#define APP_ID @"10002"

#define APP_SECRET      @"e27eba279073494a991b12dea9c56832"             // APPsecret配置
#define SESSION_KEY     @"1bc215fa-7a88-4972-a33e-3eb2e37de5ca"         // 用户key为空时默认的 Session Key

#define MAIN_AREA       @"3101"                                         // 区域码配置
#define SPEC_AREA       @""                                             // 特色区域配置
#define API_VERSION     @"2"                                        // API版本配置
#define APP_NAME        @"com.wondersgroup.healthcloud.3101://doctor"   // APP_Name配置
#define SECRET_HEADER   @"crackerdontdothisplz!\n"                      // 加密头配置
#define CHANNEL         @"appstore"                                     // APP渠道配置
#define PLATFORM        @"0"                                            // 平台配置

@implementation WDSignatureManager

+ (void)addHeader:(id)requestSerializer
           params:(NSDictionary *)params
           method:(WDRequestType)requestType
              url:(NSString *)url
  isURLHaveAPITag:(BOOL)isURLHaveAPITag {
    // token
    NSString *accessToken =  @"";
    //接口调用唯一UUID
    NSString *uuid        = [[NSUUID UUID] UUIDString];
    //接口调用时间
    NSString *dateTime    = [[NSDate date] mt_stringFromDateWithFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZ" localized:NO];
    
    NSDictionary *headerDict = @{
                                 @"appid":APP_ID,
                                 @"ver"   :API_VERSION,
                                 @"app-version"   : APP_VERSION,
                                 @"token"  : accessToken,
                                 @"appch"       : CHANNEL,
                                 @"did"        : uuid,
                                 @"appm"        :@"native",
                                 @"dbr"         :@"ios",
                                 @"dmd"         : DEVICE_MODEL,
                                 @"dos"    : @"iod",
                                 @"dscr" : [NSString stringWithFormat:@"%@*%@", SCREEN_HEIGHT_STR,SCREEN_WIDTH_STR ],
                                 @"dnet"  :@"",
                                 @"lng"     : @"",
                                 @"lat"   :@"",
                                 @"sign"  :@"Gwn1zaQtCPUnd688jIruSS6gZvfShvNB"
                                 };
    
    [headerDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    
    // Request Signature
    NSString *signature = [self signatureStringWithHeaderDict:headerDict
                                                         uuid:uuid
                                                  requestTime:dateTime
                                                          url:url
                                                       params:params
                                                  requestType:requestType
                                              isURLHaveAPITag:isURLHaveAPITag];
    [requestSerializer setValue:signature forHTTPHeaderField:@"signature"];
    [requestSerializer setValue:uuid      forHTTPHeaderField:@"request-id"];
    [requestSerializer setValue:dateTime  forHTTPHeaderField:@"client-request-time"];
    [requestSerializer setValue:APP_NAME  forHTTPHeaderField:@"app-name"];
}

+ (NSString *)signatureStringWithHeaderDict:(NSDictionary *)headerDict
                                       uuid:(NSString *)uuid
                                requestTime:(NSString *)dateTime
                                        url:(NSString *)url
                                     params:(NSDictionary *)params
                                requestType:(WDRequestType)requestType
                            isURLHaveAPITag:(BOOL)isURLHaveAPITag {
    // 接口调用唯一UUID
    NSString *requestUUID   = [NSString stringWithFormat: @"request-id=%@", uuid];
    // 接口调用时间
    NSString *requestTime   = [NSString stringWithFormat: @"client-request-time=%@", dateTime];
    if ([WDRequestManager shareManager].time_diff) {
        requestTime = [NSString stringWithFormat: @"%@+time-diff=%@", requestTime, [WDRequestManager shareManager].time_diff];
    }
    
    NSString *apiPath = [url lowercaseString];;
    // 判断接口是否带api, 重新拼接api
    if (isURLHaveAPITag) {
        apiPath = [NSString stringWithFormat:@"%@%@", @"/api/", apiPath];
    }
    
    NSString *requestStr = [NSString stringWithFormat: @"%@%@@%@\n%@", SECRET_HEADER,requestUUID, requestTime, apiPath];
    
    // 排序header准备用作签名
    NSString *headerStr  = @"";
    NSArray *array = [[headerDict allKeys] sortedArrayUsingSelector:@selector(compare:)];
    for (NSString *aKey in array) {
        if(![aKey isEqualToString: @"signature"]){
            if ([headerStr length] == 0) {
                headerStr = [headerStr stringByAppendingString:[NSString stringWithFormat:@"%@=%@", aKey, [headerDict objectForKey:aKey]]];
            }
            else {
                headerStr = [headerStr stringByAppendingString:[NSString stringWithFormat:@"&%@=%@", aKey, [headerDict objectForKey:aKey]]];
            }
        }
    }
    // 处理params准备用作签名
    NSString *paramsStr = @"";
    if (requestType == WDRequestTypePOST) {
        //POST 方法，转成JSONString
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params
                                                           options:kNilOptions
                                                             error:nil];
        paramsStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    else {
        // 非POST 方法，直接拼接
        array = [[params allKeys] sortedArrayUsingSelector:@selector(compare:)];
        for (NSString *aKey in array) {
            if ([paramsStr length] == 0) {
                paramsStr =[paramsStr stringByAppendingString:[NSString stringWithFormat: @"%@=%@", aKey, [params objectForKey:aKey]]];
            }
            else {
                paramsStr =[paramsStr stringByAppendingString:[NSString stringWithFormat: @"&%@=%@", aKey, [params objectForKey:aKey]]];
            }
        }

    }
    
    // app secret
    NSString *signature = [NSString stringWithFormat:@"%@+%@+%@\n%@", requestStr, headerStr, paramsStr, APP_SECRET];
    
    // MD5加密
    //    NSString *md5 = [SignatureManager md5: signature];
    
    // HA256加密
    NSString *h256 = [self ha256AndBase64:signature];
    
    // NSLog(@"签名加密前: %@\n签名加密后：%@", signature, h256);
    
    return h256;
}



+(NSDictionary *)baseDic
{

    NSString *accessToken =[HYUserContext shareContext].token==nil?@"":[HYUserContext shareContext].token;
    //接口调用唯一UUID
    NSString *uuid        = [[NSUUID UUID] UUIDString];
    //接口调用时间
    NSString *dateTime    = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
    
    NSDictionary *headerDict = @{
                                 @"appid":APP_ID,
                                 @"appv"   : APP_VERSION,
                                 @"token"  : accessToken,
                                 @"appch"       : CHANNEL,
                                 @"did"        : uuid,
                                 @"appm"        :@"native",
                                 @"dbr"         :@"ios",
                                 @"dmd"         : DEVICE_MODEL,
                                 @"dos"    : @"ios",
                                 @"dscr" : [NSString stringWithFormat:@"%@*%@", SCREEN_HEIGHT_STR,SCREEN_WIDTH_STR ],
//                                 @"dnet"  :@"",
//                                 @"lng"     : @"",
//                                 @"lat"   :@"",
                                 @"ts": dateTime
                                 };
    return headerDict;

}

+(NSNumber *)getAPIVersion
{
    return  @([API_VERSION intValue]);
}

#pragma mark - 加密、解密类

/// HA256 加密
+ (NSString *)ha256AndBase64:(NSString *)input {
    // 加盐+加密密钥
    // 盐是用户信息的key, 默认有个sessionKey
    NSString *secret = SESSION_KEY;
    NSData *saltData = [secret dataUsingEncoding:NSUTF8StringEncoding];
    NSData *inputData = [input dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *hash = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA256, saltData.bytes, saltData.length, inputData.bytes, inputData.length, hash.mutableBytes);
    return [hash base64EncodedStringWithOptions: NSDataBase64Encoding64CharacterLineLength];
}


/// MD5加密
+ (NSString *)md5:(NSString *)input {
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (unsigned int)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity: CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

@end
