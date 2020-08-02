//
//  NSDictionary+Convert.h
//  youbaner
//
//  Created by luzhongchang on 17/8/14.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Convert)
+(NSDictionary*)convertParams:(NSString*)urlcode dic:(NSDictionary*)dic;
@end
