//
//  IndentifityAuthenDescriptionModel.h
//  youbaner
//
//  Created by luzhongchang on 17/8/1.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseModel.h"

@interface IndentifityAuthenDescriptionModel : HYBaseModel
@property(nonatomic ,copy) NSString *iconName;
@property(nonatomic ,copy) NSString *title;
@property(nonatomic ,copy) NSString * des;
@end

@interface IndentifityAuthenUploadModel : HYBaseModel
@property(nonatomic,copy) NSString * forwordPicUrl;
@property(nonatomic,copy) NSString *backPicUrl;
@property(nonatomic,strong) UIImage * forwardimage;
@property(nonatomic,strong) UIImage * backwardimage;

@end
