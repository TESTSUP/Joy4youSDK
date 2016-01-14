//
//  JYFindPasswordViewController.m
//  Joy4youSDK
//
//  Created by temp on 15/11/24.
//  Copyright (c) 2015年 LeHeng. All rights reserved.
//

#import "JYFindPasswordViewController.h"
#import "JYServiceViewController.h"

@interface JYFindPasswordViewController ()

@end

@implementation JYFindPasswordViewController

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
    self.emailTextField.delegate = self;
    
    _upsideTextField = self.accountTextField;
    _undersideTextField = self.emailTextField;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - button action

- (IBAction)handleFindAction:(id)sender {
    [self hideKeybord];
    
    NSString *nickname = self.accountTextField.text;
    NSString *email = self.emailTextField.text;
    NSString *popText = nil;
    
    if ([nickname length] == 0 || [email length] == 0) {
        popText = [@"账号和邮箱不能为空" localizedString];
    } else if(![email validateEmailAddress]) {
        popText = [@"请填写正确的邮箱地址" localizedString];
    }
    
    if ([popText length] > 0) {
        [self showPopText:popText withView:self.accountBg];;
    } else {
         [self showLoadingViewWith:JYLoading_Sending];
        if ([nickname validatePhoneNumber]) {
            [[JYModelInterface sharedInstance] findPasswordWithPhone:nickname
                                                            andEmail:email
                                                       callbackBlock:^(NSError *error, NSDictionary *responseData) {
                                                           
                                                           NSString * msg = nil;
                                                           if (!error)
                                                           {
                                                               NSString* status = responseData[KEY_STATUS];
                                                               
                                                               switch (status.integerValue) {
                                                                   case 200:
                                                                   {
                                                                       [self showLoadingViewWith:JYLoading_SendSuccess];
                                                                       [self performSelector:@selector(dismissWithCompletion:)
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
                                                                   {
                                                                       //101 ckid不能为空
                                                                       //102 手机号不能为空
                                                                       //103 手机号不合法
                                                                       //104 邮箱不能为空
                                                                       msg = [@"参数错误" localizedString];
                                                                   }
                                                                       break;
                                                                   case 105:
                                                                   {
                                                                       //105 您输入的电子邮件地址不合法
                                                                       msg = [@"请填写正确的邮箱地址" localizedString];
                                                                   }
                                                                       break;
                                                                   case 106:
                                                                   {
                                                                       //106 输入的邮箱与绑定的邮箱不一致
                                                                       msg = [@"您输入的邮箱与绑定邮箱不一致" localizedString];
                                                                   }
                                                                       break;
                                                                   case 107:
                                                                   {
                                                                       //107 该用户没有绑定过邮箱
                                                                       msg = [@"该手机号未绑定邮箱" localizedString];
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
        } else {
            [[JYModelInterface sharedInstance] findPasswordWithUsername:nickname
                                                               andEmail:email
                                                          callbackBlock:^(NSError *error, NSDictionary *responseData) {
                                                              
                                                              NSString * msg = nil;
                                                              if (!error)
                                                              {
                                                                  NSString* status = responseData[KEY_STATUS];
                                                                  
                                                                  switch (status.integerValue) {
                                                                      case 200:
                                                                      {
                                                                          [self showLoadingViewWith:JYLoading_SendSuccess];
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
                                                                      case 103:
                                                                      case 104:
                                                                      {
                                                                          //101 ckid不能为空
                                                                          //102用户名不能为空
                                                                          //103 用户名不合法
                                                                          //104邮箱不能为空
                                                                          
                                                                          msg = [@"参数错误" localizedString];
                                                                      }
                                                                          break;
                                                                      case 105:
                                                                      {
                                                                          //105 您输入的电子邮件地址不合法
                                                                          msg = [@"请填写正确的邮箱地址" localizedString];
                                                                      }
                                                                          break;
                                                                      case 106:
                                                                      {
                                                                          
                                                                          //106 输入的邮箱与绑定的邮箱不一致
                                                                          msg = [@"您输入的邮箱与绑定邮箱不一致" localizedString];
                                                                          
                                                                      }
                                                                          break;
                                                                      case 107:
                                                                      {
                                                                          //107 该用户没有绑定过邮箱
                                                                          msg = [@"该用户名未绑定邮箱" localizedString];
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
}

- (IBAction)handleShowServiceAction:(id)sender {
    JYServiceViewController *serviceVC = [[JYServiceViewController alloc] initWithNibName:@"JYServiceViewController" bundle:[NSBundle resourceBundle]];
    
    [self.navigationController pushViewController:serviceVC animated:YES];
    
}
@end
