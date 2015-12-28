//
//  Joy4youSDK_Unity3d.m
//  Joy4youSDK
//
//  Created by joy4you on 15/12/18.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import "Joy4youSDK_Unity3d.h"
#import "Joy4youSDK.h"

#if defined(__cplusplus)
extern "C"{
#endif
    extern void UnitySendMessage(const char *, const char *, const char *);
    extern NSString* _CreateNSString (const char* string);
    extern char *_MakeStringCopy(const char* string);
#if defined(__cplusplus)
}
#endif

@interface Joy4youSDK_Unity3d() <Joy4youCallback>

+ (instancetype)instance;

@end

@implementation Joy4youSDK_Unity3d

static Joy4youSDK_Unity3d *instance = nil;
static dispatch_once_t token ;

+ (instancetype)instance
{
    dispatch_once(&token, ^{
        instance = [[Joy4youSDK_Unity3d alloc] init];
    });
    
    return instance;
}

//初始化SDK
- (void)login
{
    [Joy4youSDK login:self];
}

- (void)onCreateRole:(NSString *)name
{
    [Joy4youSDK onCreateRole:name];
}

- (void)onPay:(NSString *)payInfo
{
    [Joy4youSDK onPay:@"" withOrderId:@"" withAmount:0 withCurrencyType:@"" withPayType:@""];
}

#pragma mark - Joy4youCallback

- (void)loginCallback:(NSDictionary *)jsonDic
{
    NSError *error = nil;
    NSData *callbackData = [NSJSONSerialization dataWithJSONObject:jsonDic
                                                           options:0
                                                             error:&error];
    NSString *responseStr = [[NSString alloc] initWithBytes:[callbackData bytes]
                                                     length:[callbackData length]
                                                   encoding:NSUTF8StringEncoding];
    
//    UnitySendMessage("Main", "loginCallbackMethod", _MakeStringCopy([responseStr UTF8String]));
}

@end




#pragma mark - C interace

#if defined(__cplusplus)
extern "C"{
#endif
    
    //字符串转化的工具函数
    NSString* _CreateNSString (const char* string)
    {
        if (string)
            return [NSString stringWithUTF8String: string];
        else
            return [NSString stringWithUTF8String: ""];
    }
    
    char* _MakeStringCopy( const char* string)
    {
        if (NULL == string) {
            return NULL;
        }
        char* res = (char*)malloc(strlen(string)+1);
        strcpy(res, string);
        return res;
    }

    /**
     *  登录接口
     */
    void login()
    {
        [[Joy4youSDK_Unity3d instance] login];
    }
    
    /**
     *  创建角色接口
     *
     *  @param name 角色名
     */
    void onCreateRole(const char* name)
    {
        [[Joy4youSDK_Unity3d instance] onCreateRole:_CreateNSString(name)];
    }
    
    /**
     *  支付接口
     *
     *  @param payInfo 支付信息
     */
    void onPay(const char *payInfo)
    {
        [[Joy4youSDK_Unity3d instance] onCreateRole:_CreateNSString(payInfo)];
    }
    
#if defined(__cplusplus)
}
#endif
