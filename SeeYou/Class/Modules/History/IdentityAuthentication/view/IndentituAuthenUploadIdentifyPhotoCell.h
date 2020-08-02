//
//  IndentituAuthenUploadIdentifyPhotoCell.h
//  youbaner
//
//  Created by luzhongchang on 17/8/1.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseTableViewCell.h"

typedef void(^FrowardImageBlock)();
typedef void(^BackWardImageBlock)();

@interface IndentituAuthenUploadIdentifyPhotoCell : HYBaseTableViewCell

@property(nonatomic ,copy) FrowardImageBlock frowardblock;
@property(nonatomic ,copy) BackWardImageBlock backwardblock;
@property(nonatomic ,assign) int source;

-(void)BindViewmodel:(HYBaseViewModel *)vm;

@end
