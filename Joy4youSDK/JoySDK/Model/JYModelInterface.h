//
//  JYModelInterface.h
//  JoySDK
//
//  Created by 孙永刚 on 15/11/18.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYUserCache.h"

typedef void (^modelCallback)(NSError *error, NSDictionary* responseData);

/**
 *  接口层
 */
@interface JYModelInterface : NSObject


+ (instancetype)sharedInstance;

+ (void)clear;

/**
 *  取消所有请求
 */
- (void)cancelAllRequest;

#pragma mark - 登录
/**
 *  用户名+密码登录接口
 *
 *  @param aName     用户名
 *  @param aPassword 密码，MD5
 *  @param aCallback <#aCallback description#>
 */
- (void)loginWithUsername:(NSString *)aName
              andPassword:(NSString *)aPassword
            callbackBlcok:(modelCallback)aCallback;

/**
 *  手机号+密码登录接口
 *
 *  @param aPhone    手机号
 *  @param aPassword 密码，MD5
 *  @param aCallback <#aCallback description#>
 */
- (void)loginWithPhoneNumber:(NSString *)aPhone
                 andPassword:(NSString *)aPassword
               callbackBlcok:(modelCallback)aCallback;

/**
 *  游客登录注册
 *
 *  @param aCallback <#aCallback description#>
 */
- (void)touristLoginWithCallbackBlcok:(modelCallback)aCallback;

/**
 *  自动登录-sid登录
 *
 *  @param aSid      session id
 *  @param aUid      user id
 *  @param aCallback <#aCallback description#>
 */
- (void)cacheLoginWithSessionId:(NSString *)aSid
                      andUserId:(NSString *)aUid
                  CallbackBlcok:(modelCallback)aCallback;

#pragma mark - 注册
/**
 *  检查用户名
 *
 *  @param aName     用户名
 *  @param aCallback <#aCallback description#>
 */
- (void)checkUsername:(NSString *)aName
        callbackBlock:(modelCallback)aCallback;

/**
 *  用户名+密码注册
 *
 *  @param aName     用户名
 *  @param aPassword 密码
 *  @param aCallback <#aCallback description#>
 */
- (void)registWithUsername:(NSString *)aName
               andPassword:(NSString *)aPassword
             callbackBlcok:(modelCallback)aCallback;

/**
 *  手机号+验证码注册
 *
 *  @param number    手机号
 *  @param code      验证码
 *  @param aCallback <#aCallback description#>
 */
- (void)registPhoneNumber:(NSString *)number
            andVerifyCode:(NSString *)code
            callbackBlcok:(modelCallback)aCallback;

/**
 *  手机号注册获取验证码
 *
 *  @param aPhone    手机号
 *  @param aCallback <#aCallback description#>
 */
- (void)registGetVerifyCodeWithPhone:(NSString *)aPhone
                       callbackBlock:(modelCallback)aCallback;
#pragma mark - 绑定
/**
 *  游客绑定正式账号
 *
 *  @param aUsername 用户名
 *  @param aPassword 密码
 *  @param aUserId   用户id
 *  @param aCallback <#aCallback description#>
 */
- (void)bindAccountWithUsername:(NSString *)aUsername
                       password:(NSString *)aPassword
                         userId:(NSString *)aUserId
                  callbackBlock:(modelCallback)aCallback;

/**
 *  绑定邮箱
 *
 *  @param aUsername 用户名
 *  @param aPassword 密码
 *  @param aEmail    邮箱地址
 *  @param aCallback <#aCallback description#>
 */
- (void)bindEmailWithUsername:(NSString *)aUsername
                     password:(NSString *)aPassword
                        email:(NSString *)aEmail
                callbackBlock:(modelCallback)aCallback;

/**
 *  手机号绑定邮箱
 *
 *  @param aPhone    手机号
 *  @param aPassword 密码
 *  @param aEmail    邮箱
 *  @param aCallback <#aCallback description#>
 */
- (void)bindEmailWithPhoneNUmber:(NSString *)aPhone
                        password:(NSString *)aPassword
                           email:(NSString *)aEmail
                   callbackBlock:(modelCallback)aCallback;

#pragma mark - 找回密码
/**
 *  找回密码
 *
 *  @param aUsername 用户名
 *  @param aEmail    邮箱
 *  @param aCallback <#aCallback description#>
 */
- (void)findPasswordWithUsername:(NSString *)aUsername
                        andEmail:(NSString *)aEmail
                   callbackBlock:(modelCallback)aCallback;

/**
 *  获取验证码
 *
 *  @param aCallback <#aCallback description#>
 */
- (void)findPasswordGetVerifyCodeWithPhone:(NSString *)aPhone
                             callbackBlock:(modelCallback)aCallback;

/**
 *  验证验证码
 *
 *  @param aCode     验证码
 *  @param aCallback <#aCallback description#>
 */
- (void)verifyCodeWithPhone:(NSString *)aPhone
                       code:(NSString *)aCode
              callbackBlock:(modelCallback)aCallback;

/**
 *  设置新密码
 *
 *  @param aPassword 密码
 *  @param aCallback <#aCallback description#>
 */
- (void)setNewPassword:(NSString *)aPassword
         callbackBlock:(modelCallback)aCallback;
@end
