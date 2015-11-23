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

+ (void)removeCocoFromRootView {
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
            NSLog(@"%s --- %d", __func__, 5);
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
                        NSLog(@"%s ---- remove coco view cancel", __func__);
                    }
                }
            }
        }
    } else {
        JYDLog(@"%s --- %d", __func__, 4);
    }
    
    if (needRemove) {
        
    }
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
    
    mainVC.delegate = delagate;
    
    
//    NSString *orgStr = @"{"username":"zxb333","ckid":"14115805a8defd0f","osv":"4.4.2","isp":"1","imei":"864387023592245","dm":"H60-L11","appid":"10000","mac":"90671cf13d9d","imsi":"460023104385593","udid":"14115805a8defd0f","dvid":"98d62117-53f0-64da-0000-0150d1328318","channelid":"000000"}"
//
     NSError *responseError = nil;
    NSDictionary *orgDic = @{@"username":@"zxb333",
                             @"ckid":@"14115805a8defd0f",
                             @"osv":@"4.4.2",
                             @"isp":@"1",
                             @"imei":@"864387023592245",
                             @"dm":@"H60-L11",
                             @"appid":@"10000",
                             @"mac":@"90671cf13d9d",
                             @"imsi":@"460023104385593",
                             @"udid":@"14115805a8defd0f",
                             @"dvid":@"98d62117-53f0-64da-0000-0150d1328318",
                             @"channelid":@"000000"};
    NSData *orgData = [NSJSONSerialization dataWithJSONObject:orgDic
                                    options:0
                                      error:&responseError];
    NSString *orgStr = [[NSString alloc] initWithData:orgData encoding:NSUTF8StringEncoding];
    
    NSString *encStr = [JoyEncryption DESEncryptString:orgStr WithKey:JYEncryptionkey];
    
    //test
    NSString *path = @"http://123.59.56.120/joysdk/index.php/UserApi/checkUserName/?param=6f87cc4e5f646627413382dfaf53bd30e4684ffe53f2a38e278d177a97c1c5d932aa79c9611d11d263befcc495fee792772331f02815c6263e07fe377a0e28f93d5c906adf4774f6d0529d3a1f5332d1d9c67d6b24b3c4a20c2c80c6a55d454537a439c62427209ea7c24de5830903d23f64b7659b6dec7d7e20dfed584c8aabd9df7e23fd3e1962f6263a03be312173fccaeecd29c1abcf3687dc42340b1510563b9ca74ec919f5891020929392347e84d778c1364e6c80d6b6963108452edadc194163b5ab0e2befa893d0d5c762b93d006394b485b817876a1498864d86c35c601046008736b0c8429bba005114a3bfc654c2e0e1c172ed3c98382a8c66d449e26c81591926f658a489986af0b332";
    
    path = [NSString stringWithFormat:@"http://123.59.56.120/joysdk/index.php/UserApi/checkUserName/?param=%@", encStr];
    NSLog(@"param = %@", path);
    
    [[JoyRequest shareInstance] requestWithPath:path
                                     Parameters:nil
                                        success:^(NSHTTPURLResponse *response, NSData *responseData) {
                                            NSString *responseStr = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
                                            
                                            NSString *temp = [JoyEncryption DESDecryptString:responseStr WithKey:JYEncryptionkey];
                                            
                                            NSError *responseError = nil;
                                            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[temp dataUsingEncoding:NSUTF8StringEncoding]
                                                                                                options:NSJSONReadingAllowFragments
                                                                                                  error:&responseError];
                                            
                                            NSLog(@"response = %@", dic);
                                        }
                                        failure:^(NSHTTPURLResponse *response, NSError *responseERROR) {
                                            
                                        }];
    
    
    
}

+ (NSString *)sdkVersion
{
    return Joy4youSDK_VERSION;
}

@end
