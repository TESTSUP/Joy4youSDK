//
//  JYUserContent.m
//  Joy4youSDK
//
//  Created by 孙永刚 on 15/11/20.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import "JYUserContent.h"

@implementation JYUserContent

- (NSString *)valueFromDic:(NSDictionary*)aDic withKey:(NSString *)aKey
{
   id value = aDic[aKey];
    if (value) {
        if ([NSNull null] != value) {
            return value;
        } else {
            return @"";
        }
    }
    return @"";
}

- (instancetype)initWithDictionary:(NSDictionary *)aUserData
{
    self = [super init];
    if (self) {
        self.username = [self valueFromDic:aUserData withKey:KEY_UN];
        self.username = [self.username stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        self.phone = [self valueFromDic:aUserData withKey:KEY_PHONE];
        self.userid = [self valueFromDic:aUserData withKey:KEY_UID];;
        self.email = [self valueFromDic:aUserData withKey:KEY_EMAIL];
        self.ckid = [self valueFromDic:aUserData withKey:KEY_CKID];
        self.sessionid = [self valueFromDic:aUserData withKey:KEY_SID];
        self.token = [self valueFromDic:aUserData withKey:KEY_TOKEN];
    }
    
    return self;
}


-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInteger:self.type forKey:@"type"];
    [aCoder encodeObject:self.userid forKey:@"userid"];
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
    [aCoder encodeObject:self.email forKey:@"email"];
    
    [aCoder encodeObject:self.ckid forKey:@"ckid"];
    [aCoder encodeObject:self.sessionid forKey:@"sessionid"];
    [aCoder encodeObject:self.token forKey:@"token"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self.type = [aDecoder decodeIntegerForKey:@"type"];
    self.userid=[aDecoder decodeObjectForKey:@"userid"];
    self.username=[aDecoder decodeObjectForKey:@"username"];
    self.phone = [aDecoder decodeObjectForKey:@"phone"];
    self.email = [aDecoder decodeObjectForKey:@"email"];
    self.ckid = [aDecoder decodeObjectForKey:@"ckid"];
    self.sessionid = [aDecoder decodeObjectForKey:@"sessionid"];
    self.token = [aDecoder decodeObjectForKey:@"token"];
    
    return self;
}

@end
