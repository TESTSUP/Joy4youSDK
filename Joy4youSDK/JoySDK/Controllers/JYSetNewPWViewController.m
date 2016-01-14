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
        [[JYModelInterface sharedInstance] setNewPasswordWithPhone:self.phone
                                                          password:self.passwordField.text
                                                              mark:self.token
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
                                                                 case 103:
                                                                 {
                                                                     //101 密码不能为空
                                                                     //102 修改失败
                                                                     //103 token校验失败
                                                                     msg = [@"参数错误" localizedString];
                                                                 }
                                                                     break;
                                                                 case 102:
                                                                 {
                                                                     //102 修改失败
                                                                     msg = [@"密码修改失败" localizedString];
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

@end
