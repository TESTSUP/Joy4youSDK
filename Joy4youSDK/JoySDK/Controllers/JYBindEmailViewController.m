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
    
    if ([nickname length] == 0 || [password length] == 0 || [email length] == 0) {
        popText = [@"帐号或密码或邮箱不能为空" localizedString];
    }else if ([nickname length] < 6 ||
              [nickname length] > 20 ||
              [password length] < 6 ||
              [password length] > 15) {
        popText = [@"帐号或密码错误" localizedString];
    } else if(![email validateEmailAddress]) {
        popText = [@"请输入合法的邮箱地址" localizedString];
    }
    
    if ([popText length] > 0) {
        [self showPopText:popText withView:self.accountBg];;
    } else {
        
        JYLoadingView *loadingView = (JYLoadingView *)[UIView createNibView:@"JYLoadingView"];
        loadingView.lodingType = JYLoading_Binding;
        loadingView.title = [NSString stringWithFormat:@"%@ %@", [@"帐号" localizedString], nickname];
        JYAlertView *alertView = [[JYAlertView alloc] initWithCustomView:loadingView dismissWhenTouchedBackground:NO];
        [alertView show];
        
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
                                                                          loadingView.lodingType = JYLoading_bindSuccess;
                                                                          [alertView performSelector:@selector(dismissWithCompletion:)
                                                                                          withObject:^{
                                                                                              [self.navigationController popViewControllerAnimated:YES];
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
                                                                      case 106:
                                                                      {
                                                                          //101 ckid不能为空
                                                                          //102  用户名不能为空
                                                                          //103 用户名不合法
                                                                          //104 密码不能为空
                                                                          //105 邮箱不能为空
                                                                          //106 您输入的电子邮件地址不合法
                                                                          msg = responseData[KEY_MSG];
                                                                      }
                                                                          break;
                                                                      case 107:
                                                                      {
                                                                          //该用户已经绑定过邮箱
                                                                          msg = [@"该用户已经绑定过邮箱" localizedString];
                                                                      }
                                                                          break;
                                                                      case 108:
                                                                      {
                                                                          //用户名密码不正确，请核对后在填
                                                                          msg = [@"用户名密码不正确，请核对后再填" localizedString];
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
                                                              
                                                              [alertView performSelector:@selector(dismissWithCompletion:) withObject:nil afterDelay:1];
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
                                                                       loadingView.lodingType = JYLoading_bindSuccess;
                                                                       [alertView performSelector:@selector(dismissWithCompletion:)
                                                                                       withObject:^{
                                                                                           [self.navigationController popViewControllerAnimated:YES];
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
                                                                   case 106:
                                                                   {
                                                                       //101 ckid不能为空
                                                                       //102  用户名不能为空
                                                                       //103 用户名不合法
                                                                       //104 密码不能为空
                                                                       //105 邮箱不能为空
                                                                       //106 您输入的电子邮件地址不合法
                                                                       msg = responseData[KEY_MSG];
                                                                   }
                                                                       break;
                                                                   case 107:
                                                                   {
                                                                       //该用户已经绑定过邮箱
                                                                       msg = [@"该用户已经绑定过邮箱" localizedString];
                                                                   }
                                                                       break;
                                                                   case 108:
                                                                   {
                                                                       //用户名密码不正确，请核对后在填
                                                                       msg = [@"用户名密码不正确，请核对后再填" localizedString];
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
                                                           
                                                           [alertView performSelector:@selector(dismissWithCompletion:) withObject:nil afterDelay:1];
                                                           [self showPopText:msg withView:nil];
                                                       }];
        }
    }
}
@end
