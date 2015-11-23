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
    RequestBindEmail,
    RequestFindPassword
    
}JYRequestType;

@interface JYServiceData : NSObject

/**
 *  请求参数拼接
 *
 *  @param aType <#aType description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)paramStringWithRequestType:(JYRequestType)aType;



/**
 *  返回数据解析
 *
 *  @param aData <#aData description#>
 *  @param aType <#aType description#>
 *
 *  @return <#return value description#>
 */
+ (NSDictionary *)dictionaryWithResponseData:(NSData *)aData
                                 andRequestType:(JYRequestType)aType;

@end
