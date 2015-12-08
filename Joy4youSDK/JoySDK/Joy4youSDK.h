//
//  JoySDK.h
//  JoySDK
//
//  Created by 孙永刚 on 15/11/16.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Joy4youCallback <NSObject>

@required

- (void)loginCallback:(NSDictionary *)jsonDic;

@end

/**
 *  接口类
 */
@interface Joy4youSDK : NSObject

/**
 *  初始化接口
 *
 *  @param appId     应用ID
 *  @param channelId 渠道号
 *  @param adId      talkingData后台创建的应用ID
 */
+ (void)initWithAppId:(NSString *)appId
            channelId:(NSString *)channelId
              andADId:(NSString *)adId;

/**
 *	显示SDK接口
 *
 *	@param 	(id<Joy4youCallback>)cb :  delegate Objc Class instance
 *
 */
+ (void)login:(id<Joy4youCallback>)delagate;

/**
 *  获取SDK版本号
 *
 */
+ (NSString *)sdkVersion;

/**
 *  设置log开关
 *
 *  @param enable enable 默认是开启状态
 */
+ (void)setLogEnabled:(BOOL)enable;

/**广告追踪相关**/
/**
 *  @method onCreateRole    创建角色
 *  @param  name            角色名称         类型:NSString
 */
+ (void)onCreateRole:(NSString *)name;

/**
 *  @method onPay           支付
 *  @param  account         帐号            类型:NSString
 *  @param  orderId         订单id          类型:NSString
 *  @param  amount          金额            类型:int
 *  @param  currencyType    币种            类型:NSString
 *  @param  payType         支付类型         类型:NSString
 */
+ (void)onPay:(NSString *)account withOrderId:(NSString *)orderId withAmount:(int)amount withCurrencyType:(NSString *)currencyType withPayType:(NSString *)payType;

@end
