//
//  JYUserContent.m
//  Joy4youSDK
//
//  Created by 孙永刚 on 15/11/20.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import "JYUserContent.h"

@implementation JYUserContent

- (instancetype)initWithDictionary:(NSDictionary *)aUserData
{
    self = [super init];
    if (self) {
        //用户名中文编码
        NSString *un = [aUserData[@"username"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        self.username = un;
        self.userid = (NSString *) aUserData[@"userid"];
        self.phone = aUserData[@"phone"];
        self.email = aUserData[@"email"];
        self.ckid = aUserData[@"ckid"];
        self.sessionid = aUserData[@"sessionid"];
        self.token = aUserData[@"token"];
    }
    
    return self;
}


-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.userid forKey:@"userid"];
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
    [aCoder encodeObject:self.email forKey:@"email"];
    
    [aCoder encodeObject:self.ckid forKey:@"ckid"];
    [aCoder encodeObject:self.sessionid forKey:@"sessionid"];
    [aCoder encodeObject:self.token forKey:@"token"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
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
