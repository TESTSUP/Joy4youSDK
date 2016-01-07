//
//  JYConfig.m
//  JoySDK
//
//  Created by 孙永刚 on 15/11/18.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import "JYConfig.h"

#define HOST    2   //1:本地；2：线上沙箱；其它正式环境

/**
 *  SDK版本号
 */
const NSString *Joy4youSDK_VERSION = @"1.2.0";

/**
 *  加解密Key
 */
const NSString *JYEncryptionkey = @"562asd32";

/**
 *  服务器地址
 */
#if (HOST == 1)
//本地环境
const NSString *Joy4youHostUrl = @"http://192.168.17.232/joysdk/index.php/";
#elif (HOST == 2)
//线上沙箱
const NSString *Joy4youHostUrl = @"http://123.59.56.120/joysdk/index.php/";
#else
//线上正式
const NSString *Joy4youHostUrl = @"http://api.joy4you.com/joysdk/index.php/";
#endif


/**
 *  用户信息缓存数量
 */
const NSUInteger UserCacheLimit = 3;