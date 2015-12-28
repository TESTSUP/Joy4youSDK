//
//  JYFindPWByPhoneViewController.m
//  Joy4youSDK
//
//  Created by joy4you on 15/12/24.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import "JYFindPWByPhoneViewController.h"
#import "JYServiceViewController.h"
#import "JYFindPasswordViewController.h"
#import "JYSetNewPWViewController.h"

@interface JYFindPWByPhoneViewController ()
{
    NSTimer *_codeTimer;
    NSInteger _timeCount;
}

@end

@implementation JYFindPWByPhoneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.codeButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self configTextField];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSDate *date = [[NSUserDefaults standardUserDefaults] objectForKey:TICKS_DATE_KEY];
    if (date) {
        _timeCount = [[NSUserDefaults standardUserDefaults] integerForKey:TICKS_KEY];
        _timeCount += [date timeIntervalSinceNow];
        if (_timeCount >0) {
            [self startTimer];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_codeTimer invalidate];
    _codeTimer = nil;
    
    if (_timeCount < 60) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:TICKS_DATE_KEY];
        [[NSUserDefaults standardUserDefaults] setInteger:_timeCount forKey:TICKS_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)configTextField
{
    self.phoneField.delegate = self;
    self.codeField.delegate = self;
    
    _upsideTextField = self.phoneField;
    _undersideTextField = self.codeField;
    
    self.upsideLimit = 11;
    self.undersideLimit = 6;
}

- (void)timeCountAction
{
    _timeCount--;
    NSLog(@"code count = %ld", (long)_timeCount);
    
    if (_timeCount <= 0) {
        [self stopTimer];
    } else {
        NSString *countStr = [NSString stringWithFormat:@"%ld秒", (long)_timeCount];
        [self.codeButton setTitle:countStr forState:UIControlStateNormal];
    }
}

- (void)startTimer
{
    if (_codeTimer) {
        [_codeTimer invalidate];
        _codeTimer = nil;
    }
    NSString *countStr = [NSString stringWithFormat:@"%ld秒", (long)_timeCount];
    [self.codeButton setTitle:countStr forState:UIControlStateNormal];
    
    self.codeButton.enabled = NO;
    _codeTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(timeCountAction)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)stopTimer
{
    _timeCount = 60;
    self.codeButton.enabled = YES;
    [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_codeTimer invalidate];
    _codeTimer = nil;
}

#pragma mark - action

- (IBAction)handleVerifyCodeACtion:(id)sender {
    if ([self.phoneField.text length] == 0) {
        [self showPopText:[@"手机号不能为空" localizedString] withView:self.accountBG];
    }else if (![self.phoneField.text validatePhoneNumber]){
        [self showPopText:[@"请填写正确的手机号" localizedString] withView:self.accountBG];
    }else if ([self.codeField.text length] == 0){
        [self showPopText:[@"验证码不能为空" localizedString] withView:self.codeBg];
    }else if ([self.codeField.text length] > 6){
        [self showPopText:[@"验证码为6位数字" localizedString] withView:self.codeBg];
    }else{
        JYLoadingView *cacheLoading = (JYLoadingView *)[UIView createNibView:@"JYLoadingView"];
        cacheLoading.lodingType = JYLoading_VerifyCode;
        JYAlertView *alertView = [[JYAlertView alloc] initWithCustomView:cacheLoading dismissWhenTouchedBackground:NO];
        [alertView show];
        
        [[JYModelInterface sharedInstance] verifyCodeWithPhone:self.phoneField.text
                                                          code:self.codeField.text
                                                 callbackBlock:^(NSError *error, NSDictionary *responseData) {
                                                     
                                                     NSString * msg = nil;
                                                     if (!error)
                                                     {
                                                         NSString* status = responseData[KEY_STATUS];
                                                         
                                                         switch (status.integerValue) {
                                                             case 200:
                                                             {
                                                                 [alertView performSelector:@selector(dismissWithCompletion:)
                                                                                 withObject:^{
                                                                                     JYSetNewPWViewController *setVC = [[JYSetNewPWViewController alloc] initWithNibName:@"JYSetNewPWViewController" bundle:[NSBundle resourceBundle]];
                                                                                     [self.navigationController pushViewController:setVC animated:YES];
                                                                                 }
                                                                                 afterDelay:1];
                                                                 return;
                                                             }
                                                                 break;
                                                             case 101:
                                                             case 102:
                                                             case 103:
                                                             case 104:
                                                             case 105:
                                                             {
                                                                 //101 ckid不能为空
                                                                 //102用户名不能为空
                                                                 //103 用户名不合法
                                                                 //104邮箱不能为空
                                                                 //105 您输入的电子邮件地址不合法
                                                                 msg = responseData[KEY_MSG];
                                                             }
                                                                 break;
                                                             case 106:
                                                             {
                                                                 
                                                                 //106 输入的邮箱与绑定的邮箱不一致
                                                                 msg = [@"输入的邮箱与绑定的邮箱不一致" localizedString];
                                                                 
                                                             }
                                                                 break;
                                                             case 107:
                                                             {
                                                                 //107 该用户没有绑定过邮箱
                                                                 msg = [@"该用户没有绑定过邮箱" localizedString];
                                                             }
                                                                 break;
                                                             default:
                                                                 msg= responseData[KEY_MSG];
                                                                 break;
                                                         }
                                                     }
                                                     else
                                                     {
                                                         JYDLog(@"Tourist login error", error);
                                                         msg = [@"网络状态不好，请稍后重试" localizedString];
                                                     }
                                                     
                                                     [alertView performSelector:@selector(dismissWithCompletion:)
                                                                     withObject:nil
                                                                     afterDelay:1];
                                                     [self showPopText:msg withView:nil];
                                                 }];
        
    }
}

