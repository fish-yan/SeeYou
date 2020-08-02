//
//  IndentifityAuthenViewModel.h
//  youbaner
//
//  Created by luzhongchang on 17/8/1.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"
#import "IndentituAuthenUploadIdentifyPhotoCellViewModel.h"
typedef enum : NSUInteger {
    IndentifityAuthenDescriptionType,
    IndentifityAuthenUploadPhtotoType,
} IndentifityAuthenType;

@interface IndentifityAuthenViewModel : HYBaseViewModel

@property(nonatomic,strong) NSArray *SectionArray;
@property(nonatomic ,strong) NSArray *listArray;

@property(nonatomic ,strong) IndentituAuthenUploadIdentifyPhotoCellViewModel* uploadViewModel;

-(void)loadSection;
-(void)GetDataList;
@end
