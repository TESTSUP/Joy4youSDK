//
//  JYUserContent.h
//  Joy4youSDK
//
//  Created by 孙永刚 on 15/11/20.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  用户数据类
 */
@interface JYUserContent : NSObject

@property (nonatomic, assign) NSInteger type;   //用户类型：1：普通用户；2：游客

@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *ckid;
@property (nonatomic, strong) NSString *sessionid;
@property (nonatomic, strong) NSString *token;

- (instancetype)initWithDictionary:(NSDictionary *)aUserData;

@end
