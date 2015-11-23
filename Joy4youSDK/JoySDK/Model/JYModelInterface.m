//
//  JYModelInterface.m
//  JoySDK
//
//  Created by 孙永刚 on 15/11/18.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import "JYModelInterface.h"
#import "JYUserCache.h"
#import "JoyRequest.h"

@interface JYModelInterface ()
{

}

@end

@implementation JYModelInterface

static JYModelInterface *instance = nil;
static dispatch_once_t token;

+ (instancetype)sharedInstance
{
    dispatch_once(&token, ^{
        instance = [[JYModelInterface alloc] init];
    });
    
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

#pragma mark - interface

- (void)checkUsername:(NSString *)aName callbackBlock:(modelCallback)aCallback
{
    [[JoyRequest shareInstance] requestWithPath:@""
                                     Parameters:nil
                                        success:^(NSHTTPURLResponse *response, NSData *responseData) {
                                            
                                        }
                                        failure:^(NSHTTPURLResponse *response, NSError *responseERROR) {
                                            
                                        }];
}


@end
