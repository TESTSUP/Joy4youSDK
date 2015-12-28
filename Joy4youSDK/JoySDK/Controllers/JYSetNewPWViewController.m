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
                                                
                                            }];
    }
}

@end
