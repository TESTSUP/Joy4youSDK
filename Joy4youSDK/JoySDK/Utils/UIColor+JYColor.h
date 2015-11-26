//
//  UIColor+JYColor.h
//  Joy4youSDK
//
//  Created by joy4you on 15/11/26.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (JYColor)

/**
 *  16进制色值转换
 *
 *  @param color 16进制色值字符串
 *  @param alpha 透明值
 *
 *  @return <#return value description#>
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color;

@end
