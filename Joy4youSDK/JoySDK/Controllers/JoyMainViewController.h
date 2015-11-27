//
//  JoyMainViewController.h
//  JoySDK
//
//  Created by 孙永刚 on 15/11/18.
//  Copyright © 2015年 LeHeng. All rights reserved.
//
#import "Joy4youSDK.h"

@interface Joy4youSDK ()

+ (void)removeSDKFromRootView;

@end

/**
 *  主视图类
 */
@interface JoyMainViewController : UIViewController

@property (nonatomic, weak)id<Joy4youCallback> callback;
@property (nonatomic, assign) BOOL isRemoving;

+ (instancetype)shareInstance;
+ (void)clear;

/**
 *  对外接口
 */
- (void)loginAction;

@end
