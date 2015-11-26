//
//  UIImage+JYImage.h
//  Joy4youSDK
//
//  Created by 孙永刚 on 15/11/25.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JYImage)

+ (UIImage*)imageWithColor:(UIColor *)color;

+ (UIImage*)imageNamedFromBundle:(NSString*)imageName;

- (UIImage *)textFieldBGImage;

- (UIImage *)stretchBGImage;
@end
