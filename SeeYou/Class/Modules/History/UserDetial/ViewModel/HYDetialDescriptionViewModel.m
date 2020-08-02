//
//  HYDetialDescriptionViewModel.m
//  youbaner
//
//  Created by luzhongchang on 17/8/2.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYDetialDescriptionViewModel.h"
#import "HYUserCenterBaseModel.h"
#import "IndentifityAuthenDescriptionCell.h"
@implementation HYDetialDescriptionViewModel

-(id)init
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}
+ (instancetype)viewModelWithObj:(id)obj {
    HYDetialDescriptionViewModel *vm = [[self alloc] init];
    [vm setObj:obj];
    return vm;
}

-(void)setObj:(HYUserCenterBaseModel *)obj
{
    self.title = obj.title;
    
    NSMutableAttributedString *s = [HYDetialDescriptionViewModel getNSMutableAttributedString:obj.value];
    self.des = s;
    
}

+(NSMutableAttributedString*)getNSMutableAttributedString:(NSString *)string
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:0];
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:15], NSParagraphStyleAttributeName: paragraphStyle};
    
    [attributedString addAttributes:dic range:NSMakeRange(0, [string length])];
    return attributedString;
}
@end
