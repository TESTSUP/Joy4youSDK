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

#define TICKS_KEY          @"joy_PW_tick_key"
#define TICKS_DATE_KEY     @"joy_PW_tick_date_key"

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
    [super viewWillDisappear:animated];
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
    JYDLog(@"code count = %ld", (long)_timeCount);
    
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
    if ([self.phoneField.text length] == 0 || [self.codeField.text length] == 0) {
        [self showPopText:[@"手机号和验证码不能为空" localizedString] withView:self.accountBG];
    }else if (![self.phoneField.text validatePhoneNumber]){
        [self showPopText:[@"请输入11位正确的手机号" localizedString] withView:self.accountBG];
    }else if ([self.codeField.text validateVerifyCode] ){
        [self showPopText:[@"请输入6位数字验证码" localizedString] withView:self.codeBg];
    }else{
        [self showLoadingViewWith:JYLoading_VerifyCode];
        [[JYModelInterface sharedInstance] verifyCodeWithPhone:self.phoneField.text
                                                          code:self.codeField.text
                                                 callbackBlock:^(NSError *error, NSDictionary *responseData) {
                                                     
                                                     NSString * msg = nil;
                                                     if (!error)
                                                     {
                                                         NSString* status = responseData[KEY_STATUS];
                                                         NSDictionary *data = (NSDictionary *)responseData[KEY_DATA];
                                                         NSString *phone = data[KEY_PHONE];
                                                         NSString *token = data[KEY_TOKEN];
                                                         switch (status.integerValue) {
                                                             case 200:
                                                             {
                                                                 [self performSelector:@selector(dismissWithCompletion:)
                                                                                 withObject:^{
                                                                                     JYSetNewPWViewController *setVC = [[JYSetNewPWViewController alloc] initWithNibName:@"JYSetNewPWViewController" bundle:[NSBundle resourceBundle]];
                                                                                     setVC.phone = phone;
                                                                                     setVC.token = token;
                                                                                     [self.navigationController pushViewController:setVC animated:YES];
                                                                                 }
                                                                                 afterDelay:1];
                                                                 return;
                                                             }
                                                                 break;
                                                             case 101:
                                                             case 103:
                                                             {
                                                                 //101 手机号不能为空
                                                                 //103 验证码不能为空
                                                                 msg = [@"参数错误" localizedString];
                                                             }
                                                                 break;
                                                             case 102:
                                                             {
                                                                 //102 手机号不合法
                                                                 msg = [@"手机号不合法" localizedString];
                                                             }
                                                                 break;
                                                             case 104:
                                                             {
                                                                 //104 验证码已经失效
                                                                 msg = [@"验证码已经失效" localizedString];
                                                                 
                                                             }
                                                                 break;
                                                             case 105:
                                                             {
                                                                 //105 验证码不正确
                                                                 msg = [@"验证码不正确" localizedString];
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
                                                         msg = [@"网络状态不好，请您检查网络后重试" localizedString];
                                                     }
                                                     
                                                     [self performSelector:@selector(dismissWithCompletion:)
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
    [self hideKeybord];
    
    if ([self.phoneField.text length] == 0) {
        [self showPopText:[@"手机号不能为空" localizedString] withView:self.accountBG];
    }else if (![self.phoneField.text validatePhoneNumber]){
        [self showPopText:[@"请输入11位正确的手机号" localizedString] withView:self.accountBG];
    } else {
        [self showLoadingViewWith:JYLoading_GetCode];
        [[JYModelInterface sharedInstance] findPasswordGetVerifyCodeWithPhone:self.phoneField.text
                                                                callbackBlock:^(NSError *error, NSDictionary *responseData) {
                                                                    [self performSelector:@selector(dismissWithCompletion:) withObject:nil afterDelay:0.5];
                                                                    
                                                                    NSString * msg = nil;
                                                                    if (error) {
                                                                        JYDLog(@"regist error", error);
                                                                        msg = [@"网络状态不好，请您检查网络后重试" localizedString];
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
                                                                            case 103:
                                                                            case 106:
                                                                            {
                                                                                //101 手机号不能为空
                                                                                //103 ckid不能为空
                                                                                //106 为第三方返回的错误信息  （请客户端直接使用msg）
                                                                                
                                                                                msg = [@"参数错误" localizedString];
                                                                            }
                                                                                break;
                                                                            case 107:
                                                                            {
                                                                                //107 获取验证码次数过多，请明天再试
                                                                                msg= responseData[KEY_MSG];
                                                                            }
                                                                                break;
                                                                            case 102:
                                                                            {
                                                                                //102 手机号不合法
                                                                                msg = [@"手机号不合法" localizedString];
                                                                            }
                                                                                break;
                                                                            case 104:
                                                                            {
                                                                                //104 电话号没有注册过账号，请核对手机号
                                                                                msg = [@"手机号不存在" localizedString];
                                                                            }
                                                                                break;
                                                                            case 105:
                                                                            {
                                                                                //105 两次发送时间间隔不能少于1分钟
                                                                                msg = [@"验证码获取频繁" localizedString];
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