- (IBAction)handleShowServiceAction:(id)sender {
    JYServiceViewController *serviceVC = [[JYServiceViewController alloc] initWithNibName:@"JYServiceViewController" bundle:[NSBundle resourceBundle]];
    
    [self.navigationController pushViewController:serviceVC animated:YES];
    
}

- (IBAction)handleGetCodeAction:(id)sender {
    if ([self.phoneField.text length] == 0) {
        [self showPopText:[@"手机号不能为空" localizedString] withView:self.accountBG];
    }else if (![self.phoneField.text validatePhoneNumber]){
        [self showPopText:[@"请填写正确的手机号" localizedString] withView:self.accountBG];
    } else {
        JYLoadingView *cacheLoading = (JYLoadingView *)[UIView createNibView:@"JYLoadingView"];
        cacheLoading.lodingType = JYLoading_GetCode;
        JYAlertView *alertView = [[JYAlertView alloc] initWithCustomView:cacheLoading dismissWhenTouchedBackground:NO];
        [alertView show];
        
        [[JYModelInterface sharedInstance] getVerifyCodeWithPhone:self.phoneField.text
                                                    callbackBlock:^(NSError *error, NSDictionary *responseData) {
                                                        [alertView dismissWithCompletion:nil];
                                                        
                                                        NSString * msg = nil;
                                                        if (error) {
                                                            JYDLog(@"regist error", error);
                                                            msg = [@"网络状态不好，请稍后重试" localizedString];
                                                        }
                                                        else {
                                                            NSString* status = responseData[KEY_STATUS];
                                                            
                                                            switch (status.integerValue) {
                                                                case 200:
                                                                {
                                                                    _timeCount = 60;
                                                                    [self startTimer];
                                                                    return;
                                                                }
                                                                    break;
                                                                case 101:
                                                                case 102:
                                                                case 103:
                                                                case 104:
                                                                case 105:
                                                                case 106:
                                                                case 107:
                                                                {
                                                                    //101 appid不能为空
                                                                    //102 用户名不能为空
                                                                    //103 用户名不合法
                                                                    //104 密码不能为空
                                                                    //105 ckid不能为空
                                                                    //106 渠道id不能为空
                                                                    //107 appid不合法
                                                                    msg = responseData[KEY_MSG];
                                                                }
                                                                    break;
                                                                case 108:
                                                                {
                                                                    //108用户名已存在
                                                                    msg = [@"用户名已存在" localizedString];
                                                                }
                                                                    break;
                                                                default:
                                                                    msg= responseData[KEY_MSG];
                                                                    break;
                                                            }
                                                        }
                                                        [self showPopText:msg withView:nil];
                                                    }];
    }
}

- (IBAction)handleShowEmail:(id)sender {
    JYFindPasswordViewController *serviceVC = [[JYFindPasswordViewController alloc] initWithNibName:@"JYFindPasswordViewController" bundle:[NSBundle resourceBundle]];
    
    [self.navigationController pushViewController:serviceVC animated:YES];
    
}
@end
