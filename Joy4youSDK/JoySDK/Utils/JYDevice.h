//
//  JoyDevice.h
//  JoySDK
//
//  Created by 孙永刚 on 15/11/16.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYDevice : NSObject

/**
 *  获取设备所有信息
 *
 *  @return <#return value description#>
 */
+ (NSDictionary *)deviceInfo;

/**
 *  应用id
 *
 *  @return <#return value description#>
 */
+ (NSString *)appId;

/**
 *  渠道id
 *
 *  @return <#return value description#>
 */
+ (NSString *)channelId;

/**
 *  设备id
 *
 *  @return <#return value description#>
 */
+ (NSString *)ckid;

@end
