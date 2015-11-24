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

@implementation JYServiceData

+ (NSString *)urlPathForType:(JYRequestType)aType
{
    switch (aType) {
        case RequestCheckUserid:
            return @"";
            break;
        case RequestLoginWithSid:
            return @"";
            break;
        case RequestLoginWithTourist:
            return @"";
            break;
        case RequestLoginWithUsername:
            return @"";
            break;
        case RequestLoginWithPhone:
            return @"";
            break;
        case RequestRegistWithUsername:
            return @"";
            break;
        case RequestRegistWithPhone:
            return @"";
            break;
        case RequestBindEmail:
            return @"";
            break;
        case RequestFindPassword:
            return @"";
            
        default:
            break;
    }
}

+ (NSString *)pathUrlWithParam:(NSDictionary *)aParam andRequestType:(JYRequestType)aType
{
    NSString *path = @"";
    NSString *EncryptStr = @"";
    switch (aType) {
        case RequestCheckUserid:
        {
            path = PATH_CHECK;
            NSDictionary *paramDic = @{KEY_UN:aParam[KEY_UN],
                                       KEY_CKID:[JYDevice ckid]};
            EncryptStr = [JoyEncryption DESEncryptDictionary:paramDic WithKey:JYEncryptionkey];
            
        }
            break;
        case RequestLoginWithSid:
            return @"";
            break;
        case RequestLoginWithTourist:
            return @"";
            break;
        case RequestLoginWithUsername:
        {
            path = PATH_LOGIN;
            NSDictionary *paramDic = @{KEY_UN:aParam[KEY_UN],
                                       KEY_PW:aParam[KEY_PW],
                                       KEY_APPID:[JYDevice appId],
                                       KEY_CHANNEL:[JYDevice channelId]};
            EncryptStr = [JoyEncryption DESEncryptDictionary:paramDic WithKey:JYEncryptionkey];
        }
            break;
        case RequestLoginWithPhone:
            return @"";
            break;
        case RequestRegistWithUsername:
            return @"";
            break;
        case RequestRegistWithPhone:
            return @"";
            break;
        case RequestBindEmail:
            return @"";
            break;
        case RequestFindPassword:
            return @"";
            
        default:
            break;
    }
    
    return [NSString stringWithFormat:@"%@?param=%@", path, EncryptStr];
}

+ (NSDictionary *)dictionaryWithResponseData:(NSData *)aData
                              andRequestType:(JYRequestType)aType
{
    
}

@end
