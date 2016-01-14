//
//  JYBindEmailViewController.m
//  Joy4youSDK
//
//  Created by temp on 15/11/24.
//  Copyright (c) 2015年 LeHeng. All rights reserved.
//

#import "JYBindEmailViewController.h"
#import "JYLoadingView.h"
#import "JYModelInterface.h"
#import "JYUtil.h"

@interface JYBindEmailViewController ()

@end

@implementation JYBindEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configTextField];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configTextField
{
    self.accountTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.emailTextField.delegate = self;
    
    _upsideTextField = self.accountTextField;
    _undersideTextField = self.passwordTextField;
    _bottomTextField = self.emailTextField;
    
    self.upsideLimit = 20;
    self.undersideLimit = 15;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)handleBindAction:(id)sender {
    [self hideKeybord];
    
    NSString *nickname = self.accountTextField.text;
    NSString *password = self.passwordTextField.text;
    NSString *email = self.emailTextField.text;
    NSString *popText = nil;
    
    if ([nickname length] == 0) {
        popText = [@"用户名不能为空" localizedString];
    } else if ([password length] == 0) {
        popText = [@"密码不能为空" localizedString];
    } else if ([email length] == 0) {
        popText = [@"邮箱地址不能为空" localizedString];
    }
//    else if ([nickname length] < 6 ||
//              [nickname length] > 20 ||
//              [password length] < 6 ||
//              [password length] > 15) {
//        popText = [@"账号或密码错误" localizedString];
//    }
    else if(![email validateEmailAddress]) {
        popText = [@"请填写正确的邮箱地址" localizedString];
    }
    
    if ([popText length] > 0) {
        [self showPopText:popText withView:self.accountBg];;
    } else {
        [self showLoadingViewWith:JYLoading_Binding];
        
        if ([nickname validatePhoneNumber]) {
            [[JYModelInterface sharedInstance] bindEmailWithPhoneNUmber:nickname
                                                               password:password
                                                                  email:email
                                                          callbackBlock:^(NSError *error, NSDictionary *responseData) {
                                                              
                                                              NSString * msg = nil;
                                                              if (!error)
                                                              {
                                                                  NSString* status = responseData[KEY_STATUS];
                                                                  
                                                                  switch (status.integerValue) {
                                                                      case 200:
                                                                      {
                                                                          [self showLoadingViewWith:JYLoading_bindSuccess];
                                                                          [self performSelector:@selector(dismissWithCompletion:)
                                                                                          withObject:^{
                                                                                              [self.navigationController popToRootViewControllerAnimated:YES];
                                                                                          }
                                                                                          afterDelay:1];
                                                                          return;
                                                                      }
                                                                          break;
                                                                      case 101:
                                                                      case 102:
                                                                      case 104:
                                                                      case 105:
                                                                      {
                                                                          //101 ckid不能为空
                                                                          //102 手机号不能为空
                                                                          //104 密码不能为空
                                                                          //105 邮箱不能为空
                                                                          msg = [@"参数错误" localizedString];
                                                                      }
                                                                          break;
                                                                      case 103:
                                                                      {
                                                                          //103手机号不合法
                                                                          msg = [@"手机号不合法" localizedString];
                                                                      }
                                                                          break;
                                                                      case 106:
                                                                      {
                                                                          //106 您输入的电子邮件地址不合法
                                                                          msg = [@"请填写正确的邮箱地址" localizedString];
                                                                      }
                                                                          break;
                                                                      case 107:
                                                                      {
                                                                          //107 该手机号已经绑定过邮箱
                                                                          msg = [@"该手机号已经绑定过邮箱" localizedString];
                                                                      }
                                                                          break;
                                                                      case 108:
                                                                      {
                                                                          //手机号密码不正确，请核对后在填
                                                                          msg = [@"手机号或密码错误" localizedString];
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
                                                              
                                                              [self performSelector:@selector(dismissWithCompletion:) withObject:nil afterDelay:1];
                                                              [self showPopText:msg withView:nil];
                                                          }];
        } else {
            [[JYModelInterface sharedInstance] bindEmailWithUsername:nickname
                                                            password:password
                                                               email:email
                                                       callbackBlock:^(NSError *error, NSDictionary *responseData) {
                                                           
                                                           NSString * msg = nil;
                                                           if (!error)
                                                           {
                                                               NSString* status = responseData[KEY_STATUS];
                                                               
                                                               switch (status.integerValue) {
                                                                   case 200:
                                                                   {
                                                                       [self showLoadingViewWith:JYLoading_bindSuccess];
                                                                       [self performSelector:@selector(dismissWithCompletion:)
                                                                                       withObject:^{
                                                                                           [self.navigationController popToRootViewControllerAnimated:YES];
                                                                                       }
                                                                                       afterDelay:1];
                                                                       return;
                                                                   }
                                                                       break;
                                                                   case 101:
                                                                   case 102:
                                                                   case 104:
                                                                   case 105:
                                                                   {
                                                                       //101 ckid不能为空
                                                                       //102  用户名不能为空
                                                                       //104 密码不能为空
                                                                       //105 邮箱不能为空
                                                                       msg = [@"参数错误" localizedString];
                                                                   }
                                                                       break;
                                                                   case 103:
                                                                   {
                                                                       //103 用户名不合法
                                                                       msg = [@"用户名不合法" localizedString];
                                                                   }
                                                                       break;
                                                                   case 106:
                                                                   {
                                                                       //106 您输入的电子邮件地址不合法
                                                                       msg = [@"请填写正确的邮箱地址" localizedString];
                                                                   }
                                                                       break;
                                                                   case 107:
                                                                   {
                                                                       //该用户已经绑定过邮箱
                                                                       msg = [@"该用户名已绑定过邮箱" localizedString];
                                                                   }
                                                                       break;
                                                                   case 108:
                                                                   {
                                                                       //用户名密码不正确，请核对后在填
                                                                       msg = [@"用户名或密码错误" localizedString];
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
                                                           
                                                           [self performSelector:@selector(dismissWithCompletion:) withObject:nil afterDelay:1];
                                                           [self showPopText:msg withView:nil];
                                                       }];
        }
    }
}
@end
