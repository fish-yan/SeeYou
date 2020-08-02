//
//  HYMapInnerOpenHelper.h
//  youbaner
//
//  Created by Joseph Koh on 2018/6/25.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYMapInnerOpenHelper : UIView

+ (void)showMapSelectorInVC:(UIViewController *)inVC
      withCurrentCoordinate:(HYCoordinate *)current
              endCoordinate:(HYCoordinate *)end
                    endName:(NSString *)endName;

@end
