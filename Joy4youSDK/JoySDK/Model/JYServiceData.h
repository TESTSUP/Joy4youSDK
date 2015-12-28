//
//  JYServiceData.h
//  Joy4youSDK
//
//  Created by 孙永刚 on 15/11/20.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum JYRequestType {
    RequestCheckUserid,
    RequestLoginWithSid,
    RequestLoginWithTourist,
    RequestLoginWithUsername,
    RequestLoginWithPhone,
    RequestRegistWithUsername,
    RequestRegistWithPhone,
    RequestPhoneBindEmail,
    RequestBindEmail,
    RequestBindAccount,
    RequestFindPassword,
    RequestGetVerifyCode,
    RequestVerifyCode,
    RequesSetNewPassword
    
}JYRequestType;

//数据解析错误
extern NSString *JYDesErrorDomain;

/**
 *  请求相关类,组织拼接url，处理请求参数和返回数据
 */
@interface JYServiceData : NSObject

/**
 *  请求参数拼接
 *
 *  @param aType <#aType description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)pathUrlWithParam:(NSDictionary *)aParam andRequestType:(JYRequestType)aType;

/**
 *  返回数据解析
 *
 *  @param aData <#aData description#>
 *
 *  @return <#return value description#>
 */
+ (NSDictionary *)dictionaryWithResponseData:(NSData *)aData;

@end
