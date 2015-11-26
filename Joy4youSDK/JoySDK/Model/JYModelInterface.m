//
//  JYModelInterface.m
//  JoySDK
//
//  Created by 孙永刚 on 15/11/18.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import "JYModelInterface.h"
#import "JYUserCache.h"
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

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

#pragma mark - interface

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
                                            
                                        }
                                        failure:^(NSHTTPURLResponse *response, NSError *responseERROR) {
                                            
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
                                            
                                        }
                                        failure:^(NSHTTPURLResponse *response, NSError *responseERROR) {
                                            
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
                                            
                                        }
                                        failure:^(NSHTTPURLResponse *response, NSError *responseERROR) {
                                            
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
                                            
                                        }
                                        failure:^(NSHTTPURLResponse *response, NSError *responseERROR) {
                                            
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
                                            
                                        }
                                        failure:^(NSHTTPURLResponse *response, NSError *responseERROR) {
                                            
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
                                            
                                        }
                                        failure:^(NSHTTPURLResponse *response, NSError *responseERROR) {
                                            
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
                                            
                                        }
                                        failure:^(NSHTTPURLResponse *response, NSError *responseERROR) {
                                            
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
                                            
                                        }
                                        failure:^(NSHTTPURLResponse *response, NSError *responseERROR) {
                                            
                                        }];
}



@end
