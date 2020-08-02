//
//  HYHomeViewModel.m
//  youbaner
//
//  Created by luzhongchang on 17/7/30.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYHomeViewModel.h"
#import "HYHomeModel.h"
#import "HYHomeCellViewModel.h"



@interface HYHomeViewModel()
@property(nonatomic ,assign) int count;
@end

@implementation HYHomeViewModel
-(id)init
{
    self =[super init];
    if(self)
    {
        self.page=1;
        self.count=20;
        [self initialize];
    }
    return self;
}


- (void) initialize
{
    @weakify(self);
    
    self.doRaccommand =[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        NSDictionary *dic=@{@"page":[NSNumber numberWithInt:self.page],
                            @"count":[NSNumber numberWithInt:self.count]};
        return [[self getList:[NSDictionary convertParams:API_HOME dic:dic]] doNext:^(WDResponseModel *  _Nullable x) {
            @strongify(self);
            
            
            if(self.page==1)
            {
                self.listArray =nil;
            }
            
            self.hasMore  = self.page <x.totalpage ?YES:NO;
            if(self.hasMore)
            {
                self.page ++;
            }
            [self convertCellViewModel:x.data];
            
        }];
    }];
    
    self.doOneUserRaccommand =[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
         self.listArray =nil;
        NSDictionary *dic=@{@"sex":self.sex };
        return [[self getList:[NSDictionary convertParams:API_HOME_ONE dic:dic]] doNext:^(WDResponseModel *  _Nullable x) {
            
            @strongify(self);
            [self convertCellViewModel:x.data];
            
        }];
    }];
    
}


- (RACSignal *)getList:(NSDictionary*)dic
{
    RACSignal *signal =[WDRequestAdapter requestSignalWithURL:@"" params:dic requestType:WDRequestTypePOST responseType:WDResponseTypeList responseClass:[HYHomeModel class]];
    return signal;
}


-(void)convertCellViewModel:(NSArray* )array
{
    
    NSMutableArray * tem =[NSMutableArray new];
    if(self.listArray.count >0)
    {
        [tem addObjectsFromArray:self.listArray];
    }
    for ( HYHomeModel * m in array)
    {
        HYHomeCellViewModel * v =[HYHomeCellViewModel viewModelWithObj:m];
        [tem addObject:v];
    }
    
    self.listArray=[tem copy];
    

}





//- (void)getHomeList
//{
//    
//    HYHomeModel * model = [HYHomeModel new];
//    model.userId=@"12";
//    model.picUrl =@"http://img.mp.itc.cn/upload/20160405/dee3fadef9f5456b962aa7547950cf99_th.jpg";
//    model.isVerify=YES;
//    model.isBeMoved =NO;
//    model.userName =@"王嘉怡";
//    model.wantToMarrayTime=@"期望一年內结婚";
//    model.age=@"28";
//    model.height=@"168";
//    model.reciveSalary=@"2.5";
//    model.constellation=@"射手座";
//    model.city=@"上海";
//    model.interduce=@"爱工作爱生活的乐观小清晰系射手座女，也可以逗比也可以暗金的做个美女子，喜欢手工喜欢宠物喜欢旅游，希望找到对的人共度一生，希望找个伴侣共度一生";
//    
//    HYHomeCellViewModel * v =[HYHomeCellViewModel viewModelWithObj:model];
//    
//    
//    HYHomeModel * modelm = [HYHomeModel new];
//    modelm.userId=@"13";
//    modelm.picUrl =@"http://img.mp.itc.cn/upload/20160405/dee3fadef9f5456b962aa7547950cf99_th.jpg";
//    modelm.isVerify=YES;
//    modelm.isBeMoved =NO;
//    modelm.userName =@"王嘉s";
//    modelm.wantToMarrayTime=@"期望一年內结婚";
//    modelm.age=@"28";
//    modelm.height=@"168";
//    modelm.reciveSalary=@"2.5";
//    modelm.constellation=@"射手座";
//    modelm.city=@"天津";
//    modelm.interduce=@"爱工作爱生活的乐观小清晰系射手座女，也可以逗比也可以暗金的做个美女子，喜欢手工喜欢宠物喜欢旅游，希望找到对的人共度一生，希望找个伴侣共度一生";
//
//    HYHomeCellViewModel * vs =[HYHomeCellViewModel viewModelWithObj:modelm];
//    self.listArray=@[v,vs ];
//    
//    
////    /*用户Id*/
////    @property (nonatomic ,copy) NSString *userId;
////    /*用户照片*/
////    @property (nonatomic ,copy) NSString *picUrl;
////    /*是否认证*/
////    @property (nonatomic ,assign) BOOL *isVerify;
////    /*是否心动*/
////    @property (nonatomic ,assign) BOOL   isBeMoved;
////    /*用户名字*/
////    @property (nonatomic ,copy) NSString *userName;
////    /* 期望结婚时间*/
////    @property (nonatomic ,copy) NSString *wantToMarrayTime;
////    /*年龄*/
////    @property (nonatomic ,copy) NSString *age;
////    /*身高*/
////    @property (nonatomic ,copy) NSString *height;
////    /*收入*/
////    @property (nonatomic ,copy) NSString *reciveSalary;
////    /*星座*/
////    @property (nonatomic ,copy) NSString *constellation;
////    /*城市*/
////    @property(nonatomic ,copy)  NSString *city;
////    /*简介*/
////    @property(nonatomic ,copy)  NSString *interduce;
//}
@end
