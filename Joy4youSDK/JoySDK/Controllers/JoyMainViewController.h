//
//  JoyMainViewController.h
//  JoySDK
//
//  Created by 孙永刚 on 15/11/18.
//  Copyright © 2015年 LeHeng. All rights reserved.
//
#import "Joy4youSDK.h"

@interface JoyMainViewController : UIViewController

@property (nonatomic, weak)id<Joy4youCallback>delegate;
@property (nonatomic, assign) BOOL isRemoving;

+ (instancetype)shareInstance;

@end
