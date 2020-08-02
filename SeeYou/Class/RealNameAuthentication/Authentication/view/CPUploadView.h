//
//  CPUploadView.h
//  CPPatient
//
//  Created by luzhongchang on 2017/8/30.
//  Copyright © 2017年 Jam. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^uploadBlock)(void);

@interface CPUploadView : UIView

@property(nonatomic ,strong) UIImage * picimage;
@property(nonatomic ,strong) UIImage * uploadImage;
@property(nonatomic ,strong) NSString *picurl;
@property(nonatomic ,strong) NSString * titleString;
@property(nonatomic ,strong) NSString * desString;
@property(nonatomic ,copy) uploadBlock block;
@end
