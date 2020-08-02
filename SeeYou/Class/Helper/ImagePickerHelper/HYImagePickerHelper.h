//
//  HYImagePickerHelper.h
//  youbaner
//
//  Created by Joseph Koh on 2018/6/29.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ImageUploadType) {
    ImageUploadTypeAvatar,
    ImageUploadTypeShowPic,
    ImageUploadTypeIdentify,
};
@interface HYImagePickerHelper : NSObject

//@property (nonatomic, assign) BOOL isUploadAvatarAction;

@property (nonatomic, copy) NSString *tips;
@property (nonatomic, assign) ImageUploadType uploadType;

/// 上传图片
- (void)showImagePickerInVC:(UIViewController *)inVC
            uploadHandler:(void(^)(NSArray<UIImage *> *imgs, NSArray<NSString *> *imgURLs, NSError *error))selectedHandler;

/// 不上传图片
- (void)showImagePickerInVC:(UIViewController *)inVC
            selectedHandler:(void(^)(NSArray<UIImage *> *imgs))selectedHandler;

- (void)uploadIdentifyPhoto:(NSArray *)photos withResult:(void(^)(NSArray *imgURLs, NSError *error))result;
@end
