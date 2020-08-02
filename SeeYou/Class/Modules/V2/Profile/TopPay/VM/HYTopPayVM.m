//
//  HYTopPayVM.m
//  youbaner
//
//  Created by Joseph Koh on 2018/6/21.
//  Copyright © 2018 luzhongchang. All rights reserved.
//

#import "HYTopPayVM.h"
#import "HYPopDataModel.h"


@implementation HYTopPayVM

- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
//    self.popViewHeight = 320.0;

//    @weakify(self);
//
//    self.TrayHasExtraRaccommand=[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSDictionary*  _Nullable input) {
//        @strongify(self);
//        return [[self getExtra:[NSDictionary convertParams:API_PREPAYMENTOEDER dic:input]] doNext:^(WDResponseModel *_Nullable x) {
//            @strongify(self);
//            self.extraModel = x.data;
//        }];
//    }];
//
//    self.topDisplayRaccommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *_Nonnull(NSDictionary *_Nullable input) {
//        @strongify(self);
//        return [[self gettopData:[NSDictionary convertParams:API_getmemberproduct dic:input]] doNext:^(WDResponseModel *_Nullable x) {
//            @strongify(self);
//            NSLog(@"%@", x.data);
//            self.listArr = (NSArray *) x.data;
//        }];
//    }];
//
//
//    self.matchMakerRaccommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *_Nonnull(NSDictionary *_Nullable input) {
//        @strongify(self);
//        return [[self getMatchData:[NSDictionary convertParams:API_getmemberproduct dic:input]]
//        doNext:^(WDResponseModel *_Nullable x) {
//            @strongify(self);
//            self.listArr = (NSArray *) x.data;
//            NSLog(@"%@", x.data);
//        }];
//    }];
//
    
    self.tips = @"开通后，【遇见】页面置顶显示您的排名，海量异性消息，收到你手软。";
    self.productIdentifiers = @[@"zhiding0003", @"zhiding0002", @"zhiding0001"];
    self.identifier = self.productIdentifiers[0];
    self.dataArray = @[
                       @{@"title": @"首页置顶7天", @"price": @"¥588.00", @"desc": @"首页置顶7天，增加您的曝光度"},
                       @{@"title": @"首页置顶3天", @"price": @"¥268.00", @"desc": @"首页置顶3天，增加您的曝光度"},
                       @{@"title": @"首页置顶1天", @"price": @"¥98.00", @"desc": @"首页置顶1天，增加您的曝光度"},
                       ];
    
}

- (void)setItemSelectedIdx:(NSInteger)itemSelectedIdx {
    _itemSelectedIdx = itemSelectedIdx;
    
    self.identifier = self.productIdentifiers[itemSelectedIdx];
}

- (NSArray *)sortPrice:(NSArray<SKProduct *> *)products {
    NSArray *arr = [products sortedArrayUsingComparator:^NSComparisonResult(SKProduct * _Nonnull obj1, SKProduct * _Nonnull obj2) {
        return [obj2.price compare:obj1.price];
    }];
    return arr;
}


- (NSArray *)updateDataArray:(NSArray *)dataList {
    NSMutableArray *dataArray = [NSMutableArray array];
    NSArray *data = [self sortPrice:dataList];
    for (NSInteger i = 0; i < data.count; i++) {
        SKProduct *product = data[i];
        
        NSLog(@"SKProduct id：%@\t产品标题：%@\t描述信息：%@ \t价格：%@",
              product.productIdentifier,
              product.localizedTitle,
              product.localizedDescription,
              product.price);
        
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
        [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [numberFormatter setLocale:product.priceLocale];
        NSString *formattedPrice = [numberFormatter stringFromNumber:product.price];
        
        [dataArray addObject:@{
                               @"title": product.localizedTitle ?: @"",
                               @"desc": product.localizedDescription ?: @"",
                               @"price": formattedPrice,
                               @"identifier": product.productIdentifier
                               }];
    }
    
    self.dataArray = dataArray.copy;
    
    return self.dataArray;
}
//- (NSArray *)updateDataArray:(NSArray *)data {
//    NSMutableArray *dataArray = [NSMutableArray array];
//    for (NSInteger i = data.count - 1; i >= 0; i--) {
//        SKProduct *product = data[i];
//
//        NSLog(@"SKProduct id：%@\t产品标题：%@\t描述信息：%@ \t价格：%@",
//              product.productIdentifier,
//              product.localizedTitle,
//              product.localizedDescription,
//              product.price);
//
//        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
//        [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
//        [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
//        [numberFormatter setLocale:product.priceLocale];
//        NSString *formattedPrice = [numberFormatter stringFromNumber:product.price];
//
//        [dataArray addObject:@{
//                               @"title": product.localizedTitle ?: @"",
//                               @"desc": product.localizedDescription ?: @"",
//                               @"price": formattedPrice
//                               }];
//    }
//
//    self.dataArray = dataArray.copy;
//
//    return self.dataArray;
//}
//
//- (RACSignal *)gettopData:(NSDictionary *)dic {
//    RACSignal *sig = [WDRequestAdapter requestSignalWithURL:@""
//                                                     params:dic
//                                                requestType:WDRequestTypePOST
//                                               responseType:WDResponseTypeList
//                                              responseClass:[HYPopDataModel class]];
//    return sig;
//}
//
//- (RACSignal *)getMatchData:(NSDictionary *)dic {
//    RACSignal *sig = [WDRequestAdapter requestSignalWithURL:@""
//                                                     params:dic
//                                                requestType:WDRequestTypePOST
//                                               responseType:WDResponseTypeList
//                                              responseClass:[HYPopDataModel class]];
//    return sig;
//}
//
//- (RACSignal *)getExtra:(NSDictionary *)dic {
//    RACSignal *sig = [WDRequestAdapter requestSignalWithURL:@""
//                                                     params:dic
//                                                requestType:WDRequestTypePOST
//                                               responseType:WDResponseTypeObject
//                                              responseClass:[prepayappointmentModel class]];
//    return sig;
//}
//
//
//
//- (void)setType:(HYPopPayType)type {
//    _type = type;
//    
//    _popViewHeight = 320.0;
//    _tips = @"开通后，【遇见】页面置顶显示您的排名，海量异性消息，收到你手软。";
//    _listArr = @[
//                 [HYPopDataModel new],
//                 [HYPopDataModel new],
//                 [HYPopDataModel new],
//                 ];
//    
//    if (self.type == HYPopPayTypeMatchMaker) {
//        _popViewHeight = 360.0;
//        _tips = @"红娘推荐属于增值服务，开通后可享受精准推荐服务，找最合适的Ta，仅需0.1秒";
//        _listArr = @[
//                     [HYPopDataModel new],
//                     [HYPopDataModel new],
//                     [HYPopDataModel new],
//                     [HYPopDataModel new],
//                     ];
//    }
//}

@end
