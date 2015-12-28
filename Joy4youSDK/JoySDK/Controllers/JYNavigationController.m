//
//  JYNavigationController.m
//  Joy4youSDK
//
//  Created by 孙永刚 on 15/11/25.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import "JYNavigationController.h"

@implementation JYNavigationController

- (BOOL)shouldAutorotate
{
    return self.topViewController.shouldAutorotate;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.topViewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}


@end
