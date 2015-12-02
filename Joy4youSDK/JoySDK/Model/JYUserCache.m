//
//  JYUserCache.m
//  JoySDK
//
//  Created by 孙永刚 on 15/11/18.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import "JYUserCache.h"


static NSString *const cacheUserListKey = @"J4Y_cache_list";
static NSString *const currentUserIdKey = @"J4Y_current_user";

@interface JYUserCache ()
{
    NSMutableArray *_cacheUserList;
    NSString* _currentUid;
}

@end

@implementation JYUserCache

static JYUserCache *instance = nil;
static dispatch_once_t onceToken;

+ (instancetype)sharedInstance
{
    dispatch_once(&onceToken, ^{
        instance = [[JYUserCache alloc] init];
    });
    
    return instance;
}

+ (void)clear
{
    onceToken = 0;
    instance = nil;
}

- (void)dealloc
{
    [_cacheUserList removeAllObjects];
    _cacheUserList = nil;
    _currentUid = nil;
}

- (id)init {
    if (self = [super init]) {
        
        _cacheUserList = [[NSMutableArray alloc] initWithCapacity:0];
        _currentUid = nil;
        [self loadDefault];
    }
    return self;
}

- (void)loadDefault
{
    NSUserDefaults *userInfoDef = [NSUserDefaults standardUserDefaults];
    NSArray * array = (NSArray *)[userInfoDef objectForKey:cacheUserListKey];
    _currentUid = (NSString *)[userInfoDef objectForKey:currentUserIdKey];
    
    for (NSData *userData in array)
    {
        JYUserContent *userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
        [_cacheUserList addObject:userInfo];
    }
}

- (void)saveDefault
{
    NSUserDefaults *userInfoDef = [NSUserDefaults standardUserDefaults];
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:0];
    for (JYUserContent *userinfo in _cacheUserList)
    {
        NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:userinfo];
        [tempArray addObject:userData];
    }
    
    [userInfoDef setObject:tempArray forKey:cacheUserListKey];
    //游客不能进行缓存登录
    if (self.currentUser.type == 2) {
        [userInfoDef setObject:@"" forKey:currentUserIdKey];
    } else {
        [userInfoDef setObject:_currentUid forKey:currentUserIdKey];
    }
    [userInfoDef synchronize];
}

#pragma mark - puclic

- (JYUserContent *)currentUser
{
    for (JYUserContent *userinfo in _cacheUserList)
    {
        if ([[userinfo userid] isEqualToString:_currentUid]) {
            return userinfo;
        }
    }
    
    return nil;
}

- (NSArray *)normalUserList
{
    NSMutableArray *userList = [NSMutableArray array];
    for(JYUserContent *userInfoData in _cacheUserList){
        if (userInfoData.type == 2) {
            continue;
        }
        [userList addObject:userInfoData];
    }
    return userList;
}

-(void) saveCacheUserInfo:(NSDictionary *)dictionary isTourist:(BOOL)isTourist
{
    if ([[dictionary allKeys] count] == 0) {
        return;
    }
    
    JYUserContent *userInfoData = [[JYUserContent alloc] initWithDictionary:dictionary];
    userInfoData.type = 1;
    if (isTourist) {
        userInfoData.type = 2;
        userInfoData.username = @"游客";
    }
    _currentUid = userInfoData.userid;
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF.userid == %@", _currentUid];
    NSArray *temp = [_cacheUserList filteredArrayUsingPredicate:pre];
    [_cacheUserList removeObjectsInArray:temp];
    
    [_cacheUserList insertObject:userInfoData atIndex:0];
    
    NSArray *accountArray = [self normalUserList];
    if ([accountArray count] > UserCacheLimit)
    {
        [_cacheUserList removeObject:[accountArray lastObject]];
    }
    
    [self saveDefault];
}

-(NSArray *) deleteLoginCache:(NSString *)uid
{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF.userid == %@", uid];
    NSArray *temp = [_cacheUserList filteredArrayUsingPredicate:pre];
    [_cacheUserList removeObjectsInArray:temp];
    
    if ([uid isEqualToString:_currentUid]) {
        _currentUid = nil;
    }
    
    [self saveDefault];
    
    return [self normalUserList];
}

-(JYUserContent *) getUserCache:(NSString *)uid
{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF.uid == %@", uid];
    NSArray *temp = [_cacheUserList filteredArrayUsingPredicate:pre];
    
    return [temp count]? [temp firstObject]:nil;
}

@end
