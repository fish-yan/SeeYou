//
//  PrivateMessageDetialListViewModel.m
//  huanyuan
//
//  Created by luzhongchang on 17/8/7.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "PrivateMessageDetialListViewModel.h"
#import "PrivateMessageDetiaModel.h"

@interface PrivateMessageDetialListViewModel()
@property(nonatomic,assign) int page;
@property(nonatomic,assign) int count;

@end

@implementation PrivateMessageDetialListViewModel



- (id)init
{
    self =[super init];
    if(self)
    {
        self.page=1;
        self.count=1000;
        [self initalize];
    }
    return self;
}



- (void)initalize
{
    @weakify(self);
    self.doCommond =[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        @strongify(self);
        NSDictionary *dic=nil;
        
//        if(self.lastdate.length>0)
//        {
//            dic =@{@"fromuid":self.uid,@"page":[NSString stringWithFormat:@"%d",self.page], @"count": [NSString stringWithFormat:@"%d",self.count],@"lastdate":self.lastdate };
//        }
//        else
        {
            self.listArray=nil;
            
            dic =@{@"fromuid":self.uid,@"page":[NSString stringWithFormat:@"%d",self.page], @"count": [NSString stringWithFormat:@"%d",self.count] };
            
        }
        
        return [[ self getmessagelist:[NSDictionary convertParams:API_MESSAGELISTBYUSERID dic:dic]] doNext:^(WDResponseModel*  _Nullable x) {
            @strongify(self);
            self.lastdate = x.extra;
//            if(self.page < x.totalpage)
//            {
//                self.page ++;
//            }
            [self getlist:x.data];
        }];
    }];
    
    
    
    
    
    self.doSendMessageCommond=[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        NSDictionary *dic=@{@"touid":self.uid,@"content":self.content};
        
        return [[self getmessagelist:[NSDictionary convertParams:API_SENDMESSAGE dic:dic]] doNext:^(WDResponseModel *  _Nullable x) {
            
            NSLog(@"%@",x.data);
        }];
        
    }];
    
    
    self.pBUserCommand =[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        return [[self pBlackUser:[NSDictionary  convertParams:API_BLACKUSER dic:input]]   doNext:^(id  _Nullable x) {
            
        } ];
    }];
}

- (RACSignal*)getmessagelist:(NSDictionary*)dic
{
    RACSignal *signal =[WDRequestAdapter requestSignalWithURL:@"" params:dic requestType:WDRequestTypePOST responseType:WDResponseTypeList responseClass:[PrivateMessageDetiaModel class]];
    return signal;
}

- (RACSignal*) senMesage:(NSDictionary*)dic
{
    
    RACSignal *signal =[WDRequestAdapter requestSignalWithURL:@"" params:dic requestType:WDRequestTypePOST responseType:WDResponseTypeObject responseClass:[NSString class]];
    return signal;
}


-(RACSignal*) pBlackUser:(NSDictionary*)dic
{
    RACSignal *signal =[WDRequestAdapter requestSignalWithURL:@"" params:dic requestType:WDRequestTypePOST responseType:WDResponseTypeObject responseClass:[NSString class]];
    return signal;
}

//数据组装 并且需要排序
-(void)getlist:(NSArray*)array
{
    
    
    //取出list里面的数据
    
//    NSMutableArray * temlist=[NSMutableArray new];
//    for (int i=0; i<self.listArray.count; i++)
//    {
//        
//        PrivateMessageModel * m  = [self.listArray objectAtIndex:i];
//
//        [temlist addObjectsFromArray:m.array];
//    }
//
   
    
    //进行分组
    
    
    NSMutableArray *set=[NSMutableArray new];
    for (PrivateMessageDetiaModel * m in array)
    {
     
        BOOL has =NO;
        for (int mj=0; mj< set.count; mj++)
        {
            
            if([m.time isEqualToString: [set objectAtIndex:mj]])
            {
                has =YES;
                break;
            }
            
            
        }
        
        if(has ==NO)
        {
            [set addObject:m.time];
        }
        
        
        
    }
  
    NSArray *temlist = [[array reverseObjectEnumerator] allObjects] ;
    NSMutableArray *returnArray =[NSMutableArray new];
    NSInteger numner = set.count -1;
    for (int i=(int)numner; i>=0; i--)
    {
        PrivateMessageModel *m =[PrivateMessageModel new];
        m.time = [set objectAtIndex:i];
        NSMutableArray *sorttemArray =[NSMutableArray new];
        for (PrivateMessageDetiaModel * dem in temlist)
        {
            if([dem.time isEqualToString:m.time])
            {
                [sorttemArray addObject:dem];
            }
        }
        m.array = [sorttemArray copy];
        [returnArray addObject:m];
    }
    
    
    
    self.listArray = [returnArray copy];
    
    
    
    
    
    
}




@end
