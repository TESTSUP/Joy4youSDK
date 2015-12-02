//
//  JoyRequest.h
//  JoySDK
//
//  Created by 孙永刚 on 15/11/16.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^requestCallback)(NSError *error, id responseData);

@interface JoyRequest : NSObject

+ (instancetype)shareInstance;
+ (void)clear;

- (void)requestWithPath:(NSString *)aPath
             Parameters:(NSDictionary *)aParam
                success:(void(^)(NSHTTPURLResponse *response, NSData *responseData))success
                failure:(void(^)(NSHTTPURLResponse *response, NSError *responseERROR))Faliure;

- (void)cancelAllOperations;


@end
