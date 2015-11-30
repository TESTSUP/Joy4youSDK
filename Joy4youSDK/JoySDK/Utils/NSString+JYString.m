//
//  NSString+JYString.m
//  Joy4youSDK
//
//  Created by 孙永刚 on 15/11/25.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import "NSString+JYString.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSBundle+JYBundle.h"

@implementation NSString (JYString)

- (NSString *)MD5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString *)localizedString
{
    NSString *value = nil;
    NSString *path = nil;
    NSString *preferredLang = [[NSLocale preferredLanguages] count]? [[NSLocale preferredLanguages] objectAtIndex:0]:nil;
    
    if ([preferredLang length] > 0)
    {
        path = [[NSBundle resourceBundle] pathForResource:preferredLang ofType:@"lproj"];
    }
    
    if ([path length] == 0)
    {
        path = [[NSBundle resourceBundle] pathForResource:@"Base" ofType:@"lproj"];
    }
    
    value = [[NSBundle bundleWithPath:path] localizedStringForKey:self value:@"" table:nil];
    return value;
}

//纯英文
- (BOOL)allEnString
{
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:@"^[a-zA-Z]{4,20}$"
                                              options:NSRegularExpressionCaseInsensitive
                                              error:nil];
    
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:self
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, self.length)];
    
    if(numberofMatch > 0)
    {
        return YES;
    }
    
    return NO;
}

//条件：4-20位字符，仅支持英文、数字，必须包含数字
- (BOOL)validateUserAccount
{
//    if ([self allEnString]) {
//        return NO;
//    }
    
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:@"^(?![0-9]+$)[a-zA-Z0-9_]{4,20}$"
                                              options:NSRegularExpressionCaseInsensitive
                                              error:nil];
    
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:self
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, self.length)];
    
    if(numberofMatch > 0)
    {
        return YES;
    }
    
    return NO;
}

- (BOOL)validateUserPassword
{
    //    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
    //                                              initWithPattern:@"^[a-zA-Z0-9_]{6,15}$"
    //                                              options:NSRegularExpressionCaseInsensitive
    //                                              error:nil];
    //
    //    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:self
    //                                                                  options:NSMatchingReportProgress
    //                                                                    range:NSMakeRange(0, self.length)];
    //
    //    if(numberofMatch > 0)
    //    {
    //        return YES;
    //    }
    
    NSString *ASSISS = @"!\"#$%&`()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_\'abcdefghijklmnopqrstuvwxyz{|}~";
    for (int i=0; i<self.length; i++) {
        NSString *str = [self substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [ASSISS rangeOfString:str];
        if (range.length <= 0)
        {
            return NO;
        }
    }
    
    if ([self length] < 6 || [self length] >15) {
        return NO;
    }
    
    return YES;
}


@end
