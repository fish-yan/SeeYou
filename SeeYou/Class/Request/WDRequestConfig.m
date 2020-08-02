//
//  WDRequestConfig.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/2.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDRequestConfig.h"

@implementation WDRequestConfig

/// 环境配置预编译宏:
/// EDEVELOPMENT : 开发环境
/// ETEST : 测试环境
/// EPRERELEASE : 预发布环境
/// ERELEASE : 正式环境

//------------------------------------------------------------------------------
#pragma mark - 公钥

/// 网络请求加密的公钥
NSString *const kRequestPublicKey = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCDGHjtLwTJP9ehWYM3Dmwg9eTX3gDAFwQMyL1edXKPOjyUucWml7O8VF8adQgLH8fM1PoZSKHGliE0rZ3q6o1jh4lkF1CLIqWRbZ4ObKM2i1w5O2VP9lMKyWTrRM/R9RWxCgwINb/QQmbmNLTVruh4YG1Q0QTK2dQLnIh0oANdpwIDAQAB";

/// 响应数据解密私钥
NSString *const kResponsePrivateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBALqFImjo8C8C3FpHFDmoJzpdQvfR9pcAyy5vg+BctpNwmIM8SbfkRGFxxTx/hJfmJ5auMFfsKkd8j4srA3NCgUGGf6eB8TySYKmV6mMvWlMrpjgVGB0rElV3W7PJr0brsoHwrlBDhSPeUzDEt7P9IN2A+aPLtfazbea2W22FA5ItAgMBAAECgYEAhwYoAdBXR4EHqab5AkAznbGz8BkkLO5bKBN8YWhcl2GUVrTHHQN3aR9mTER35Uqs8AzLXGrPtI58j5+k0MSdMmadoCXG9U7wcnCaik5mTf16I5390QGcAAdB3mdY7oITLIKsz4pGMSOpk0CgvkXglJ49LtRzm8iRcboggxAsWXUCQQD2L0Ua9eYF/y7fYU+D3l6LyFf2/CDvDhUkzrL82ybqDb25SD/zzOo8zV9VL7ZAd8T8FRzvbNw8n0/a+EWq6I57AkEAwfTi9WWAvse/KQ3E46s+Wbq97v609mMitUaPk2RvYBn2nCfPOvwEgNMnPxCYdQDMgeIASZmHWndbVipbXQfVdwJAHXRAX15mO/dxAzbgTZWwWCcLJzi5NADKVNIKJiiOOliUh3N2e1Pb/pRPwKBpvMLXpZVdFeQ/YV1qL3ee1jjmuwJAQTx31eglDIYswscx0Q248/8+gRNElJa1htlL01x1pZI2A0HUjtdTQG1FBw4y6S+ymYEFbbvo7cG1g97NShYncwJBALWxgscXRzCumuh1LxAmQBpyRM/Nqf0+YEB3kWDILgGsxL/t8jiFS16dDehpmXmtnvCmkJCiekGr1V7SFlW/0XQ=";

NSString *const kResponsePublicKey = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC6hSJo6PAvAtxaRxQ5qCc6XUL30faXAMsub4PgXLaTcJiDPEm35ERhccU8f4SX5ieWrjBX7CpHfI+LKwNzQoFBhn+ngfE8kmCplepjL1pTK6Y4FRgdKxJVd1uzya9G67KB8K5QQ4Uj3lMwxLez/SDdgPmjy7X2s23mtltthQOSLQIDAQAB";


//*****************************************************************************************************************
//                                                  开发环境
//*****************************************************************************************************************
//#if EDEVELOPMENT

/// 服务器Base URL
//
//NSString *const kServerBaseURL  = @"https://www.huayuanvip.com/app/call";
NSString *const kServerBaseURL  = @"http://47.105.192.40:8088/app/call";

/// H5页面BaseURL
NSString *const kH5BaseURL      = @"http://10.1.64.194/neohealthcloud-app-h5/";



//*****************************************************************************************************************
//                                                  测试环境
//*****************************************************************************************************************
//#elif ETEST
//
///// 服务器Base URL
//NSString *const kServerBaseURL  = @"http://218.80.250.99/neohealthcloud-doctor-te/api/";
///// H5页面BaseURL
//NSString *const kH5BaseURL      = @"http://10.1.64.194/neohealthcloud-app-h5/";
//
//
////*****************************************************************************************************************
////                                                  预发布环境
////*****************************************************************************************************************
//#elif EPRERELEASE
//
///// 服务器Base URL
//NSString *const kServerBaseURL  = @"https://www.wdjky.com/neohealthcloud-doctor/api/";
///// H5页面BaseURL
//NSString *const kH5BaseURL      = @"http://10.1.64.194/neohealthcloud-app-h5/";
//
//
////*****************************************************************************************************************
////                                                  生成环境
////*****************************************************************************************************************
//#elif ERELEASE
//
///// 服务器Base URL
//NSString *const kServerBaseURL  = @"https://www.wdjky.com/neohealthcloud-doctor/api/";
///// H5页面BaseURL
//NSString *const kH5BaseURL      = @"http://10.1.64.194/neohealthcloud-app-h5/";
//
//#endif

@end
