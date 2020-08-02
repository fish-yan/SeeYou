//
//  IndentifityAuthenViewModel.m
//  youbaner
//
//  Created by luzhongchang on 17/8/1.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "IndentifityAuthenViewModel.h"
#import "IndentifityAuthenDescriptionModel.h"


@interface IndentifityAuthenViewModel()

@end

@implementation IndentifityAuthenViewModel
-(id)init
{
    self =[super init];
    if(self)
    {
    
    }
    return self;
}

-(void)GetDataList
{
    
    IndentifityAuthenDescriptionModel * model =[IndentifityAuthenDescriptionModel new];
    model.iconName=@"identifyicon";
    model.title=@"为什么要身份认证";
    model.des=@"花缘作为一个真实、严肃的婚恋平台，我们要求用户必须完成身份认证；对于以诚心交友、恋爱、结婚为目的的用户，我们希望提供一个无酒托、婚托的婚恋环境";
    
    IndentifityAuthenDescriptionModel * model1 =[IndentifityAuthenDescriptionModel new];
    model1.iconName=@"secrecticon";
    model1.title=@"关于隐私安全";
    model1.des=@"您上传的任何身份证照片等资料，仅供审核使用且TA人无法查看，敬请放心";
    
    self.listArray =@[model,model1];
    
    
    IndentifityAuthenUploadModel * uploadTemodel =[IndentifityAuthenUploadModel new];
    uploadTemodel.forwordPicUrl=@"";
    uploadTemodel.backPicUrl=@"";
    
    self.uploadViewModel =[IndentituAuthenUploadIdentifyPhotoCellViewModel viewModelWithObj:uploadTemodel];
    
    
    
}


-(void)loadSection
{
    NSMutableArray *tem =[NSMutableArray new];
    [tem addObject:[NSNumber numberWithInt:IndentifityAuthenDescriptionType ]];
    [tem addObject:[NSNumber numberWithInt:IndentifityAuthenUploadPhtotoType ]];
    self.SectionArray = [tem copy];
}










@end
