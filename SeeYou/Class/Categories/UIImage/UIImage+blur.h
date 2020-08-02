//
//  UIImage+blur.h
//  youbaner
//
//  Created by luzhongchang on 17/8/18.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accelerate/Accelerate.h>
@interface UIImage (blur)

+(UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;
+(UIImage*) defaultImage:(NSString *)name;
@end
