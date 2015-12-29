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
#import "JYBindAlertViewController.h"
#import "JYUserCache.h"
#import "JYUtil.h"
#import "JYModelInterface.h"
#import "JYLoadingView.h"

@interface JoyMainViewController () <UIGestureRecognizerDelegate>
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

+ (void)clear
{
    instance = nil;
    token = 0;
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
    self.view.layer.cornerRadius = CC_CORNERRADIUS;
    self.view.clipsToBounds = YES;
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleBackgroundTap)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    
    [self addObservers];
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

#pragma mark - UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {//如果当前是tableView
        //做自己想做的事
        return NO;
    }
    return YES;
}

#pragma mark - handle view

- (CGPoint)viewCenter
{
    return CGPointMake(self.view.bounds.size.width/2,
                       self.view.bounds.size.height/2);
}

- (void)removeAllviews
{
    [_navigationVC.view removeFromSuperview];
    
//    if ([_tickTimer isValid]) {
//        [_tickTimer invalidate];
//        _tickTimer = nil;
//    }
    
    [Joy4youSDK removeSDKFromRootView];
}

- (void)showSuccessWithLoadingType:(JYLoadingType)aType
{
    [_navigationVC.view removeFromSuperview];
    
    JYLoadingView *successView = (JYLoadingView *)[UIView createNibView:@"JYLoadingView"];
    successView.lodingType = aType;

    UIView *aView = successView;
    aView.frame = CGRectMake((self.view.bounds.size.width-aView.frame.size.width)/2,
                             40,
                             aView.frame.size.width,
                             aView.frame.size.height);
    aView.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:aView];
    aView.alpha = 0;
    
    CGPoint center = aView.center;
    
    CGPoint realCenter = [self.view convertPoint:center toView:[self.view superview]];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.view.bounds = aView.bounds;
    self.view.center = realCenter;
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         aView.alpha = 1.0;
                     } completion:^(BOOL finished) {
                         
                     }];
    
    self.isRemoving = YES;
    //回调
    JYUserContent *user =[JYUserCache sharedInstance].currentUser;
    [self.callback loginCallback:@{@"state": @"0", @"username":user.username, @"token":user.token}];
    [self performSelector:@selector(loginSuccessRemove) withObject:nil afterDelay:2];;
    
}

- (void)loginSuccessRemove
{
    if ([self shouldShowBindAlert])
    {
        //绑定账号提醒
        self.view.frame = [[self.view superview] bounds];
        self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        self.isRemoving = NO;
        
        JYBindAlertViewController *bindVC = [[JYBindAlertViewController alloc] initWithNibName:@"JYBindAlertViewController" bundle:[NSBundle resourceBundle]];
        [self setNavigationWithRoot:bindVC];
    }
    else
    {
        self.isRemoving = YES;
        [self removeAllviews];
    }
}

- (BOOL)shouldShowBindAlert
{
    JYUserContent *user =[JYUserCache sharedInstance].currentUser;
    
    if (user.type == 2) {
        return YES;
    }
    
    return NO;
}

#pragma mark - handle action

- (void)delayCacheLogin:(JYUserContent *)cacheUser
{
    if ([_navigationVC.viewControllers count] == 1)
    {
        [[JYModelInterface sharedInstance] cacheLoginWithSessionId:cacheUser.sessionid
                                                         andUserId:cacheUser.userid
                                                     CallbackBlcok:^(NSError *error, NSDictionary *responseData) {
                                                         
                                                         [_alertView dismissWithCompletion:nil];
                                                         
                                                         NSString * msg= nil;
                                                         if (error) {
                                                             JYDLog(@"Tourist login error", error);
                                                             msg = [@"网络状态不好，请稍后重试" localizedString];
                                                         } else {
                                                             NSString* status = responseData[KEY_STATUS];
                                                             switch (status.integerValue) {
                                                                 case 200:
                                                                 {
                                                                     [TalkingDataAppCpa onLogin:cacheUser.userid];
                                                                     [self showSuccessWithLoadingType:JYLoading_loginWithUsernameSuccess];
                                                                     return;
                                                                 }
                                                                     break;
                                                                 case 101:
                                                                 case 102:
                                                                 case 103:
                                                                 case 104:
                                                                 case 105:
                                                                 case 108:
                                                                 {
                                                                     //101 appid不能为空
                                                                     //102sessionid不能为空
                                                                     //103 userid不能为空
                                                                     //104ckid不能为空
                                                                     //105 渠道id不能为空
                                                                     //108 sessionid已经过期:
                                                                     msg = responseData[KEY_MSG];
                                                                 }
                                                                     break;
                                                                 case 106:
                                                                 {
                                                                     //appid不合法
                                                                     msg = [@"appid不合法" localizedString];
                                                                 }
                                                                     break;
                                                                 default:
                                                                     msg = [@"缓存登录失败" localizedString];
                                                                     break;
                                                             }
                                                         }
                                                         JYViewController *topVC = (JYViewController *)_navigationVC.topViewController;
                                                         [topVC showPopText:msg withView:nil];
                                                     }];
    }
}

- (void)handleBackgroundTap
{
    JYViewController *topVC = (JYViewController *)_navigationVC.topViewController;
    [topVC hideKeybord];
}

- (void)handleSwitchAccount:(UIButton *)aBtn
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(delayCacheLogin:) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [[JYModelInterface sharedInstance] cancelAllRequest];
    
    [_alertView dismissWithCompletion:nil];
}

- (void)reset
{
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [_navigationVC.view removeFromSuperview];
    _navigationVC = nil;
    [[JYModelInterface sharedInstance] cancelAllRequest];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(loginSuccessRemove) object:nil];
    self.isRemoving = NO;
}

#pragma mark - notification

- (void)setNavigationWithRoot:(UIViewController *)rootVC
{
    _navigationVC = [[JYNavigationController alloc] initWithRootViewController:rootVC];
    [_navigationVC setNavigationBarHidden:YES animated:NO];
    _navigationVC.view.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleBottomMargin;
    
    _navigationVC.view.frame = CGRectMake(0, 0, DEFAULT_WIDTH, DEFAULT_HEIGHT);
    _navigationVC.view.backgroundColor = [UIColor clearColor];
    _navigationVC.view.center = [self viewCenter];
    _navigationVC.view.layer.cornerRadius = CC_CORNERRADIUS;
    _navigationVC.view.clipsToBounds = YES;
    [self.view addSubview:_navigationVC.view];
}

- (void)showSuccessNotification:(NSNotification *)notify
{
    NSNumber* param =  [notify object];
    
    [self showSuccessWithLoadingType:(JYLoadingType)[param integerValue]];
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

    JYLoginViewController *loginVC = [[JYLoginViewController alloc] initWithNibName:@"JYLoginViewController" bundle:[NSBundle resourceBundle]];
    [self setNavigationWithRoot:loginVC];
    
    JYUserContent *cacheUser = [[JYUserCache sharedInstance] currentUser];
    if (cacheUser)
    {
        JYLoadingView *cacheLoading = (JYLoadingView *)[UIView createNibView:@"JYLoadingView"];
        cacheLoading.lodingType = JYLoading_cacheLogin;
        [cacheLoading.switchBtn addTarget:self action:@selector(handleSwitchAccount:) forControlEvents:UIControlEventTouchUpInside];
        _alertView = [[JYAlertView alloc] initWithCustomView:cacheLoading dismissWhenTouchedBackground:NO];
        [_alertView show];
        
        [self performSelector:@selector(delayCacheLogin:) withObject:cacheUser afterDelay:2];
    }
}

@end
