//
//  WDRequestAdapter.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/2.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDRequestAdapter.h"
#import "WDRequestManager.h"
#import "WDResponseModel.h"
#import "WDQiniuUploadHelper.h"

static NSString *const kNetworkErrorTips = @"网络连接错误";

@implementation WDRequestAdapter

+ (RACSignal *)requestSignalWithURL:(NSString *)url
                             params:(NSDictionary *)params
                        requestType:(WDRequestType)requestType
                       responseType:(WDResponseType)responseType
                      responseClass:(Class)responseClass {
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // 请求成功操作
        RequestSuccessBlock successBlock = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
            @strongify(self);
            RACSignal *parsedSignal = [self parsedResponse:responseObject
                                               ofURLString:url
                                                   byClass:responseClass
                                              responseType:responseType];
            [parsedSignal
             subscribeNext:^(id  _Nullable x) {
                 [subscriber sendNext:x];
                 [subscriber sendCompleted];
             }
             error:^(NSError * _Nullable error) {
                 [subscriber sendError:error];
             }
             completed:^{
                 [subscriber sendCompleted];
                 
             }];

        };
        
        // 请求失败操作
        RequestFailureBlock failureBlock = ^(NSURLSessionDataTask *task, NSError *error){
            NSLog(@"\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n请求URL:\n%@\n请求失败:\n%@\n<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<", url, error);
            [subscriber sendError:error];
        };
        
        // 请求成功但Token失效操作
        RequestTokenInvalidBlock tokenInvalidBlock = ^(NSURLSessionDataTask *task, id response, NSError *error){
            NSLog(@"\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n请求URL:\n%@\n请求结果: Token过期\n<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<", url);
            // 发送通知, 在AppDelegateUIAssistant里面处理token失效
            [[NSNotificationCenter defaultCenter] postNotificationName:LOG_KICK_OUT_NOTIF_KEY object:nil];
            [subscriber sendError:error];
        };
        
        
        
        NSURLSessionDataTask *task = nil;
        switch (requestType) {
            case WDRequestTypeGET: {
                task = [[WDRequestManager shareManager] request:url
                                                     withParams:params
                                                    requestType:WDRequestTypeGET
                                                   invalidToken:tokenInvalidBlock
                                                        success:successBlock
                                                        failure:failureBlock];
                break;
            }
            case WDRequestTypePOST: {
                task = [[WDRequestManager shareManager] request:url
                                                     withParams:params
                                                    requestType:WDRequestTypePOST
                                                   invalidToken:tokenInvalidBlock
                                                        success:successBlock
                                                        failure:failureBlock];
                break;
            }
            case WDRequestTypeDELETE: {
                task = [[WDRequestManager shareManager] request:url
                                                     withParams:params
                                                    requestType:WDRequestTypeDELETE
                                                   invalidToken:tokenInvalidBlock
                                                        success:successBlock
                                                        failure:failureBlock];
                break;
            }
            case WDRequestTypePUT: {
                task = [[WDRequestManager shareManager] request:url
                                                     withParams:params
                                                    requestType:WDRequestTypePUT
                                                   invalidToken:tokenInvalidBlock
                                                        success:successBlock
                                                        failure:failureBlock];
                break;
            }
            default:
                break;
        }
        
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}


+ (RACSignal *)parsedResponse:(NSDictionary *)response ofURLString:(NSString *)urlStr byClass:(Class)ObjClass responseType:(WDResponseType)responseType {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        if (![response isKindOfClass:[NSDictionary class]]) {
            [subscriber sendError:nil];
            return nil;
        }

        WDResponseModel *responseModel = [[WDResponseModel alloc] init];
        responseModel.msg = response[@"msg"];
        responseModel.extra = response[@"extra"];
//        id encryptData = response[@"data"];
        id data = response[@"data"];
        
        NSLog(@"\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n请求URL:\n%@\n请求数据:\n%@\n<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<", urlStr, response);

        // 直接返回响应数据: 1.空; 2.没有设置转换的数据类型; 3.设置的转换数据类型是message
        if (data == nil ||
            ObjClass == nil ||
            responseType == WDResponseTypeMessage) {
            responseModel.data = data;
            
            [subscriber sendNext:responseModel];
            [subscriber sendCompleted];
            return nil;
        }
        
        // 根据类型转换数据
        switch (responseType) {
            case WDResponseTypeObject: {
                if(![data isKindOfClass:[NSArray class]] || [(NSArray *)data count]==0) {
                    responseModel.data=nil;
                }
                else
                    responseModel.data = [ObjClass mj_objectWithKeyValues:data[0]];
                break;
            }
            case WDResponseTypeList: {
                if ([data isKindOfClass:[NSArray class]]) {                    
                    responseModel.totalpage =[[response objectForKey:@"totalpage"] intValue];
                    responseModel.total=[[response objectForKey:@"total"]intValue];
                    responseModel.data = [ObjClass mj_objectArrayWithKeyValuesArray:data];                
                    
                }
                break;
            }
            default:
                break;
        }
        
        [subscriber sendNext:responseModel];
        [subscriber sendCompleted];
        
        return nil;
    }];
}


/// SDWebImage下载图片
+ (RACSignal *)downloadImageSignalWithURL:(NSString *)url
                                      key:(NSString *)key {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:url] options:SDWebImageDownloaderLowPriority|SDWebImageDownloaderContinueInBackground progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            
        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            if (error) {
                NSLog(@"下载图片失败: %@", error.localizedDescription);
                [subscriber sendError:error];
                return;
            }
            
            if (finished) {
                NSString *k = key;
                if (key == nil || [key isEqualToString:@""]) k = url;
 
                [[SDImageCache sharedImageCache] storeImage:image forKey:k completion:^{
                    NSLog(@"下载并保存图片成功!");
                    [subscriber sendNext:@{
                                           @"key" : k,
                                           @"url" : url
                                           }];
                    [subscriber sendCompleted];
                }];
            }
            
        }];
        
        return nil;
    }];
    
    return signal;
}
@end
