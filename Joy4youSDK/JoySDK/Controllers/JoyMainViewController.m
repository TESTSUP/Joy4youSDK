//
//  JoyMainViewController.m
//  JoySDK
//
//  Created by 孙永刚 on 15/11/18.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import "JoyMainViewController.h"
#import "JYNavigationController.h"
#import "JYLoginViewController.h"
#import "JYUserCache.h"
#import "JYUtil.h"
#import "JYModelInterface.h"
#import "JYLoadingView.h"

@interface JoyMainViewController ()
{
    JYNavigationController *_navigationVC;
    JYAlertView *_alertView;
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

- (void)dealloc
{
    [JYModelInterface clear];
    [NSBundle clear];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleBackgroundTap)];
    [self.view addGestureRecognizer:tap];
}

- (void)addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showSuccessNotification:) name:JYNotificationShowSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeSDKNotification:) name:JYNotificationCloseSDK object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewRemoveNotification:) name:JYNotificationRemoveView object:nil];
    
}

- (BOOL)shouldAutorotate
{
    return YES;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

#pragma mark - handle action

- (void)delayCacheLogin:(JYUserContent *)cacheUser
{
    if ([_navigationVC.viewControllers count] == 0)
    {
        [[JYModelInterface sharedInstance] cacheLoginWithSessionId:cacheUser.sessionid
                                                         andUserId:cacheUser.userid
                                                     CallbackBlcok:^(NSError *error, NSDictionary *responseData) {
                                                         [_alertView dismissWithCompletion:nil];
                                                         
                                                         JYDLog(@"");
                                                     }];
    }
}

- (void)handleBackgroundTap
{
    JYViewController *topVC = (JYViewController *)_navigationVC.topViewController;
    [topVC hideKeybord];
}


- (void)reset
{
    [_navigationVC.view removeFromSuperview];
    _navigationVC = nil;
    [[JYModelInterface sharedInstance] cancelAllRequest];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(removeSDK) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(loginSuccessRemove) object:nil];
    self.isRemoving = NO;
}

#pragma mark - handle view

- (CGPoint)viewCenter
{
    return CGPointMake(self.view.bounds.size.width/2,
                       self.view.bounds.size.height/2);
}

- (void)removeAllviews
{
    
}

#pragma mark - notification

- (void)setNavigationRootView
{
    JYLoginViewController *loginVC = [[JYLoginViewController alloc] initWithNibName:@"JYLoginViewController" bundle:[NSBundle resourceBundle]];
    _navigationVC = [[JYNavigationController alloc] initWithRootViewController:loginVC];
    [_navigationVC setNavigationBarHidden:YES animated:NO];
    
    _navigationVC.view.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleBottomMargin;
    
    _navigationVC.view.frame = CGRectMake(0, 0, DEFAULT_WIDTH, DEFAULT_HEIGHT);
    _navigationVC.view.backgroundColor = [UIColor clearColor];
    _navigationVC.view.center = [self viewCenter];
    _navigationVC.view.clipsToBounds = YES;
    [self.view addSubview:_navigationVC.view];
}

- (void)showSuccessNotification:(NSNotification *)notify
{
    id param =  [notify object];
    
//    [self showSuccessAndEnter:param];
}

- (void)closeSDKNotification:(NSNotification *)notify
{
    self.isRemoving = YES;
    
    [self.callback loginCallback:nil];
    
    [self removeAllviews];
}

- (void)viewRemoveNotification:(NSNotification *)notify
{
    self.isRemoving = YES;
    
    [self removeAllviews];
}


#pragma mark - public

- (void)loginAction
{
    [self reset];

    [self setNavigationRootView];
    
    JYUserContent *cacheUser = [[JYUserCache sharedInstance] currentUser];
    if (cacheUser)
    {
        JYLoadingView *cacheLoading = (JYLoadingView *)[UIView createNibView:@"JYLoadingView"];
        cacheLoading.lodingType = CCLoading_cacheLogin;
        cacheLoading.title = [NSString stringWithFormat:@"%@ %@", [@"coco帐号" localizedString], [cacheUser.username length]==0? cacheUser.phone:cacheUser.username];
        
        _alertView = [[JYAlertView alloc] initWithCustomView:cacheLoading dismissWhenTouchedBackground:NO];
        [_alertView show];
        
        [self performSelector:@selector(delayCacheLogin:) withObject:cacheUser afterDelay:2];
    }
}

@end
