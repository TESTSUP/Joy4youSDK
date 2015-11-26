//
//  NSBundle+JYBundle.h
//  Joy4youSDK
//
//  Created by 孙永刚 on 15/11/25.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *JYBundleName;

@interface NSBundle (JYBundle)

/**
 *  获取资源bundle
 *
 *  @return <#return value description#>
 */
+ (NSBundle *)resourceBundle;

+ (void)clear;

@end
