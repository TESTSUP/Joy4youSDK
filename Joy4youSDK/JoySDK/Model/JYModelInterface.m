//
//  JYModelInterface.m
//  JoySDK
//
//  Created by 孙永刚 on 15/11/18.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import "JYModelInterface.h"
#import "JoyRequest.h"
#import "JYServiceData.h"
#import "JYUtil.h"

@interface JYModelInterface ()
{

}

@end

@implementation JYModelInterface

static JYModelInterface *instance = nil;
static dispatch_once_t token;

+ (instancetype)sharedInstance
{
    dispatch_once(&token, ^{
        instance = [[JYModelInterface alloc] init];
    });
    
    return instance;
}


+ (void)clear
{
    token = 0;
    instance = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

#pragma mark - interface

- (void)cancelAllRequest
{
    [[JoyRequest shareInstance] cancelAllOperations];
}

/**
 *  用户名+密码登录接口
 *
 *  @param aName     用户名
 *  @param aPassword 密码，MD5
 *  @param aCallback <#aCallback description#>
 */
- (void)loginWithUsername:(NSString *)aName
              andPassword:(NSString *)aPassword
            callbackBlcok:(modelCallback)aCallback
{
    NSDictionary *param = @{KEY_UN:aName, KEY_PW:[aPassword MD5]};
    NSString *urlPath = [JYServiceData pathUrlWithParam:param
                                         andRequestType:RequestLoginWithUsername];
    
    [[JoyRequest shareInstance] requestWithPath:urlPath
                                     Parameters:nil
                                        success:^(NSHTTPURLResponse *response, NSData *responseData) {
                                            if (aCallback) {
                                                NSDictionary *responseDic = [JYServiceData dictionaryWithResponseData:responseData
                                                                                                       andRequestType:RequestLoginWithTourist];
                                                [[JYUserCache sharedInstance] saveCacheUserInfo:responseDic[KEY_DATA] isTourist:NO];
                                                NSError *error = responseDic? nil:[NSError errorWithDomain:JYDesErrorDomain code:-1 userInfo:nil];
                                                aCallback(error, responseDic);
                                            }
                                        }
                                        failure:^(NSHTTPURLResponse *response, NSError *responseERROR) {
                                            if (aCallback) {
                                                aCallback(responseERROR, nil);
                                            }
                                        }];
}

/**
 *  游客登录注册
 *
 *  @param aCallback <#aCallback description#>
 */
- (void)touristLoginWithCallbackBlcok:(modelCallback)aCallback
{
    NSString *urlPath = [JYServiceData pathUrlWithParam:nil
                                         andRequestType:RequestLoginWithTourist];
    
    [[JoyRequest shareInstance] requestWithPath:urlPath
                                     Parameters:nil
                                        success:^(NSHTTPURLResponse *response, NSData *responseData) {
                                            if (aCallback) {
                                                NSDictionary *responseDic = [JYServiceData dictionaryWithResponseData:responseData
                                                                                                       andRequestType:RequestLoginWithTourist];
                                                [[JYUserCache sharedInstance] saveCacheUserInfo:responseDic[KEY_DATA] isTourist:YES];
                                                NSError *error = responseDic? nil:[NSError errorWithDomain:JYDesErrorDomain code:-1 userInfo:nil];
                                                aCallback(error, responseDic);
                                            }
                                        }
                                        failure:^(NSHTTPURLResponse *response, NSError *responseERROR) {
                                            if (aCallback) {
                                                aCallback(responseERROR, nil);
                                            }
                                        }];
}

/**
 *  自动登录-sid登录
 *
 *  @param aSid      session id
 *  @param aUid      user id
 *  @param aCallback <#aCallback description#>
 */
- (void)cacheLoginWithSessionId:(NSString *)aSid
                      andUserId:(NSString *)aUid
                  CallbackBlcok:(modelCallback)aCallback
{
    NSString *urlPath = [JYServiceData pathUrlWithParam:@{KEY_SID:aSid,KEY_UID:aUid}
                                         andRequestType:RequestLoginWithSid];
    
    [[JoyRequest shareInstance] requestWithPath:urlPath
                                     Parameters:nil
                                        success:^(NSHTTPURLResponse *response, NSData *responseData) {
                                            if (aCallback) {
                                                NSDictionary *responseDic = [JYServiceData dictionaryWithResponseData:responseData
                                                                                                       andRequestType:RequestLoginWithTourist];
                                                NSError *error = responseDic? nil:[NSError errorWithDomain:JYDesErrorDomain code:-1 userInfo:nil];
                                                aCallback(error, responseDic);
                                            }
                                        }
                                        failure:^(NSHTTPURLResponse *response, NSError *responseERROR) {
                                            if (aCallback) {
                                                aCallback(responseERROR, nil);
                                            }
                                        }];
}



/**
 *  检查用户名
 *
 *  @param aName     用户名
 *  @param aCallback <#aCallback description#>
 */
- (void)checkUsername:(NSString *)aName
        callbackBlock:(modelCallback)aCallback
{
    NSDictionary *param = @{KEY_UN:aName};
    NSString *urlPath = [JYServiceData pathUrlWithParam:param andRequestType:RequestCheckUserid];
    
    [[JoyRequest shareInstance] requestWithPath:urlPath
                                     Parameters:nil
                                        success:^(NSHTTPURLResponse *response, NSData *responseData) {
                                            if (aCallback) {
                                                NSDictionary *responseDic = [JYServiceData dictionaryWithResponseData:responseData
                                                                                                       andRequestType:RequestCheckUserid];
                                                NSError *error = responseDic? nil:[NSError errorWithDomain:JYDesErrorDomain code:-1 userInfo:nil];
                                                aCallback(error, responseDic);
                                            }
                                        }
                                        failure:^(NSHTTPURLResponse *response, NSError *responseERROR) {
                                            if (aCallback) {
                                                aCallback(responseERROR, nil);
                                            }
                                        }];
}

/**
 *  用户名+密码注册
 *
 *  @param aName     用户名
 *  @param aPassword 密码
 *  @param aCallback <#aCallback description#>
 */
- (void)registWithUsername:(NSString *)aName
              andPassword:(NSString *)aPassword
            callbackBlcok:(modelCallback)aCallback
{
    NSDictionary *param = @{KEY_UN:aName, KEY_PW:[aPassword MD5]};
    NSString *urlPath = [JYServiceData pathUrlWithParam:param
                                         andRequestType:RequestRegistWithUsername];
    
    [[JoyRequest shareInstance] requestWithPath:urlPath
                                     Parameters:nil
                                        success:^(NSHTTPURLResponse *response, NSData *responseData) {
                                            if (aCallback) {
                                                NSDictionary *responseDic = [JYServiceData dictionaryWithResponseData:responseData
                                                                                                       andRequestType:RequestRegistWithUsername];
                                                [[JYUserCache sharedInstance] saveCacheUserInfo:responseDic[KEY_DATA] isTourist:NO];
                                                NSError *error = responseDic? nil:[NSError errorWithDomain:JYDesErrorDomain code:-1 userInfo:nil];
                                                aCallback(error, responseDic);
                                            }
                                        }
                                        failure:^(NSHTTPURLResponse *response, NSError *responseERROR) {
                                            if (aCallback) {
                                                aCallback(responseERROR, nil);
                                            }
                                        }];
}

/**
 *  找回密码
 *
 *  @param aUsername 用户名
 *  @param aEmail    邮箱
 *  @param aCallback <#aCallback description#>
 */
- (void)findPasswordWithUsername:(NSString *)aUsername
                        andEmail:(NSString *)aEmail
                   callbackBlock:(modelCallback)aCallback
{
    NSDictionary *param = @{KEY_UN:aUsername, KEY_EMAIL:aEmail};
    NSString *urlPath = [JYServiceData pathUrlWithParam:param andRequestType:RequestFindPassword];
    
    [[JoyRequest shareInstance] requestWithPath:urlPath
                                     Parameters:nil
                                        success:^(NSHTTPURLResponse *response, NSData *responseData) {
                                            if (aCallback) {
                                                NSDictionary *responseDic = [JYServiceData dictionaryWithResponseData:responseData
                                                                                                       andRequestType:RequestFindPassword];
                                                NSError *error = responseDic? nil:[NSError errorWithDomain:JYDesErrorDomain code:-1 userInfo:nil];
                                                aCallback(error, responseDic);
                                            }
                                        }
                                        failure:^(NSHTTPURLResponse *response, NSError *responseERROR) {
                                            if (aCallback) {
                                                aCallback(responseERROR, nil);
                                            }
                                        }];
}

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
                  callbackBlock:(modelCallback)aCallback
{
    NSDictionary *param = @{KEY_UN:aUsername, KEY_PW:aPassword, KEY_UID:aUserId};
    NSString *urlPath = [JYServiceData pathUrlWithParam:param andRequestType:RequestBindAccount];
    
    [[JoyRequest shareInstance] requestWithPath:urlPath
                                     Parameters:nil
                                        success:^(NSHTTPURLResponse *response, NSData *responseData) {
                                            if (aCallback) {
                                                NSDictionary *responseDic = [JYServiceData dictionaryWithResponseData:responseData
                                                                                                       andRequestType:RequestRegistWithUsername];
                                                [[JYUserCache sharedInstance] saveCacheUserInfo:responseDic[KEY_DATA] isTourist:NO];
                                                NSError *error = responseDic? nil:[NSError errorWithDomain:JYDesErrorDomain code:-1 userInfo:nil];
                                                aCallback(error, responseDic);
                                            }
                                        }
                                        failure:^(NSHTTPURLResponse *response, NSError *responseERROR) {
                                            if (aCallback) {
                                                aCallback(responseERROR, nil);
                                            }
                                        }];
}

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
                callbackBlock:(modelCallback)aCallback
{
    NSDictionary *param = @{KEY_UN:aUsername, KEY_PW:aPassword, KEY_EMAIL:aEmail};
    NSString *urlPath = [JYServiceData pathUrlWithParam:param andRequestType:RequestBindEmail];
    
    [[JoyRequest shareInstance] requestWithPath:urlPath
                                     Parameters:nil
                                        success:^(NSHTTPURLResponse *response, NSData *responseData) {
                                            if (aCallback) {
                                                NSDictionary *responseDic = [JYServiceData dictionaryWithResponseData:responseData
                                                                                                       andRequestType:RequestBindEmail];
                                                NSError *error = responseDic? nil:[NSError errorWithDomain:JYDesErrorDomain code:-1 userInfo:nil];
                                                aCallback(error, responseDic);
                                            }
                                        }
                                        failure:^(NSHTTPURLResponse *response, NSError *responseERROR) {
                                            if (aCallback) {
                                                aCallback(responseERROR, nil);
                                            }
                                        }];
}



@end
