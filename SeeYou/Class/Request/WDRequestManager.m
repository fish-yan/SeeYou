//
//  WDRequestManager.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/1.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDRequestManager.h"
#import "AFNetworking.h"
#import "MF_Base64Additions.h"
#import "HappyDNS.h"
#import "WDSecurityPolicy.h"
#import "WDSignatureManager.h"
#import "WDResponseChecking.h"

@interface WDRequestManager ()



@end

@implementation WDRequestManager

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    static WDRequestManager *shareMgr = nil;
    dispatch_once(&onceToken, ^{
        shareMgr = [[WDRequestManager alloc] init];
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.requestCachePolicy = NSURLRequestReloadIgnoringCacheData;
        shareMgr.sessionManager = [[AFHTTPSessionManager alloc]
                                   initWithBaseURL:[NSURL URLWithString:kServerBaseURL]
                                   sessionConfiguration:configuration];
        
//        shareMgr.sessionManager.securityPolicy = [WDSecurityPolicy securityPolicy];
        shareMgr.sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        [shareMgr.sessionManager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8"forHTTPHeaderField:@"Content-Type"];
        
        
        shareMgr.sessionManager.requestSerializer.timeoutInterval = 30.0; // 设置超时时间为30秒
        [shareMgr.sessionManager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:
                                                                               @"application/json",
                                                                               @"charset=UTF-8",
                                                                               @"text/plain",
                                                                               @"text/javascript",
                                                                               @"text/html",
                                                                               @"image/*",
                                                                               nil]];
    });

    return shareMgr;
}




- (NSURLSessionDataTask *)request:(NSString *)url
                       withParams:(NSDictionary *)params
                      requestType:(WDRequestType)requestType
                     invalidToken:(RequestTokenInvalidBlock)invalidToken
                          success:(RequestSuccessBlock)success
                          failure:(RequestFailureBlock)failure {
    NSLog(@"Request_POST:\nURL: %@\nParams: %@", url, params);
    
    __weak typeof(self) weakSelf = self;
    RequestSuccessBlock successBlock = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        __strong typeof(self) self = weakSelf;
        [self responseComplete:responseObject
                      dataTask:task
                  invalidToken:invalidToken
                       success:success
                       failure:failure];
    };
    
    RequestFailureBlock failureBlock = ^(NSURLSessionDataTask *task, NSError *error){
        if (failure) {
            failure(task, error);
        }
    };
    
    RequestTokenInvalidBlock tokenInvalidBlock = ^(NSURLSessionDataTask *task, id response, NSError *error){
        if (invalidToken) {
            invalidToken(task, response, error);
        }
    };
    
    switch (requestType) {
        case WDRequestTypeGET: {
            return [self requestGET:url
                             params:params
                       invalidToken:tokenInvalidBlock
                            success:successBlock
                            failure:failureBlock];
            break;
        }
        case WDRequestTypePOST: {
            return [self requestPOST:url
                              params:params
                        invalidToken:tokenInvalidBlock
                             success:successBlock
                             failure:failureBlock];
            break;
        }
        case WDRequestTypeDELETE: {
            return [self requestDELETE:url
                                params:params
                          invalidToken:tokenInvalidBlock
                               success:successBlock
                               failure:failureBlock];
            break;
        }
        case WDRequestTypePUT: {
            return [self requestPUT:url
                              params:params
                        invalidToken:tokenInvalidBlock
                             success:successBlock
                             failure:failureBlock];
            break;
        }
        default:
            break;
    }
    
    return nil;
}


#pragma mark - 处理请求

- (void)responseComplete:(id)response
                dataTask:(NSURLSessionDataTask *)task
            invalidToken:(RequestTokenInvalidBlock)invalid
                 success:(RequestSuccessBlock)success
                 failure:(RequestFailureBlock)failure {
    // 检查请求是否失败
    // 如果 响应的code == 0 就表示响应成功
    // 如果 响应失败 则自定义错误信息
    NSError *error = [WDResponseChecking checkResponseObject:response];
    
    if (error) {
        // 检查请求时 token 是否已经过期
        if ([WDResponseChecking isInvalidToken:error] ) {
            if (invalid) {
                invalid(task, response, error);
            }
        }
        else {  // 接口请求失败
            if (failure) {
                // 本地时间和服务器时间差超过10分钟
                if ((int)error.code == 16 && response[@"time_diff"]) {
                    self.time_diff = response[@"time_diff"];
                }
                if (failure) {
                    failure(task, error);
                }
            }
        }
    }
    else {
        if (success) {
            success(task, response);
        }
    }
}


#pragma mark - GET请求

- (NSURLSessionDataTask *)requestGET:(NSString *)url
                              params:(NSDictionary *)params
                        invalidToken:(RequestTokenInvalidBlock)invalidToken
                             success:(RequestSuccessBlock)success
                             failure:(RequestFailureBlock)failure {
    return [self.sessionManager GET:url parameters:params progress:NULL success:success failure:failure];
}


#pragma mark - POST请求

- (NSURLSessionDataTask *)requestPOST:(NSString *)url
                               params:(NSDictionary *)params
                         invalidToken:(RequestTokenInvalidBlock)invalidToken
                              success:(RequestSuccessBlock)success
                              failure:(RequestFailureBlock)failure {
    return [self.sessionManager POST:url parameters:params progress:NULL success:success failure:failure];
}


#pragma mark - DELETE请求

- (NSURLSessionDataTask *)requestDELETE:(NSString *)url
                                 params:(NSDictionary *)params
                           invalidToken:(RequestTokenInvalidBlock)invalidToken
                                success:(RequestSuccessBlock)success
                                failure:(RequestFailureBlock)failure {
    return [self.sessionManager DELETE:url parameters:params success:success failure:false];
}


#pragma mark - PUT请求

- (NSURLSessionDataTask *)requestPUT:(NSString *)url
                              params:(NSDictionary *)params
                        invalidToken:(RequestTokenInvalidBlock)invalidToken
                             success:(RequestSuccessBlock)success
                             failure:(RequestFailureBlock)failure {
    return [self.sessionManager PUT:url parameters:params success:success failure:failure];
}


#pragma mark - 上传文件

- (NSURLSessionDataTask *)requestUploadFile:(NSString *)url
                                      files:(NSArray *)datas
                                 parameters:(NSDictionary *)params
                               invalidToken:(RequestTokenInvalidBlock)invalidToken
                                    success:(RequestSuccessBlock)success
                                    failure:(RequestFailureBlock)failure {
    return nil;
}


@end
