//
//  HYOneKeyUserModel.h
//  youbaner
//
//  Created by Joseph Koh on 2018/6/26.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYOneKeyUserModel : HYBaseModel

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *height;

@end
