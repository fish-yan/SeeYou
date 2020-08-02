//
//  WDSecurityPolicy.m
//  HCPatient
//
//  Created by Jam on 2016/12/27.
//  Copyright © 2016年 ZJW. All rights reserved.
//

#import "WDSecurityPolicy.h"


@implementation WDSecurityPolicy

+ (AFSecurityPolicy *)securityPolicy {
//    //导入serverjky证书
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"serverjky" ofType:@"cer"];//证书的路径
//    NSData *jkyData = [NSData dataWithContentsOfFile:path];
//    
//    //导入GlobalSignRoot证书
//    path = [[NSBundle mainBundle] pathForResource:@"GlobalSignRoot" ofType:@"cer"];//证书的路径
//    NSData *rootData = [NSData dataWithContentsOfFile:path];
//
//    //导入GlobalSign证书
//    path = [[NSBundle mainBundle] pathForResource:@"GlobalSign" ofType:@"cer"];//证书的路径
//    NSData *globalData = [NSData dataWithContentsOfFile:path];
//
//    //导入GlobalSignR2证书
//    path = [[NSBundle mainBundle] pathForResource:@"GlobalSignR2" ofType:@"cer"];//证书的路径
//    NSData *globalData2 = [NSData dataWithContentsOfFile:path];
//
//    //导入GlobalSignR3证书
//    path = [[NSBundle mainBundle] pathForResource:@"GlobalSignR3" ofType:@"cer"];//证书的路径
//    NSData *globalData3 = [NSData dataWithContentsOfFile:path];
//
//    //导入GlobalSignR4证书
//    path = [[NSBundle mainBundle] pathForResource:@"GlobalSignR4" ofType:@"cer"];//证书的路径
//    NSData *globalData4 = [NSData dataWithContentsOfFile:path];
//
//    //导入GlobalSignR5证书
//    path = [[NSBundle mainBundle] pathForResource:@"GlobalSignR5" ofType:@"cer"];//证书的路径
//    NSData *globalData5 = [NSData dataWithContentsOfFile:path];

    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode: AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = NO;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = YES;
    
    
//    NSSet *cerSets = [[NSSet alloc] initWithObjects:jkyData, rootData, globalData, globalData2, globalData3, globalData4, globalData5, nil];
//    NSSet *cerSets = [[NSSet alloc] initWithObjects:jkyData, nil];

//    securityPolicy.pinnedCertificates = cerSets;
    
    return securityPolicy;
}

@end
