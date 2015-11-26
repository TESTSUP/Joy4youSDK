//
//  JoyMainViewController.m
//  JoySDK
//
//  Created by 孙永刚 on 15/11/18.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import "JoyMainViewController.h"
#import "JYUserCache.h"
#import "JYLoginViewController.h"
#import "JYUtil.h"
#import "JYNavigationController.h"

@interface JoyMainViewController ()
{
    JYNavigationController *rootNav;
}

@end

@implementation JoyMainViewController

static JoyMainViewController*instance = nil;
static dispatch_once_t token;

+ (instancetype)shareInstance
{
    dispatch_once(&token, ^{
        instance = [[JoyMainViewController alloc] init];
    });
    
    return instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
}

- (void)reset
{
    
}

- (BOOL)shouldAutorotate
{
    return YES;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

#pragma mark - public

- (CGPoint)viewCenter
{
    return CGPointMake(self.view.bounds.size.width/2,
                       self.view.bounds.size.height/2);
}

- (void)loginAction
{
    [self reset];

    JYLoginViewController *loginVC = [[JYLoginViewController alloc] initWithNibName:@"JYLoginViewController" bundle:[NSBundle resourceBundle]];
    
    rootNav = [[JYNavigationController alloc] initWithRootViewController:loginVC];
    [rootNav setNavigationBarHidden:YES animated:NO];
    
    rootNav.view.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleBottomMargin;
    
    rootNav.view.frame = CGRectMake(0, 0, 320, 267);
    rootNav.view.center = [self viewCenter];
    [self.view addSubview:rootNav.view];
    
    rootNav.view.backgroundColor = [UIColor greenColor];
    
//    JYUserContent *cacheUser = [[JYUserCache sharedInstance] currentUser];
//    if (cacheUser)
//    {
//        JYLoadingView *cacheLoading = [self createCacheLoginView];
//        cacheLoading.lodingType = CCLoading_cacheLogin;
//        cacheLoading.title = [NSString stringWithFormat:@"%@ %@", [@"coco帐号" localizedString], [cacheUser.un length]==0? cacheUser.ph:cacheUser.un];
//        
//        [self pushView:cacheLoading animated:YES];
//        
//        [self performSelector:@selector(delayCacheLogin:) withObject:cacheUser afterDelay:2];
//    }
}

@end
