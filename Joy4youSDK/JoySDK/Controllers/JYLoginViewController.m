//
//  JYLoginViewController.m
//  Joy4youSDK
//
//  Created by temp on 15/11/24.
//  Copyright (c) 2015年 LeHeng. All rights reserved.
//

#import "JYLoginViewController.h"
#import "JYRegistViewController.h"
#import "JYPhoneRegistViewController.h"
#import "JYBindEmailViewController.h"
#import "JYFindPWByPhoneViewController.h"
#import "JYFindPasswordViewController.h"
#import "JYUtil.h"
#import "JYUserCache.h"
#import "JYModelInterface.h"
#import "JYLoadingView.h"
#import "JYAlertView.h"
#import "JYCacheListView.h"

@interface JYLoginViewController () <JYCacheUserListDelegate>
{
    JYCacheListView *_cacheView;
    
    BOOL    _showCache;
}

@end

@implementation JYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self configTextField];
    
    [self configSubViews];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginKeyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)configTextField
{
    UIImageView *accountView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 17)];
    UIImageView *passwordView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 17)];
    
    accountView.image = [UIImage imageNamedFromBundle:@"jy_user_login.png"];
    passwordView.image = [UIImage imageNamedFromBundle:@"jy_pwd_login.png"];
    
    accountView.contentMode = UIViewContentModeScaleAspectFit;
    passwordView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.accountTextField.leftView = accountView;
    self.passwordTextField.leftView = passwordView;
    
    self.accountTextField.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    
    self.accountTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    _upsideTextField = self.accountTextField;
    _undersideTextField = self.passwordTextField;
    
    self.upsideLimit = 20;
    self.undersideLimit = 15;
    
    if ([[JYUserCache sharedInstance].normalUserList count])
    {
        UIButton *cacheBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
        [cacheBtn setImage:[UIImage imageNamedFromBundle:@"jy_login_pulldown_btn.png"] forState:UIControlStateNormal];
        self.accountTextField.rightView = cacheBtn;
        self.accountTextField.rightViewMode = UITextFieldViewModeAlways;
        [cacheBtn addTarget:self action:@selector(handleShowCacheListAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)configSubViews
{
    //下拉列表
    NSArray *nibArray = [[NSBundle resourceBundle] loadNibNamed:@"JYCacheListView" owner:nil options:nil];
    _cacheView = [nibArray firstObject];
    _cacheView.delegate = self;
    
    _cacheView.frame = CGRectMake(self.accountBg.frame.origin.x,
                                  self.accountBg.frame.origin.y+self.accountBg.frame.size.height,
                                  self.accountBg.frame.size.width,
                                  0);
    [self.view addSubview:_cacheView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma cache list

- (CGFloat)getListHeight
{
    NSArray *cacheArray = [[JYUserCache sharedInstance] normalUserList];
    
    CGFloat height = 135;
    
    switch ([cacheArray count]) {
        case 0:
            height = 0;
            break;
        case 1:
            height = 45;
            break;
        case 2:
            height = 90;
            break;
        default:
            height = 135;
            break;
    }
    
    return height;
}

- (void)showLoginCacheList:(BOOL)aShow
{
    _showCache = aShow;
    [UIView animateWithDuration:0.2
                     animations:^{
                         if (_showCache)
                         {
                             [_actionTextField resignFirstResponder];
                             _cacheView.frame = CGRectMake(self.accountBg.frame.origin.x,
                                                           self.accountBg.frame.origin.y+self.accountBg.frame.size.height,
                                                           self.accountBg.frame.size.width,
                                                           [self getListHeight]);
                         }
                         else
                         {
                             _cacheView.frame = CGRectMake(self.accountBg.frame.origin.x,
                                                           self.accountBg.frame.origin.y+self.accountBg.frame.size.height,
                                                           self.accountBg.frame.size.width,
                                                           0);
                         }
                     }];
}

#pragma mark - JYCacheUserListDelegate

- (void)JYCacheUserListDidSelectedUser:(JYUserContent *)aUser
{
    if ([aUser.username length]>0) {
        self.accountTextField.text = aUser.username;
    }else if ([aUser.phone length]){
        self.accountTextField.text = aUser.phone;
    }
    
    [self handleShowCacheListAction:(UIButton *)self.accountTextField.rightView];
    
}

- (void)JYCacheUserListDidDeletedUser:(JYUserContent *)aUser
{
    NSArray* cacheArray = [[JYUserCache sharedInstance] normalUserList];
    
    if ([cacheArray count] == 0) {
        [self showLoginCacheList:NO];
        self.accountTextField.rightView = nil;
        self.accountTextField.rightViewMode = UITextFieldViewModeWhileEditing;
    }
    else
    {
        [self showLoginCacheList:YES];
    }
}

#pragma mark - notification

- (void)loginKeyboardWillAppear:(NSNotification *)aNotify
{
    [self showLoginCacheList:NO];
}

#pragma mark - button action

- (void)handleShowCacheListAction:(UIButton *)aBtn
{
    aBtn.selected = !aBtn.selected;
    
    [self showLoginCacheList:!_showCache];
}

- (IBAction)handleRegistAction:(id)sender
{
    JYPhoneRegistViewController *registVC = [[JYPhoneRegistViewController alloc] initWithNibName:@"JYPhoneRegistViewController" bundle:[NSBundle resourceBundle]];
    
    [self.navigationController pushViewController:registVC animated:YES];
}

- (IBAction)handleBindEmailACion:(id)sender
{
    JYBindEmailViewController *registVC = [[JYBindEmailViewController alloc] initWithNibName:@"JYBindEmailViewController" bundle:[NSBundle resourceBundle]];
    
    [self.navigationController pushViewController:registVC animated:YES];
}

- (IBAction)handleFindPasswordAction:(id)sender
{
    JYFindPWByPhoneViewController *registVC = [[JYFindPWByPhoneViewController alloc] initWithNibName:@"JYFindPWByPhoneViewController" bundle:[NSBundle resourceBundle]];
    
    [self.navigationController pushViewController:registVC animated:YES];
    
}

- (IBAction)handleTouristLoginAction:(id)sender {

    [self showLoadingViewWith:JYLoading_guestLogin];
    
    [[JYModelInterface sharedInstance] touristLoginWithCallbackBlcok:^(NSError *error, NSDictionary *responseData) {
        
        [self performSelector:@selector(dismissWithCompletion:) withObject:nil afterDelay:1];
        
        NSString * msg= nil;
        if (error) {
            JYDLog(@"Tourist login error = %@", error);
            msg = [@"网络状态不好，请稍后重试" localizedString];
        }
        else {
            NSString* status = responseData[KEY_STATUS];
            
            switch (status.integerValue) {
                case 200:
                {
                    [TalkingDataAppCpa onLogin:[JYUserCache sharedInstance].currentUser.userid];
                    [[NSNotificationCenter defaultCenter] postNotificationName:JYNotificationShowSuccess object:[NSNumber numberWithInteger:JYLoading_loginWithUsernameSuccess]];
                    return;
                }
                    break;
                case 101:
                case 102:
                case 103:
                {
                    //101 appid不能为空
                    //102 ckid不能为空
                    //103 渠道id不能为空
                    msg = responseData[KEY_MSG];
                }
                    break;
                case 104:
                {
                    //appid不合法
                    msg = [@"appid不合法" localizedString];
                }
                    break;
                default:
                    msg= [@"游客登录失败" localizedString];
                    break;
            }
        }
        [self showPopText:msg withView:nil];
    }];
}

- (IBAction)handleLoginAction:(id)sender
{
    [self hideKeybord];
    
    NSString *nickname = self.accountTextField.text;
    NSString *password = self.passwordTextField.text;
    NSString *popText = nil;
    
    if ([nickname length] == 0 || [password length] == 0) {
        popText = [@"帐号或密码不能为空" localizedString];
    }else if ([nickname length] < 6 ||
              [nickname length] > 20 ||
              [password length] < 6 ||
              [password length] > 15) {
        popText = [@"帐号或密码错误" localizedString];
    }
    
    if ([popText length] > 0) {
        [self showPopText:popText withView:self.accountBg];;
    } else {
        [self showLoadingViewWith:JYLoading_loginWithUsername];
        
        if ([nickname validatePhoneNumber]) {
            [[JYModelInterface sharedInstance] loginWithPhoneNumber:nickname
                                                        andPassword:password
                                                      callbackBlcok:^(NSError *error, NSDictionary *responseData) {
                                                          
                                                          [self performSelector:@selector(dismissWithCompletion:) withObject:nil afterDelay:1];
                                                          
                                                          NSString * msg = nil;
                                                          if (error) {
                                                              JYDLog(@"Tourist login error", error);
                                                              msg = [@"网络状态不好，请稍后重试" localizedString];
                                                          }
                                                          else {
                                                              NSString* status = responseData[KEY_STATUS];
                                                              
                                                              switch (status.integerValue) {
                                                                  case 200:
                                                                  {
                                                                      [TalkingDataAppCpa onLogin:[JYUserCache sharedInstance].currentUser.userid];
                                                                      [[NSNotificationCenter defaultCenter] postNotificationName:JYNotificationShowSuccess object:[NSNumber numberWithInteger:JYLoading_loginWithUsernameSuccess]];
                                                                      return;
                                                                  }
                                                                      break;
                                                                  case 101:
                                                                  case 102:
                                                                  case 104:
                                                                  case 105:
                                                                  case 106:
                                                                  {
                                                                      //101 appid不能为空
                                                                      //102手机号不能为空
                                                                      //104密码不能为空
                                                                      //105 ckid不能为空
                                                                      //106渠道id不能为空
                                                                      msg = responseData[KEY_MSG];
                                                                  }
                                                                      break;
                                                                  case 103:
                                                                  {
                                                                      //103手机号不合法
                                                                      msg = [@"手机号不合法" localizedString]; 
                                                                  }
                                                                      break;
                                                                  case 107:
                                                                  {
                                                                      //107 appid不合法
                                                                      msg = [@"appid不合法" localizedString];
                                                                  }
                                                                      break;
                                                                  case 108:
                                                                  {
                                                                      //108手机号不存在
                                                                      msg = [@"手机号不存在" localizedString];
                                                                  }
                                                                      break;
                                                                  case 109:
                                                                  {
                                                                      //109手机号不存在
                                                                      msg = [@"手机号密码不匹配" localizedString];
                                                                  }
                                                                      break;
                                                                  default:
                                                                      msg= responseData[KEY_MSG];
                                                                      break;
                                                              }
                                                          }
                                                          [self showPopText:msg withView:nil];
                                                      }];
        } else {
            [[JYModelInterface sharedInstance] loginWithUsername:nickname
                                                     andPassword:password
                                                   callbackBlcok:^(NSError *error, NSDictionary *responseData) {
                                                       
                                                       [self performSelector:@selector(dismissWithCompletion:) withObject:nil afterDelay:1];
                                                       
                                                       NSString * msg = nil;
                                                       if (error) {
                                                           JYDLog(@"Tourist login error", error);
                                                           msg = [@"网络状态不好，请稍后重试" localizedString];
                                                       }
                                                       else {
                                                           NSString* status = responseData[KEY_STATUS];
                                                           
                                                           switch (status.integerValue) {
                                                               case 200:
                                                               {
                                                                   [TalkingDataAppCpa onLogin:[JYUserCache sharedInstance].currentUser.userid];
                                                                   [[NSNotificationCenter defaultCenter] postNotificationName:JYNotificationShowSuccess object:[NSNumber numberWithInteger:JYLoading_loginWithUsernameSuccess]];
                                                                   return;
                                                               }
                                                                   break;
                                                               case 101:
                                                               case 102:
                                                               case 103:
                                                               case 104:
                                                               case 105:
                                                               case 106:
                                                               {
                                                                   //101 appid不能为空
                                                                   //102用户名不能为空
                                                                   //103 用户名不合法
                                                                   //104密码不能为空
                                                                   //105 ckid不能为空
                                                                   //106渠道id不能为空
                                                                   
                                                                   msg = responseData[KEY_MSG];
                                                               }
                                                                   break;
                                                               case 107:
                                                               {
                                                                   //appid不合法
                                                                   msg = [@"appid不合法" localizedString];
                                                               }
                                                                   break;
                                                               case 108:
                                                               {
                                                                   //108用户名不存在
                                                                   msg = [@"用户名不存在" localizedString];
                                                               }
                                                                   break;
                                                               case 109:
                                                               {
                                                                   //109 用户名密码不匹配
                                                                   msg = [@"用户名密码不匹配" localizedString];
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
