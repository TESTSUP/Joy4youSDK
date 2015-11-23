//
//  JoySDK.h
//  JoySDK
//
//  Created by 孙永刚 on 15/11/16.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Joy4youCallback <NSObject>

@required

- (void)loginCallback:(NSDictionary *)jsonDic;

@end

/**
 *  接口类
 */
@interface Joy4youSDK : NSObject

/**
 *	@brief	show login UI
 *
 *	@param 	(id<Joy4youCallback>)cb :  delegate Objc Class instance
 *
 */
+ (void)login:(id<Joy4youCallback>)delagate;

/**
 *  @brief	return coco sdk version
 *
 */
+ (NSString *)sdkVersion;

@end
