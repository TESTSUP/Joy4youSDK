//
//  JoySDK.m
//  JoySDK
//
//  Created by 孙永刚 on 15/11/16.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import "Joy4youSDK.h"
#import <UIKit/UIKit.h>
#import "JoyRootViewController.h"
#import "JoyMainViewController.h"
#import "JYLog.h"
#import "JYDevice.h"
#import "JoyRequest.h"
#import "JoyEncryption.h"

@implementation Joy4youSDK

+ (UIViewController *)getRootViewController
{
    UIViewController *rootVC = ([[UIApplication sharedApplication] keyWindow]).rootViewController;
    if (rootVC == nil && [[[UIApplication sharedApplication] delegate] respondsToSelector:@selector(window)])
    {
        rootVC = [[[UIApplication sharedApplication] delegate] window].rootViewController;
    }
    
    if (rootVC == nil) {
        JoyRootViewController *JoyRootVC = [[JoyRootViewController alloc] init];
        ([[UIApplication sharedApplication] keyWindow]).rootViewController = JoyRootVC;
        
        rootVC = JoyRootVC;
    }
    
    return rootVC;
}

+ (void)removeSDKFromRootView {
    UIViewController* rootVC;
    BOOL needRemove = YES;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 6.0) {
        JYDLog(@"%s --- %d", __func__, 1);
        rootVC = [[[UIApplication sharedApplication] delegate] window].rootViewController;
    } else {
        JYDLog(@"%s --- %d", __func__, 2);
        rootVC = ([[UIApplication sharedApplication] keyWindow]).rootViewController;
    }
    if (nil != rootVC) {
        JYDLog(@"%s --- %d", __func__, 3);
        if ([rootVC isKindOfClass:[JoyRootViewController class]]) {
            JYDLog(@"%s --- %d", __func__, 31);
            [[[[UIApplication sharedApplication] delegate] window] setRootViewController:nil];
        } else {
            JYDLog(@"%s --- %d", __func__, 5);
            NSArray* arr = rootVC.view.subviews;
            for (id view in arr) {
                id vc = [view nextResponder];
                if ([vc isKindOfClass:[JoyMainViewController class]]) {
                    if (((JoyMainViewController  *)vc).isRemoving == YES) {
                        ((JoyMainViewController  *)vc).isRemoving = NO;
                        [view removeFromSuperview];
                    }
                    else
                    {
                        needRemove = NO;
                        JYDLog(@"%s ---- remove coco view cancel", __func__);
                    }
                }
            }
        }
    } else {
        JYDLog(@"%s --- %d", __func__, 4);
    }
    
    if (needRemove) {
        [JoyMainViewController clear];
    }
}

+ (void)initWithAppId:(NSString *)appId channelId:(NSString *)channelId andADId:(NSString *)adId
{
    if ([appId length]  == 0 ||
        [channelId length] == 0 ||
        [appId length] == 0) {
        NSLog(@"Joy4youSDK init error, parameter can not be nil");
        return;
    }
    
    NSLog(@"Joy4youSDK init, version = %@", Joy4youSDK_VERSION);
    [TalkingDataAppCpa init:adId withChannelId:@"AppStore"];
    [JYDevice setAppId:appId];
    [JYDevice setChannelId:channelId];
}

+ (void)login:(id<Joy4youCallback>)delagate
{
    UIViewController *rootVC = [Joy4youSDK getRootViewController];
    JoyMainViewController *mainVC = [JoyMainViewController shareInstance];
    
    if (nil != rootVC) {
        mainVC.view.frame = rootVC.view.bounds;
        mainVC.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |
        UIViewAutoresizingFlexibleRightMargin |
        UIViewAutoresizingFlexibleTopMargin |
        UIViewAutoresizingFlexibleBottomMargin |
        UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleHeight;
        [rootVC.view addSubview:mainVC.view];
    } else {
        [[[[UIApplication sharedApplication] delegate] window] setRootViewController:mainVC];
    }
    
    mainVC.callback = delagate;
    
    [mainVC loginAction];
}

+ (NSString *)sdkVersion
{
    return Joy4youSDK_VERSION;
}

+ (void)setLogEnabled:(BOOL)enable
{
    [JYLog setLogEnable:enable];
}

+ (void)onCreateRole:(NSString *)name
{
    [TalkingDataAppCpa onCreateRole:name];
}

/**
 *  @method onPay           支付
 *  @param  account         帐号            类型:NSString
 *  @param  orderId         订单id          类型:NSString
 *  @param  amount          金额            类型:int
 *  @param  currencyType    币种            类型:NSString
 *  @param  payType         支付类型         类型:NSString
 */
+ (void)onPay:(NSString *)account withOrderId:(NSString *)orderId withAmount:(int)amount withCurrencyType:(NSString *)currencyType withPayType:(NSString *)payType
{
    [TalkingDataAppCpa onPay:account withOrderId:orderId withAmount:amount withCurrencyType:currencyType withPayType:payType];
}

@end
