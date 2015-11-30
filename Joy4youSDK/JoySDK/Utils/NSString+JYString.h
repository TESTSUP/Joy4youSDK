//
//  NSString+JYString.h
//  Joy4youSDK
//
//  Created by 孙永刚 on 15/11/25.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JYString)

/**
 *  MD5
 *
 *  @return MD5的字符串
 */
- (NSString *)MD5;

/**
 *  本地化字符串
 *
 *  @return <#return value description#>
 */
- (NSString *)localizedString;

/**
 *  注册时有效用户名
 *
 *  @return <#return value description#>
 */
- (BOOL)validateUserAccount;

/**
 *  注册时有效密码
 *
 *  @return <#return value description#>
 */
- (BOOL)validateUserPassword;

@end
