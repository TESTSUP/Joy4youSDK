//
//  JoyDevice.m
//  JoySDK
//
//  Created by 孙永刚 on 15/11/16.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import "JYDevice.h"
#import "JYSTKeychain.h"
#import <ifaddrs.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <sys/sysctl.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

#ifdef IDFA
#import <AdSupport/AdSupport.h>
#endif

static NSString *Joy4you_appId = nil;
static NSString *Joy4you_channelId = nil;

@implementation JYDevice


+ (NSDictionary *)deviceInfo
{
    NSString *ckid = [JYDevice ckid];
    NSString *sdkVer = Joy4youSDK_VERSION;
    NSString *osVer = [[UIDevice currentDevice] systemVersion];
    NSString *dt = [[UIDevice currentDevice] model];
    NSString *dtn = [JYDevice deviceModel];
    NSString *srW = [JYDevice resolutionW];
    NSString *srH = [JYDevice resolutionH];
    NSString *brand = @"APPLE"; // 品牌
    NSString *carrier = [JYDevice carrierName];
    NSString *net = [JYDevice connectionType];
    NSString *appid =[JYDevice appId];
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *channel = [JYDevice channelId];
    NSString *pkgName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
    NSString *idfa = [JYDevice idfa];
    
    NSDictionary* deviceDic = @{KEY_APPID:appid,
                                KEY_CHANNEL:channel,
                                KEY_PKG:pkgName,
                                KEY_CKID:ckid,
                                KEY_DVID:ckid,
                                KEY_IDFA:idfa,
                                KEY_TEL:carrier,
                                KEY_NET:net,
                                KEY_SCREEN_W:srW,
                                KEY_SCREEN_H:srH,
                                KEY_DT:dt,
                                KEY_DM:dtn,
                                KEY_OSV:osVer,
                                KEY_BN:brand,
                                KEY_SDKVER:sdkVer,
                                KEY_VERSION:appVersion,
                                KEY_FROM:@"iOS"
                                };


    JYDLog(@"get deviceinfo %@",deviceDic);
    return deviceDic;
}

+ (NSString *)idfv
{
    NSString *idfv = [JYSTKeychain getPasswordForUsername:KEY_IDFV andServiceName:KEYCHAIN_SERVICE error:nil];
    if ([idfv length] == 0) {
        idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        idfv = [idfv lowercaseString];
        [JYSTKeychain storeUsername:KEY_IDFV andPassword:idfv forServiceName:KEYCHAIN_SERVICE updateExisting:YES error:nil];
    }
    return idfv;
}

//idfa
+ (NSString *)getIdfa
{
#ifdef IDFA
    NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    idfa = idfa?idfa:@"";
    
    return idfa;
#else
    return @"";
#endif
}

// 获取ckid
+ (NSString *)ckid
{
    return [JYDevice idfv];
}

// 获取设备型号
+ (NSString *)deviceModel
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    
    char *answer = malloc(size);
    sysctlbyname("hw.machine", answer, &size, NULL, 0);
    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
    free(answer);
    
    return results;
}


// 获取设备所用运营商名称
+ (NSString *)carrierName
{
    NSString *name = nil;
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    if (info) {
        CTCarrier *carrier = info.subscriberCellularProvider;
        if (carrier) {
            name = [carrier carrierName];
        }
    }
    
    return name == nil ? @"" : name;
}

// 获取设备的当前连网类型，WiFi或Cellular
+ (NSString *)connectionType
{
    
    NSString *returnValue = @"unknow";
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        
        CTTelephonyNetworkInfo * info = [[CTTelephonyNetworkInfo alloc] init];
        NSString *currentRadioAccessTechnology = info.currentRadioAccessTechnology;
        if (currentRadioAccessTechnology)
        {
            if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyLTE])
            {
                returnValue =  @"4G";
            }
            else if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyEdge] || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyGPRS])
            {
                returnValue =  @"2G";
            }
            else
            {
                returnValue =  @"3G";
            }
            return returnValue;
            
        }
    }

    struct ifaddrs *first_ifaddr, *current_ifaddr;
    NSMutableArray *activeInterfaceNames = [NSMutableArray array];
    getifaddrs(&first_ifaddr);
    current_ifaddr = first_ifaddr;
    while (current_ifaddr != NULL) {
        if (current_ifaddr->ifa_addr->sa_family == 0x02) {
            [activeInterfaceNames addObject:[NSString stringWithFormat:@"%s", current_ifaddr->ifa_name]];
        }
        current_ifaddr = current_ifaddr->ifa_next;
    }
    bool isWiFi = [activeInterfaceNames containsObject:@"en0"] || [activeInterfaceNames containsObject:@"en1"];
    free(first_ifaddr);
    
    return isWiFi ? @"WiFi" : @"Cellular";
}



// 获取appid
+ (NSString *)appId
{
    if (Joy4you_appId == nil || [Joy4you_appId length] == 0)
    {
        Joy4you_appId = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Joy4youAppId"];
    }
    NSAssert((Joy4you_appId != nil && [Joy4you_appId length]), @"Joy4you SDK Error: app id can not be nil");
    return Joy4you_appId;
}

//获取渠道号
+ (NSString *)channelId
{
    if (Joy4you_channelId == nil || [Joy4you_channelId length] == 0)
    {
        Joy4you_channelId = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Joy4youChannelId"];
    }
    
    NSAssert((Joy4you_channelId != nil && [Joy4you_channelId length]), @"Joy4you SDK SDK Error: channel id can not be nil");
    return Joy4you_channelId;
}


//idfa
+ (NSString *)idfa
{
#ifdef IDFA
    NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    idfa = idfa?idfa:@"";
    
    return idfa;
#else
    return @"";
#endif
}

//屏幕宽度
+ (NSString *)resolutionW
{
    int screenWidth=[UIScreen mainScreen].bounds.size.width;
    int scale = (int)[UIScreen mainScreen].scale;
    NSString *sr = [NSString stringWithFormat:@"%d", screenWidth * scale];
    return sr;
}

//屏幕高度
+ (NSString *)resolutionH
{
    int screenHeight=[UIScreen mainScreen].bounds.size.height;
    int scale = (int)[UIScreen mainScreen].scale;
    NSString *sr = [NSString stringWithFormat:@"%d", screenHeight * scale];
    return sr;
}

@end

