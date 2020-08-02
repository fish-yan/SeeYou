//
//  HYAreaDataInstance.m
//  youbaner
//
//  Created by luzhongchang on 17/8/15.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYAreaDataInstance.h"




@implementation AreaDataModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"iD":@"id"
             };
}

@end


@interface  HYAreaDataInstance()
@property(nonatomic ,strong) NSArray *dataArray;


@end
@implementation HYAreaDataInstance

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static HYAreaDataInstance *instance = nil;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        [instance initialize];
    });
    return instance;
}

- (void)initialize {
    
    NSError *error=nil;
    
    // 通过指定的路径读取文本内容
    NSString *str = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Area"ofType:@"json"] encoding:NSUTF8StringEncoding error:&error];
    NSDictionary *dic =[self dictionaryWithJsonString:str];
    self.dataArray= [AreaDataModel mj_objectArrayWithKeyValuesArray:[dic objectForKey:@"data"]];
    [self getProviceData];
}



-  (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}



- (void)getProviceData
{
    
    
    NSMutableArray*temappay = [NSMutableArray new];
    
    for (AreaDataModel *m  in self.dataArray) {
        if([m.level intValue]==1)
        {
            [temappay addObject:m];
        }
    }
    
    self.proviceArray =[[temappay copy] sortedArrayUsingComparator:^NSComparisonResult(AreaDataModel*  _Nonnull obj1, AreaDataModel*  _Nonnull obj2) {
        NSComparisonResult result = [obj1.pinyin compare:obj2.pinyin];
        if(result == NSOrderedSame)
        {
            result =[obj1.pinyin compare:obj2.pinyin];
        }
        return result;
    }];
   

}
- (NSArray *) getDistritData:(int)parentcode
{
    NSMutableArray*temappay = [NSMutableArray new];
    
    for (AreaDataModel *m  in self.dataArray) {
        if([m.parent intValue]==parentcode)
        {
            [temappay addObject:m];
        }
    }
    
    return [[temappay copy] sortedArrayUsingComparator:^NSComparisonResult(AreaDataModel*  _Nonnull obj1, AreaDataModel*  _Nonnull obj2) {
        NSComparisonResult result = [obj1.pinyin compare:obj2.pinyin];
        if(result == NSOrderedSame)
        {
            result =[obj1.pinyin compare:obj2.pinyin];
        }
        return result;
    }];
}

-(NSArray *) getAreaData:(int)parentcode
{
    NSMutableArray*temappay = [NSMutableArray new];
    
    for (AreaDataModel *m  in self.dataArray) {
        if([m.parent intValue]==parentcode)
        {
            [temappay addObject:m];
        }
    }
    
    return [[temappay copy] sortedArrayUsingComparator:^NSComparisonResult(AreaDataModel*  _Nonnull obj1, AreaDataModel*  _Nonnull obj2) {
        NSComparisonResult result = [obj1.pinyin compare:obj2.pinyin];
        if(result == NSOrderedSame)
        {
            result =[obj1.pinyin compare:obj2.pinyin];
        }
        return result;
    }];
}



- (int) findAreaData:(NSArray *)array  key:(NSNumber *)code
{
    if(code==nil)
    {
        return 0;
    }
    for (int i=0; i<array.count; i++) {
        AreaDataModel *d = [array objectAtIndex:i];
        if([d.iD compare:code]== NSOrderedSame)
        {
            return i;
        }
    }
    
    return 0;
}


@end
