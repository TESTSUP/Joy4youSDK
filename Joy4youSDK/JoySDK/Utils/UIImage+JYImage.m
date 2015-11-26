//
//  UIImage+JYImage.m
//  Joy4youSDK
//
//  Created by 孙永刚 on 15/11/25.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import "UIImage+JYImage.h"
#import "NSBundle+JYBundle.h"

@implementation UIImage (JYImage)

+ (UIImage *)imageWithColor:(UIColor *)color

{
    
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return theImage;
    
}

+ (UIImage*)imageNamedFromBundle:(NSString*)imageName {
    UIImage* aImg = nil;
    
    NSBundle *frameworkBundle = [NSBundle resourceBundle];
    
    NSString * resourcePath = [frameworkBundle pathForResource:imageName ofType:nil];
    
    aImg = [UIImage imageWithContentsOfFile:resourcePath];
    
    return aImg;
}

- (UIImage *)textFieldBGImage
{
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(10,3,10,3)];
}

- (UIImage *)stretchBGImage
{
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(3, 3, 3,3)];
}


@end
