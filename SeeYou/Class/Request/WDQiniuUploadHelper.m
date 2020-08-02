//
//  WDQiniuUploadHelper.m
//  HCDoctor
//
//  Created by Joseph Gao on 2017/6/8.
//  Copyright © 2017年 WondersGroup.com. All rights reserved.
//

#import "WDQiniuUploadHelper.h"
#import "QiniuSDK.h"
#import "WDResponseModel.h"
#import "WDRequestManager.h"

@interface WDQiniuUploadHelper ()

@property (nonatomic, copy) void(^singleSuccessBlock)(NSString *imgURL);
@property (nonatomic, copy) void(^singleFailureBlock)(NSError *error);

@end

@implementation WDQiniuUploadHelper

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static WDQiniuUploadHelper *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[WDQiniuUploadHelper alloc] init];
    });
    return instance;
}


- (void)uploadImagesSignalWithImages:(NSArray<UIImage *> *)images
                    withSuccessBlock:(void(^)(NSArray *imgURLs))successBlock
                    failreBlock:(void(^)(NSError *error))failureBlock
{
    
    
    [[WDRequestManager shareManager].sessionManager POST:@""
                                              parameters:[NSDictionary convertParams:API_UPLOADAVATAR dic:@{}]
                               constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i=0; i< images.count; i++)
        {
            
            NSData *imagedata = [self compressImage:[images objectAtIndex:i]];
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            formatter.dateFormat =@"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@%d.jpg", str,(arc4random() % 100001) + 500 ];
            [formData appendPartWithFileData:imagedata
                                        name:@"file"
                                    fileName:fileName
                                    mimeType:@"image/jpeg"];
        }
    
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        int code  = [responseObject[@"code"] intValue];
        if(code==0)
        {
            successBlock(responseObject[@"data"]);
             NSLog(@"ok");
        }
        else
        {
            
            NSNumber *errorCode = [NSNumber numberWithInt: code];
            NSDictionary *errorInfo = @{
                                        NSLocalizedDescriptionKey: responseObject[@"msg"],
                                        NSLocalizedFailureReasonErrorKey : errorCode
                                        };
            NSError *error = [NSError errorWithDomain:APP_ERROR_DOMAIN code:code userInfo:errorInfo];
            if (failureBlock) {
                failureBlock(error);
            }
        }
        
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failureBlock(error);
        NSLog(@"failed");
    }];
    
    
    
    
}




- (void)uploadImagesSignalWithImagesWithIdentify:(NSArray<UIImage *> *)images
                    withSuccessBlock:(void(^)(WDResponseModel* model))successBlock
                         failreBlock:(void(^)(NSError *error))failureBlock
{
    
    
    [[WDRequestManager shareManager].sessionManager POST:@"" parameters:[NSDictionary convertParams:API_UPLOADIDENTIFYPICTURE dic:@{}] constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i=0; i< images.count; i++)
        {
            
            NSData *imagedata = [self compressImage:[images objectAtIndex:i]];
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            formatter.dateFormat =@"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@%d.jpg", str,(arc4random() % 100001) + 500 ];
            [formData appendPartWithFileData:imagedata
                                        name:@"file"
                                    fileName:fileName
                                    mimeType:@"image/jpeg"];
        }
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
            int code = [responseObject[@"code"] intValue];
            if(code ==0)
            {
                WDResponseModel * model =[WDResponseModel new];
                model.data = responseObject[@"data"];
                model.msg =responseObject[@"msg"];
                model.encode = responseObject[@"code"];
                successBlock(model);
            }
            else
            {
            
                NSNumber *errorCode = [NSNumber numberWithInt: code];
               NSDictionary *errorInfo = @{
                                           NSLocalizedDescriptionKey: responseObject[@"msg"],
                                           NSLocalizedFailureReasonErrorKey : errorCode
                                           };
               NSError *error = [NSError errorWithDomain:APP_ERROR_DOMAIN code:code userInfo:errorInfo];
               if (failureBlock) {
                   failureBlock(error);
               }
            }
              NSLog(@"ok");
        
      
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failureBlock(error);
        NSLog(@"failed");
    }];
    
    
    
    
}



