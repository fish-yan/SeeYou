//
//  IndentifityAuthenDescriptionModel.m
//  youbaner
//
//  Created by luzhongchang on 17/8/1.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "IndentifityAuthenDescriptionModel.h"

@implementation IndentifityAuthenDescriptionModel

@end
@implementation IndentifityAuthenUploadModel

-(id)init
{
    self =[super init];
    if(self)
    {
        UIImage *forwardimage = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"forwardimage"]];
        UIImage *backwordimage =[UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"backwardimage"]];
        
        self.forwardimage = forwardimage;
        self.backwardimage = backwordimage;
    }
    return self;
}

@end
