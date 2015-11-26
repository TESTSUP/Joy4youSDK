//
//  NSBundle+JYBundle.m
//  Joy4youSDK
//
//  Created by 孙永刚 on 15/11/25.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import "NSBundle+JYBundle.h"

@implementation NSBundle (JYBundle)

static NSBundle* frameworkBundle = nil;
static dispatch_once_t predicate;
+ (NSBundle *)resourceBundle
{
    dispatch_once(&predicate, ^{
        NSString* mainBundlePath = [[NSBundle mainBundle] resourcePath];
        
        NSString* frameworkBundlePath = [mainBundlePath stringByAppendingPathComponent:@"Joy4youBundle.bundle"];
        frameworkBundle = [NSBundle bundleWithPath:frameworkBundlePath];
    });
    
    return frameworkBundle;
}


@end