- (void)uploadImagesSignalWithImagesWithShowPhotos:(NSArray<UIImage *> *)images
                                  withSuccessBlock:(void(^)(WDResponseModel *model))successBlock
                                       failreBlock:(void(^)(NSError *error))failureBlock
{

    
    [[WDRequestManager shareManager].sessionManager POST:@"" parameters:[NSDictionary convertParams:API_UPLOADSHOWPHOTOS dic:@{}] constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i=0; i< images.count; i++)
        {
            
            NSData *imagedata = [self compressImage:[images objectAtIndex:i]];
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            formatter.dateFormat =@"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@%d.jpg", str,(arc4random() % 100001) + 500 ];
            [formData appendPartWithFileData:imagedata
                                        name:@"file"
                                    fileName:fileName
                                    mimeType:@"image/jpeg"];
        }
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
        int code = [responseObject[@"code"] intValue];
        if(code ==0)
        {
            WDResponseModel * model =[WDResponseModel new];
            model.data = responseObject[@"data"];
            model.msg =responseObject[@"msg"];
            model.encode = responseObject[@"code"];
            successBlock(model);
        }
        else
        {
            
            NSNumber *errorCode = [NSNumber numberWithInt: code];
            NSDictionary *errorInfo = @{
                                        NSLocalizedDescriptionKey: responseObject[@"msg"],
                                        NSLocalizedFailureReasonErrorKey : errorCode
                                        };
            NSError *error = [NSError errorWithDomain:APP_ERROR_DOMAIN code:code userInfo:errorInfo];
            if (failureBlock) {
                failureBlock(error);
            }
        }
        NSLog(@"ok");
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failureBlock(error);
        NSLog(@"failed");
    }];
}



