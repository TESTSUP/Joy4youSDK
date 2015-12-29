//
//  JYSetNewPWViewController.m
//  Joy4youSDK
//
//  Created by joy4you on 15/12/24.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import "JYSetNewPWViewController.h"
#import "NSString+JYString.h"

@implementation JYSetNewPWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.passwordField.delegate = self;
    _upsideTextField = self.passwordField;
    self.upsideLimit = 15;
}

- (IBAction)handleConfirmAction:(id)sender {
    if ([self.passwordField.text length]<6 || [self.passwordField.text length]>15){
        [self showPopText:[@"密码为6—15位，请修改" localizedString] withView:self.passwordBg];
    } else if (NO == [self.passwordField.text validateUserPassword]){
        [self showPopText:[@"密码必须为6—15位，仅支持英文、数字和符号" localizedString] withView:self.passwordBg];
    } else {
        [self showLoadingViewWith:JYLoading_Setting];
        [[JYModelInterface sharedInstance] setNewPassword:self.passwordField.text
                                            callbackBlock:^(NSError *error, NSDictionary *responseData) {
                                                
                                                NSString * msg = nil;
                                                if (!error)
                                                {
                                                    NSString* status = responseData[KEY_STATUS];
                                                    
                                                    switch (status.integerValue) {
                                                        case 200:
                                                        {
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
                                                
                                                [self performSelector:@selector(dismissWithCompletion:)
                                                                withObject:nil
                                                                afterDelay:1];
                                                [self showPopText:msg withView:nil];
                                            }];
    }
}

@end
