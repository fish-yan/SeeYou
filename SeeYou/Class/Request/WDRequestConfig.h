//
//  WDRequestConfig.h
//  MyProject
//
//  Created by Joseph Gao on 2017/5/2.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WDRequestType) {
    WDRequestTypeGET = 0,   // GET 请求
    WDRequestTypePOST,      // POST 请求
    WDRequestTypeDELETE,    // DELETE 请求
    WDRequestTypePUT,       // PUT 请求
    WDRequestTypeUPLOAD     // 上传数据请求
};

typedef NS_ENUM(NSInteger, WDResponseType) {
    WDResponseTypeObject = 0,   // 请求类型为对象
    WDResponseTypeList,         // 请求类型为列表(列表有固定的接口格式)
    WDResponseTypeMessage,      // 请求类型为消息类型,(返回为Dictionary格式)
};

typedef NS_ENUM(NSInteger, RequestCompeleteType) {
    RequestCompeleteEmpty = 100,    //空数据
    RequestCompeleteNoWifi,         //没有网络
    RequestCompeleteError,          //错误数据
    RequestCompeleteSuccess         //成功数据
};


@interface WDRequestConfig : NSObject

/// 请求的公钥
UIKIT_EXTERN NSString *const kRequestPublicKey;
/// 响应数据解密私钥
UIKIT_EXTERN NSString *const kResponsePrivateKey;

/// 服务器Base URL
UIKIT_EXTERN NSString *const kServerBaseURL;
/// H5页面BaseURL
UIKIT_EXTERN NSString *const kH5BaseURL;

@end
