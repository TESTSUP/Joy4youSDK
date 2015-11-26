//
//  UIView+JYView.m
//  Joy4youSDK
//
//  Created by 孙永刚 on 15/11/25.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import "UIView+JYView.h"
#import "NSBundle+JYBundle.h"

@implementation UIView (JYView)

+ (UIView *)createNibView:(NSString *)aNibName
{
    NSArray *nibArray = [[NSBundle resourceBundle] loadNibNamed:aNibName
                                                        owner:nil
                                                      options:nil];
    
    if ([nibArray count]) {
        return [nibArray firstObject];
    } else {
        return nil;
    }
}

@end
