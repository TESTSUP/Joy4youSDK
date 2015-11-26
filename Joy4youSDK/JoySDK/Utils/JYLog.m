//
//  JYLog.m
//  JoySDK
//
//  Created by 孙永刚 on 15/11/18.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import "JYLog.h"

static BOOL JY_ShowLog = YES;

void JYDLog(NSString *formatStr, ...)
{
    //调试模式
    if (JY_ShowLog) {
        if (!formatStr)
            return;
        va_list arglist;
        va_start(arglist, formatStr);
        
        NSString *outStr = [[NSString alloc] initWithFormat:formatStr arguments:arglist];
        
        va_end(arglist);
        
        NSLog(@"Joy4youSDK log -->%@", outStr);
    }
}

@implementation JYLog

+ (void)setLogOff:(BOOL)isOff
{
    JY_ShowLog = !isOff;
}

@end
