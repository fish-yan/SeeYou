//
//  WDLinkView.h
//  PCIPatient
//
//  Created by luzhongchang on 16/8/5.
//  Copyright © 2016年 Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 搜索历史结果对应的view
 **/

/**
 如果传递的是对象 需要展示的属性 必须含有 showdes属性

 demo
 
 WDLinkView * linkview =[[WDLinkView alloc] initWithFrame:CGRectZero];
 linkview.dataArray =array;
 [self.view addSubview:linkview];
 
 ***/


typedef void(^clickHandler)(id model);
@interface WDLinkView : UIView
@property (nonatomic   ,strong)  NSArray     *dataArray;

@property(nonatomic    ,assign)  float        marginTop;

@property(nonatomic    ,assign)  float        marginBottom;

@property(nonatomic    ,assign)  float        marginLeft;

@property(nonatomic    ,assign)  float        marginright;

@property(nonatomic    ,assign)  float        paddingleft;

@property(nonatomic    ,assign)  float        paddingright;

@property(nonatomic    ,assign)  float        paddingtop;

@property(nonatomic    ,assign)  float        paddingbottom;

@property(nonatomic    ,copy)    UIColor     *labelColor;

@property(nonatomic    ,copy)    UIColor     *bgColor;

@property(nonatomic    ,copy)    UIColor     *borderColor;

@property(nonatomic    ,assign)  float        CornerRadius;

@property(nonatomic    ,assign)  float        borderwidth;

@property(nonatomic    ,assign)  float        fontsize;

@property(nonatomic    ,assign)  float        leftToright;//左右间距

@property(nonatomic    ,assign)  float        topTobottom;//上下间距

@property(nonatomic    ,assign)  float        baseParentpoint;
@property(nonatomic    ,assign)  float        baseleftPoint;

@property(nonatomic    ,assign)  float        totalHeight;

@property(nonatomic    ,copy)    clickHandler handelblock;

/**
 更新数据
 array 传入数据
 **/
-(void)upContent:(NSArray *)array;
@end
