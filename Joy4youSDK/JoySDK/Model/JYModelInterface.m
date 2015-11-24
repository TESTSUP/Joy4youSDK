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
 *  检查用户名
 *
 *  @param aName     用户名
 *  @param aCallback <#aCallback description#>
 */
- (void)checkUsername:(NSString *)aName
        callbackBlock:(modelCallback)aCallback
{
    NSDictionary *param = @{KEY_UN:aName};
    NSString *urlPath = [JYServiceData pathUrlWithParam:param andRequestType:RequestLoginWithUsername];
    
    [[JoyRequest shareInstance] requestWithPath:urlPath
                                     Parameters:nil
                                        success:^(NSHTTPURLResponse *response, NSData *responseData) {
                                            
                                        }
                                        failure:^(NSHTTPURLResponse *response, NSError *responseERROR) {
                                            
                                        }];
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
    NSDictionary *param = @{KEY_UN:aName, KEY_PW:[JYUtil md5:aPassword]};
    NSString *urlPath = [JYServiceData pathUrlWithParam:param andRequestType:RequestLoginWithUsername];
    
    [[JoyRequest shareInstance] requestWithPath:urlPath
                                     Parameters:nil
                                        success:^(NSHTTPURLResponse *response, NSData *responseData) {
                                            
                                        }
                                        failure:^(NSHTTPURLResponse *response, NSError *responseERROR) {
                                            
                                        }];
}














@end
