//
//  UIView+JYView.h
//  Joy4youSDK
//
//  Created by 孙永刚 on 15/11/25.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CC_CORNERRADIUS 3.0
#define DEFAULT_WIDTH   (310)
#define DEFAULT_HEIGHT  (267)

@interface UIView (JYView)

+ (UIView *)createNibView:(NSString *)aNibName;

@end
