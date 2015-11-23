//
//  JYModelInterface.h
//  JoySDK
//
//  Created by 孙永刚 on 15/11/18.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^modelCallback)(NSError *error, NSDictionary* responseData);

/**
 *  接口层
 */
@interface JYModelInterface : NSObject


+ (instancetype)sharedInstance;

//登录


//注册

//绑定

//找回密码

@end
