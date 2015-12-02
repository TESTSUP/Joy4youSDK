//
//  JYServiceData.m
//  Joy4youSDK
//
//  Created by 孙永刚 on 15/11/20.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import "JYServiceData.h"
#import "JYDevice.h"
#import "JoyEncryption.h"
#import "JYUserCache.h"

const NSString * JYDesErrorDomain = @"com.joy4you.des";

@implementation JYServiceData

+ (NSString *)pathUrlWithParam:(NSDictionary *)aParam andRequestType:(JYRequestType)aType
{
    NSString *path = @"";
    NSDictionary *paramDic = nil;
    switch (aType) {
        case RequestCheckUserid:
        {
            path = PATH_CHECK;
            paramDic = @{KEY_UN:aParam[KEY_UN],
                         KEY_CKID:[JYDevice ckid]};
        }
            break;
        case RequestLoginWithSid:
        {
            path = PATH_LOGIN_SID;
            paramDic = @{KEY_UID:aParam[KEY_UID],
                         KEY_SID:aParam[KEY_SID],
                         KEY_APPID:[JYDevice appId],
                         KEY_CHANNEL:[JYDevice channelId],
                         KEY_CKID:[JYDevice ckid]};
        }
            break;
        case RequestLoginWithTourist:
        {
            path = PATH_LOGIN_TOURIST;
            NSMutableDictionary *temp = [NSMutableDictionary dictionaryWithDictionary:[JYDevice deviceInfo]];
            [temp setObject:@"2" forKey:KEY_TYPE];
            paramDic = temp;
        }
            break;
        case RequestLoginWithUsername:
        {
            path = PATH_LOGIN;
            paramDic = @{KEY_UN:aParam[KEY_UN],
                         KEY_PW:aParam[KEY_PW],
                         KEY_APPID:[JYDevice appId],
                         KEY_CHANNEL:[JYDevice channelId],
                         KEY_CKID:[JYDevice ckid]};
        }
            break;
        case RequestLoginWithPhone:
            return @"";
            break;
        case RequestRegistWithUsername:
        {
            path = PATH_REGIST_UN;
            NSMutableDictionary *temp = [NSMutableDictionary dictionaryWithDictionary:[JYDevice deviceInfo]];
            [temp setObject:aParam[KEY_UN] forKey:KEY_UN];
            [temp setObject:aParam[KEY_PW] forKey:KEY_PW];
            [temp setObject:@"1" forKey:KEY_TYPE];
            paramDic =temp;
        }
            break;
        case RequestRegistWithPhone:
            return @"";
            break;
        case RequestBindEmail:
        {
            path = PATH_BIND_EMAIL;
            paramDic = @{KEY_UN:aParam[KEY_UN],
                         KEY_PW:aParam[KEY_PW],
                         KEY_EMAIL:aParam[KEY_EMAIL],
                         KEY_CKID:[JYDevice ckid]};
        }
            break;
        case RequestBindAccount:
        {
            path = PATH_BIND_ACCOUNT;
            paramDic = @{KEY_UN:aParam[KEY_UN],
                         KEY_PW:aParam[KEY_PW],
                         KEY_UID:aParam[KEY_UID],
                         KEY_CKID:[JYDevice ckid]};
            
        }
            break;
        case RequestFindPassword:
        {
            path = PATH_FIND_PW;
            paramDic = @{KEY_UN:aParam[KEY_UN],
                         KEY_EMAIL:aParam[KEY_EMAIL],
                         KEY_CKID:[JYDevice ckid]};
        }
            break;
            
        default:
            break;
    }
    
    JYDLog(@"requeset path = %@, param = %@", path, paramDic);
    NSString* EncryptStr = [JoyEncryption DESEncryptDictionary:paramDic WithKey:JYEncryptionkey];
    return [NSString stringWithFormat:@"%@?param=%@", path, EncryptStr];
}

+ (NSDictionary *)dictionaryWithResponseData:(NSData *)aData
                              andRequestType:(JYRequestType)aType
{
    NSDictionary* responseDic = nil;
    @try {
        responseDic = [JoyEncryption DESDecryptData:aData WithKey:JYEncryptionkey];
    }
    @catch (NSException *exception) {
        JYDLog(@"response data decrypt error, exception = %@", exception);
    }
    @finally {
        
    }

    JYDLog(@"response = %@", responseDic);
    return responseDic;
}

@end
