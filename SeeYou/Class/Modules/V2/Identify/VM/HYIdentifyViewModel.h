//
//  HYIdentifyViewModel.h
//  SeeYou
//
//  Created by Joseph Koh on 2018/7/16.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYBaseViewModel.h"

@interface HYIdentifyViewModel : HYBaseViewModel

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) UIImage *frontIdPhoto;
@property (nonatomic, strong) UIImage *backIdPhoto;

@end
