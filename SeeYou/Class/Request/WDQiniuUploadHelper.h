//
//  WDQiniuUploadHelper.h
//  HCDoctor
//
//  Created by Joseph Gao on 2017/6/8.
//  Copyright © 2017年 WondersGroup.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDQiniuUploadHelper : NSObject

+ (instancetype)shareInstance;


- (void)uploadImagesSignalWithImages:(NSArray<UIImage *> *)images
                    withSuccessBlock:(void(^)(NSArray *imgURLs))successBlock
                         failreBlock:(void(^)(NSError *error))failureBlock;
- (void)uploadImagesSignalWithImagesWithIdentify:(NSArray<UIImage *> *)images
                                withSuccessBlock:(void(^)(WDResponseModel *model))successBlock
                                     failreBlock:(void(^)(NSError *error))failureBlock;


- (void)uploadImagesSignalWithImagesWithShowPhotos:(NSArray<UIImage *> *)images
                                withSuccessBlock:(void(^)(WDResponseModel *model))successBlock
                                     failreBlock:(void(^)(NSError *error))failureBlock;

- (void)uploadImagesAndReportSignalWithImages:(NSArray<UIImage *> *)images parms:(NSDictionary*)params
                             withSuccessBlock:(void(^)(NSArray *imgURLs))successBlock
                                  failreBlock:(void(^)(NSError *error))failureBlock;
@end
