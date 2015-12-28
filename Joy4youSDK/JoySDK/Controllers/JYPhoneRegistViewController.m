//
//  JYPhoneRegistViewController.m
//  Joy4youSDK
//
//  Created by joy4you on 15/12/22.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import "JYPhoneRegistViewController.h"
#import "JYAgreementViewController.h"
#import "JYRegistViewController.h"

@interface JYPhoneRegistViewController ()
{
    NSTimer *_codeTimer;
    NSInteger _timeCount;
}

@end

@implementation JYPhoneRegistViewController

- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}

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

#pragma mark - button action

- (IBAction)handleShowAgreementAction:(UIButton *)sender {
    JYAgreementViewController *agreementVC = [[JYAgreementViewController alloc] initWithNibName:@"JYAgreementViewController" bundle:[NSBundle resourceBundle]];
    
    [self.navigationController pushViewController:agreementVC animated:YES];
}

- (IBAction)handleConfirmAgreementAction:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (IBAction)handleShowAccountRegist:(id)sender {
    JYRegistViewController *accountVC = [[JYRegistViewController alloc] initWithNibName:@"JYRegistViewController" bundle:[NSBundle resourceBundle]];
    
    [self.navigationController pushViewController:accountVC animated:YES];
}


- (IBAction)handleGetCodeAction:(id)sender {
    if ([self.phoneField.text length] == 0) {
        [self showPopText:[@"手机号不能为空" localizedString] withView:self.phoneBg];
    }else if (![self.phoneField.text validatePhoneNumber]){
        [self showPopText:[@"请填写正确的手机号" localizedString] withView:self.phoneBg];
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

- (IBAction)handleVerifyCodeAction:(id)sender {
    if (!self.confirmAgreementBtn.selected) {
        [self showPopText:[@"请同意《乐恒帐户使用协议》" localizedString] withView:nil];
        self.confirmAgreementBtn.selected = YES;
    }else{
        if ([self.phoneField.text length] == 0) {
            [self showPopText:[@"手机号不能为空" localizedString] withView:self.phoneBg];
        }else if (![self.phoneField.text validatePhoneNumber]){
            [self showPopText:[@"请填写正确的手机号" localizedString] withView:self.phoneBg];
        }else if ([self.codeField.text length] == 0){
            [self showPopText:[@"验证码不能为空" localizedString] withView:self.codeBg];
        }else if (![self.codeField.text validateVerifyCode] ){
            [self showPopText:[@"验证码为6位数字" localizedString] withView:self.codeBg];
        }else{
            JYLoadingView *cacheLoading = (JYLoadingView *)[UIView createNibView:@"JYLoadingView"];
            cacheLoading.lodingType = JYLoading_registWithUsername;
            JYAlertView *alertView = [[JYAlertView alloc] initWithCustomView:cacheLoading dismissWhenTouchedBackground:NO];
            [alertView show];

            [[JYModelInterface sharedInstance] registPhoneNumber:self.phoneField.text
                                                   andVerifyCode:self.codeField.text
                                                   callbackBlcok:^(NSError *error, NSDictionary *responseData) {
                                                       
                                                       cacheLoading.lodingType = JYLoading_registWithUsernameSuccess;
                                                       [alertView performSelector:@selector(dismissWithCompletion:) withObject:nil afterDelay:1];
                                                       
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
                                                                   [TalkingDataAppCpa onRegister:[JYUserCache sharedInstance].currentUser.userid];
                                                                   [[NSNotificationCenter defaultCenter] postNotificationName:JYNotificationShowSuccess object:[NSNumber numberWithInteger:JYLoading_registWithUsernameSuccess]];
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
}


@end
