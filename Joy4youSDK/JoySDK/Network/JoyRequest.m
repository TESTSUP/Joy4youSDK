//
//  JoyRequest.m
//  JoySDK
//
//  Created by 孙永刚 on 15/11/16.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import "JoyRequest.h"
#import "AFNetworking/AFNetworking.h"

#define TIME_OUT    (15)

@interface JoyRequest ()

@property (nonatomic, strong)JYAFHTTPRequestOperationManager *connectionManager;  //此方法iOS9后不可用
@property (nonatomic, strong)JYAFHTTPSessionManager *sessionManger;

@end

@implementation JoyRequest


static JoyRequest *instance = nil;
static dispatch_once_t token;

+ (instancetype)shareInstance
{
    dispatch_once(&token, ^{
        instance = [[JoyRequest alloc] init];
    });
    
    return  instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSURL *baseUrl = [NSURL URLWithString:Joy4youHostUrl];
        
        if ([UIDevice currentDevice].systemVersion.floatValue > 7.0) {
            self.sessionManger = [[JYAFHTTPSessionManager alloc] initWithBaseURL:baseUrl
                                                          sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            self.sessionManger.responseSerializer = [JYAFHTTPResponseSerializer serializer];
            self.sessionManger.requestSerializer.timeoutInterval = TIME_OUT;
        } else {
            self.connectionManager = [[JYAFHTTPRequestOperationManager alloc] initWithBaseURL:baseUrl];
            self.connectionManager.responseSerializer = [JYAFHTTPResponseSerializer serializer];
            self.connectionManager.requestSerializer.timeoutInterval = TIME_OUT;
        }
        
    }
    
    return self;
}

- (void)requestWithPath:(NSString *)aPath
             Parameters:(NSDictionary *)aParam
                success:(void(^)(NSHTTPURLResponse *response, NSData *responseData))success
                failure:(void(^)(NSHTTPURLResponse *response, NSError *responseERROR))faliure
{
    if ([UIDevice currentDevice].systemVersion.floatValue > 7.0) {
        [self.sessionManger POST:aPath
                      parameters:aParam
                         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                             if (success) {
                                 success((NSHTTPURLResponse *)task.response, responseObject);
                             }
                         }
                         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                             if (faliure) {
                                 faliure((NSHTTPURLResponse *)task.response, error);
                             }
                         }];
    } else {
        [self.connectionManager POST:aPath
                          parameters:aParam
                             success:^(JYAFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                                 if (success) {
                                     success(operation.response, responseObject);
                                 }
                             }
                             failure:^(JYAFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
                                 if (faliure) {
                                     faliure(operation.response, error);
                                 }
                             }];
    }
}

- (void)cancelAllOperations
{
     if ([UIDevice currentDevice].systemVersion.floatValue > 7.0) {
         [self.sessionManger.session getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
             [self cancelTasksInArray:dataTasks];
             [self cancelTasksInArray:uploadTasks];
             [self cancelTasksInArray:downloadTasks];
         }];
     } else {
         [self.connectionManager.operationQueue cancelAllOperations];
     }
}

- (void)cancelTasksInArray:(NSArray *)tasksArray
{
    for (NSURLSessionTask *task in tasksArray) {
        [task cancel];
    }
}

@end