//- (void)uploadImages:(NSArray<UIImage *> *)images
//       withQiniuToke:(NSString *)token
//         imageDomain:(NSString *)domain
//       successHandle:(void(^)(NSArray<NSString *> *imgURLs))successHandler
//       failureHandle:(void(^)(NSError *error))failureHandler {
//    if (!images || images.count == 0) return;
//    
//    __block NSMutableArray *imageURLs = [NSMutableArray arrayWithCapacity:images.count];
//    __block NSInteger idx = 0;
//    
//    self.singleFailureBlock = ^(NSError *error) {
//        if (failureHandler) {
//            failureHandler(error);
//        }
//        return;
//    };
//    
//    @weakify(self);
//    self.singleSuccessBlock = ^(NSString *imgURL) {
//        @strongify(self);
//        [imageURLs addObject:imgURL];
//        idx++;
//        
//        if (imageURLs.count == images.count) {
//            if (successHandler) {
//                successHandler(imageURLs);
//            }
//            return ;
//        }
//        else {
//            [self uploadSingleImage:images[idx]
//                      withQiniuToke:token
//                        imageDomain:domain
//                      successHandle:self.singleSuccessBlock
//                      failureHandle:self.singleFailureBlock];
//        }
//        return;
//    };
//    
//    [self uploadSingleImage:images[0]
//              withQiniuToke:token
//                imageDomain:domain
//              successHandle:self.singleSuccessBlock
//              failureHandle:self.singleFailureBlock];
//}
//
//- (void)uploadSingleImage:(UIImage *)img
//            withQiniuToke:(NSString *)token
//              imageDomain:(NSString *)domain
//            successHandle:(void(^)(NSString *imgURL))successHandler
//            failureHandle:(void(^)(NSError *error))failureHandler {
//    
//    NSString *key = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
//    
//    QNUploadManager *mgr = [[QNUploadManager alloc] init];
//    [mgr putData:[self compressImage:img]
//             key:key
//           token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//               if (resp) {
//                   NSString *imgURL =  [NSString stringWithFormat: @"http://%@/%@", domain, key];
//                   if (successHandler) {
//                       successHandler(imgURL);
//                   }
//               }
//               else {
//                   NSNumber *errorCode = [NSNumber numberWithInt: info.statusCode];
//                   NSDictionary *errorInfo = @{
//                                               NSLocalizedDescriptionKey: @"上传图片失败",
//                                               NSLocalizedFailureReasonErrorKey : errorCode
//                                               };
//                   NSError *error = [NSError errorWithDomain:APP_ERROR_DOMAIN code:info.statusCode userInfo:errorInfo];
//                   if (failureHandler) {
//                       failureHandler(error);
//                   }
//               }
//               
//           }
//          option:nil];
//}
//
- (NSData *)compressImage:(UIImage *)image {
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    int maxFileSize = 500 * 1024;
    
    NSData *imageData =  UIImageJPEGRepresentation(image, compression);
    
    while ([imageData length] > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    
    return imageData;
}
//
//
///**
// 获取七牛token信号
// 
// expires = 3600;
// token = kUCOKS5T5i6ygr-5i7MoqimI-EDl5OegkKwkxctw:egDsAUdaQ7SyTchsLxJ9cNfUUz8=:eyJzY29wZSI6ImhlYWx0aGNsb3VkMiIsImRlYWRsaW5lIjoxNDk2OTI4OTg2fQ==;
// domain = img.wdjky.com;
// */
//- (RACSignal *)qiniuTokenSignal {
//    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        [[WDRequestAdapter requestSignalWithURL:API_QINIU_TOKEN
//                                         params:nil
//                                    requestType:WDRequestTypeGET
//                                   responseType:WDResponseTypeObject
//                                  responseClass:nil]
//         subscribeNext:^(WDResponseModel * _Nullable x) {
//             if (!x.data[@"token"]) {
//                 NSError *error = [NSError errorWithDomain:APP_ERROR_DOMAIN
//                                                      code:2345
//                                                  userInfo:@{NSLocalizedDescriptionKey : @"获取七牛token为空"}];
//                 [subscriber sendError:error];
//                 return;
//             }
//             NSDictionary *info = @{
//                                    @"token" : x.data[@"token"] ?: @"",
//                                    @"domain" : x.data[@"domain"] ?: @""
//                                    };
//             [subscriber sendNext:info];
//             [subscriber sendCompleted];
//         }
//         error:^(NSError * _Nullable error) {
//             [subscriber sendError:error];
//         }];
//        
//        return nil;
//    }];
//    
//    return signal;
//}


- (void)uploadImagesAndReportSignalWithImages:(NSArray<UIImage *> *)images parms:(NSDictionary*)params
                    withSuccessBlock:(void(^)(NSArray *imgURLs))successBlock
                         failreBlock:(void(^)(NSError *error))failureBlock
{
    
    
    [[WDRequestManager shareManager].sessionManager POST:@"" parameters:[NSDictionary convertParams:API_REPORT dic:params] constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i=0; i< images.count; i++)
        {
            
            NSData *imagedata = [self compressImage:[images objectAtIndex:i]];
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            formatter.dateFormat =@"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@%d.jpg", str,(arc4random() % 100001) + 500 ];
            [formData appendPartWithFileData:imagedata
                                        name:@"file"
                                    fileName:fileName
                                    mimeType:@"image/jpeg"];
        }
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        int code  = [responseObject[@"code"] intValue];
        if(code==0)
        {
            successBlock(responseObject[@"data"]);
            NSLog(@"ok");
        }
        else
        {
            
            NSNumber *errorCode = [NSNumber numberWithInt: code];
            NSDictionary *errorInfo = @{
                                        NSLocalizedDescriptionKey: responseObject[@"msg"],
                                        NSLocalizedFailureReasonErrorKey : errorCode
                                        };
            NSError *error = [NSError errorWithDomain:APP_ERROR_DOMAIN code:code userInfo:errorInfo];
            if (failureBlock) {
                failureBlock(error);
            }
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failureBlock(error);
        NSLog(@"failed");
    }];
    
    
    
    
}


@end
