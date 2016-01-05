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

- (void)dealloc
{
    [JoyRequest clear];
    [JYUserCache clear];
}

/**
 *  发送请求
 *
 *  @param urlPath   <#urlPath description#>
 *  @param aType     <#aType description#>
 *  @param aCallback <#aCallback description#>
 */
- (void)requestWith:(NSString *)urlPath requestType:(JYRequestType)aType andCallbacl:(modelCallback)aCallback
{
    [[JoyRequest shareInstance] requestWithPath:urlPath
                                     Parameters:nil
                                        success:^(NSHTTPURLResponse *response, NSData *responseData) {
                                            if (aCallback) {
                                                NSDictionary *responseDic = [JYServiceData dictionaryWithResponseData:responseData];
                                                switch (aType) {
                                                    case RequestLoginWithUsername:
                                                    case RequestLoginWithPhone:
                                                    case RequestLoginWithSid:
                                                    case RequestRegistWithUsername:
                                                    case RequestRegistWithPhone:
                                                    case RequestBindAccount:
                                                    case RequestBindPhone:
                                                    {
                                                        [[JYUserCache sharedInstance] saveCacheUserInfo:responseDic[KEY_DATA] isTourist:NO];
                                                    }
                                                        break;
                                                    case RequestLoginWithTourist:
                                                    {
                                                        [[JYUserCache sharedInstance] saveCacheUserInfo:responseDic[KEY_DATA] isTourist:YES];
                                                    }
                                                        break;
                                                    default:
                                                        break;
                                                }
                                                
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
    
    [self requestWith:urlPath requestType:RequestLoginWithUsername andCallbacl:aCallback];
}

/**
 *  手机号+密码登录接口
 *
 *  @param aPhone    手机号
 *  @param aPassword 密码，MD5
 *  @param aCallback <#aCallback description#>
 */
- (void)loginWithPhoneNumber:(NSString *)aPhone
              andPassword:(NSString *)aPassword
            callbackBlcok:(modelCallback)aCallback
{
    NSDictionary *param = @{KEY_PHONE:aPhone, KEY_PW:[aPassword MD5]};
    NSString *urlPath = [JYServiceData pathUrlWithParam:param
                                         andRequestType:RequestLoginWithPhone];
    
    [self requestWith:urlPath requestType:RequestLoginWithPhone andCallbacl:aCallback];
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
    
    [self requestWith:urlPath requestType:RequestLoginWithTourist andCallbacl:aCallback];
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
    
    [self requestWith:urlPath requestType:RequestLoginWithSid andCallbacl:aCallback];
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
    
    [self requestWith:urlPath requestType:RequestCheckUserid andCallbacl:aCallback];
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
    
    [self requestWith:urlPath requestType:RequestRegistWithUsername andCallbacl:aCallback];
}

/**
 *  手机号+验证码注册
 *
 *  @param number    手机号
 *  @param code      验证码
 *  @param aCallback <#aCallback description#>
 */
- (void)registPhoneNumber:(NSString *)number
            andVerifyCode:(NSString *)code
            callbackBlcok:(modelCallback)aCallback
{
    NSLog(@"code = %@", code);
    NSDictionary *param = @{KEY_PHONE:number, KEY_CODE:code};
    NSString *urlPath = [JYServiceData pathUrlWithParam:param
                                         andRequestType:RequestRegistWithPhone];
    
    [self requestWith:urlPath requestType:RequestRegistWithPhone andCallbacl:aCallback];
}

/**
 *  手机号注册获取验证码
 *
 *  @param aPhone    手机号
 *  @param aCallback <#aCallback description#>
 */
- (void)registGetVerifyCodeWithPhone:(NSString *)aPhone
                       callbackBlock:(modelCallback)aCallback
{
    NSDictionary *param = @{KEY_PHONE:aPhone};
    NSString *urlPath = [JYServiceData pathUrlWithParam:param
                                         andRequestType:RequestRegistGetVerifyCode];
    
    [self requestWith:urlPath requestType:RequestRegistGetVerifyCode andCallbacl:aCallback];
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
    
    [self requestWith:urlPath requestType:RequestFindPassword andCallbacl:aCallback];
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
    NSDictionary *param = @{KEY_UN:aUsername, KEY_PW:[aPassword MD5], KEY_UID:aUserId};
    NSString *urlPath = [JYServiceData pathUrlWithParam:param andRequestType:RequestBindAccount];
    
    [self requestWith:urlPath requestType:RequestBindAccount andCallbacl:aCallback];
}

/**
 *  用户名绑定邮箱
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
    NSDictionary *param = @{KEY_UN:aUsername, KEY_PW:[aPassword MD5], KEY_EMAIL:aEmail};
    NSString *urlPath = [JYServiceData pathUrlWithParam:param andRequestType:RequestBindEmail];
    
    [self requestWith:urlPath requestType:RequestBindEmail andCallbacl:aCallback];
}

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
                   callbackBlock:(modelCallback)aCallback
{
    NSDictionary *param = @{KEY_PHONE:aPhone, KEY_PW:[aPassword MD5], KEY_EMAIL:aEmail};
    NSString *urlPath = [JYServiceData pathUrlWithParam:param andRequestType:RequestPhoneBindEmail];
    
    [self requestWith:urlPath requestType:RequestPhoneBindEmail andCallbacl:aCallback];
    
}

/**
 *  获取验证码
 *
 *  @param aCallback <#aCallback description#>
 */
- (void)findPasswordGetVerifyCodeWithPhone:(NSString *)aPhone
                             callbackBlock:(modelCallback)aCallback
{
    NSDictionary *param = @{KEY_PHONE:aPhone};
    NSString *urlPath = [JYServiceData pathUrlWithParam:param andRequestType:RequestGetVerifyCode];
    
    [self requestWith:urlPath requestType:RequestGetVerifyCode andCallbacl:aCallback];
}

/**
 *  验证验证码
 *
 *  @param aCode     验证码
 *  @param aCallback <#aCallback description#>
 */
- (void)verifyCodeWithPhone:(NSString *)aPhone
                       code:(NSString *)aCode
               callbackBlock:(modelCallback)aCallback
{
    NSDictionary *param = @{KEY_PHONE:aPhone, KEY_CODE:aCode};
    NSString *urlPath = [JYServiceData pathUrlWithParam:param andRequestType:RequestVerifyCode];
    
    [self requestWith:urlPath requestType:RequestVerifyCode andCallbacl:aCallback];
}

/**
 *  设置新密码
 *
 *  @param aPassword 密码
 *  @param aCallback <#aCallback description#>
 */
- (void)setNewPassword:(NSString *)aPassword
         callbackBlock:(modelCallback)aCallback
{
    NSDictionary *param = @{KEY_PW:[aPassword MD5]};
    NSString *urlPath = [JYServiceData pathUrlWithParam:param andRequestType:RequesSetNewPassword];
    
    [self requestWith:urlPath requestType:RequesSetNewPassword andCallbacl:aCallback];
}

@end
