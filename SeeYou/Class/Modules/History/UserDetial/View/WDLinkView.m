//
//  WDLinkView.m
//  PCIPatient
//
//  Created by luzhongchang on 16/8/5.
//  Copyright © 2016年 Joseph. All rights reserved.
//

#import "WDLinkView.h"


@implementation WDLinkView

- (id)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor =[UIColor redColor];
    
        self.marginLeft =10.0;
        self.marginright=15.0;
        self.marginTop=0.0;
        self.marginBottom=10.0;
        self.leftToright =15;
        self.topTobottom =10;
        self.paddingleft=15;
        self.paddingright =15;
        self.paddingtop =6;
        self.paddingbottom=6;
        self.labelColor =[UIColor tc7d7d7dColor];
        self.borderColor =[UIColor colorWithHexString:@"dddddd"];
        self.CornerRadius=3;
        self. borderwidth=0.0;
        self.fontsize =15;
        self.baseleftPoint=90;
        [self bindmodel];
    }
    return self;
}

- (void)upContent:(NSArray *)array
{

    float columnDistance=0.0;
    float rowDistance =0.0;
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    for (int i=0; i<array.count; i++)
    {
    
        NSString *showdes=@"";
    if ([[array objectAtIndex:i] isKindOfClass:[NSString class]])
    {
        showdes = [array objectAtIndex:i];
        if ([showdes length] > 20) {
            showdes =  [showdes substringToIndex:8];
            showdes =  [showdes stringByAppendingString:@"..."];
        }
    }
    else
    {
        
        showdes = [array objectAtIndex:i];
        //showdes =(NSString *)[[array objectAtIndex:i] objectForKey:@"showdes"];
    }
    
    
        float distance = [NSString getStringWidth:showdes font:Font_PINGFANG_SC(self.fontsize) height:self.fontsize];
        
        if(rowDistance +distance+self.paddingleft+self.paddingright >SCREEN_WIDTH-self.marginLeft -self.marginright-self.baseleftPoint)
        {
            rowDistance=0.0;
            columnDistance = columnDistance + self.topTobottom + self.paddingtop +self.paddingbottom + self.fontsize ;
        }
        
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(self.marginLeft+ rowDistance,self.marginTop + columnDistance , distance+self.paddingleft+self.paddingright, self.fontsize+self.paddingtop+self.paddingbottom)];
    
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
           
            if(self.handelblock)
            {
                self.handelblock([array objectAtIndex:i]);
            }
        }];
    
        
        rowDistance = rowDistance + button.frame.size.width + self.leftToright;
        button.titleLabel.font =Font_PINGFANG_SC(self.fontsize);
        [button setTitle:showdes forState:UIControlStateNormal];
        [button setTitleColor:self.labelColor forState:UIControlStateNormal];
        [button setTitleColor:self.borderColor forState:UIControlStateHighlighted];
        [button.layer setMasksToBounds:YES];
        [button.layer setBorderWidth:self.borderwidth];
        [button.layer setCornerRadius:self.CornerRadius];
        [button.layer setBorderColor:self.borderColor.CGColor];
        button.backgroundColor = self.bgColor;
        [self addSubview:button];
    }
    
    
    
     columnDistance = columnDistance + self.topTobottom + self.paddingtop +self.paddingbottom + self.fontsize ;
    
    
    self.frame =CGRectMake(self.baseleftPoint, self.baseParentpoint, SCREEN_WIDTH-self.baseleftPoint, columnDistance + self.marginBottom);

    self.totalHeight = columnDistance + self.marginBottom;
}
- (void)bindmodel
{
    
    @weakify(self);
    [RACObserve(self, dataArray)subscribeNext:^(NSArray * x) {
        
        if(x)
        {
            @strongify(self);
        
        [self upContent:x];
        }
        
    }];

}
@end
