//
//  CPPickerViewModel.h
//  youbaner
//
//  Created by Joseph Koh on 2018/6/20.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPPickerViewModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *mid;
@property (nonatomic, strong) NSArray *subArr;

+ (instancetype)modelWithName:(NSString *)name mid:(NSNumber *)mid;

@end
