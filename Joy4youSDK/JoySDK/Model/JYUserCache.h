//
//  JYUserCache.h
//  JoySDK
//
//  Created by 孙永刚 on 15/11/18.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYUserContent.h"

@interface JYUserCache : NSObject

@property (nonatomic, readonly)JYUserContent *currentUser;  //当前用户信息

@property (nonatomic, readonly) NSArray *cacheUserList;     //缓存的用户列表(包含游客)

@property (nonatomic, readonly) NSArray *normalUserList;    //普通用户列表

+ (instancetype)sharedInstance;

+ (void)clear;

/**
 *  登录或者注册成功后设置用户缓存
 *
 *  @param dictionary server返回数据
 */
-(void) saveCacheUserInfo:(NSDictionary *)dictionary isTourist:(BOOL)isTourist;

/**
 *  通过用户id获取用户详情
 *
 *  @param uid user id
 *
 *  @return 用户实例
 */
-(JYUserContent *) getUserCache:(NSString *)uid;


/**
 *  通过用户id删除用户信息
 *
 *  @param uid user id
 *
 *  @return 返回修改后的用户列表
 */
-(NSArray *) deleteLoginCache:(NSString *)uid;

@end
