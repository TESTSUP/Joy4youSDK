//
//  JYLog.h
//  JoySDK
//
//  Created by 孙永刚 on 15/11/18.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import <Foundation/Foundation.h>

extern void JYDLog(NSString *formatStr, ...);


@interface JYLog : NSObject

+ (void)setLogOff:(BOOL)isOff;

@end