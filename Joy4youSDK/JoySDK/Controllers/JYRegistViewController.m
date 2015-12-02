//
//  JYselfController.m
//  Joy4youSDK
//
//  Created by temp on 15/11/24.
//  Copyright (c) 2015年 LeHeng. All rights reserved.
//

#import "JYRegistviewController.h"
#import "JYAgreementViewController.h"
#import "JYUtil.h"
#import "JYLoadingView.h"
#import "JYModelInterface.h"

@interface JYRegistViewController ()

@end

@implementation JYRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configTextField];
    
    if (_isBind) {
        self.bindButton.hidden = NO;
        self.registBtn.hidden = YES;
    } else {
        self.bindButton.hidden = YES;
        self.registBtn.hidden = NO;
    }
    self.confirmAgreementBtn.selected = YES;
}

- (void)configTextField
{    
    self.usernameTextField.delegate = self;
    self.passwordField.delegate = self;
    
    _upsideTextField = self.usernameTextField;
    _undersideTextField = self.passwordField;
    
    self.upsideLimit = 20;
    self.undersideLimit = 15;
}

- (void)setIsBind:(BOOL)isBind
{
    _isBind = isBind;
    if (isBind) {
        self.bindButton.hidden = NO;
        self.registBtn.hidden = YES;
    } else {
        self.bindButton.hidden = YES;
        self.registBtn.hidden = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)handleShowAgreementAction:(UIButton *)sender {
    JYAgreementViewController *agreementVC = [[JYAgreementViewController alloc] initWithNibName:@"JYAgreementViewController" bundle:[NSBundle resourceBundle]];
    
    [self.navigationController pushViewController:agreementVC animated:YES];
}

- (IBAction)handleShowPasswordAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    BOOL orgFirst = NO;
    if ([self.passwordField isFirstResponder]) {
        [self.passwordField resignFirstResponder];
        orgFirst = YES;
        
    }
    self.passwordField.secureTextEntry = !sender.selected;
    
    if (orgFirst) {
        [self.passwordField becomeFirstResponder];
    }
    
}

- (IBAction)handleConfirmAgreementAction:(UIButton *)sender {
     sender.selected = !sender.selected;
}

- (IBAction)handleRegistAction:(id)sender {
    
    if (!self.confirmAgreementBtn.selected) {
        [self showPopText:[@"请同意《乐恒帐户使用协议》" localizedString] withView:nil];
        self.confirmAgreementBtn.selected = YES;
    }else{
        if ([self.usernameTextField.text length] == 0 || [self.passwordField.text length] == 0) {
            [self showPopText:[@"帐号或密码不能为空" localizedString] withView:self.accountBg];
        }else if ([self.usernameTextField.text length] < 6 || [self.usernameTextField.text length] > 20){
            [self showPopText:[@"帐号为6–20位，请修改" localizedString] withView:self.accountBg];
        }else if ([self.passwordField.text length]<6 || [self.passwordField.text length]>15){
            [self showPopText:[@"密码为6—15位，请修改" localizedString] withView:self.passwordBg];
        }else if (NO == [self.usernameTextField.text validateUserAccount]){
            [self showPopText:[@"帐号为6–20位字母数字组合，可使用“_”" localizedString] withView:self.accountBg];
        }else if (NO == [self.passwordField.text validateUserPassword]){
            [self showPopText:[@"密码必须为6—15位，仅支持英文、数字和符号" localizedString] withView:self.passwordBg];
        }else{
            JYLoadingView *cacheLoading = (JYLoadingView *)[UIView createNibView:@"JYLoadingView"];
            cacheLoading.lodingType = JYLoading_registWithUsername;
            JYAlertView *alertView = [[JYAlertView alloc] initWithCustomView:cacheLoading dismissWhenTouchedBackground:NO];
            [alertView show];
            
            [[JYModelInterface sharedInstance] checkUsername:self.usernameTextField.text
                                               callbackBlock:^(NSError *error, NSDictionary *responseData) {
   
                                                   NSString * msg = nil;
                                                   if (error) {
                                                       JYDLog(@"check username error", error);
                                                       msg = [@"网络状态不好，请稍后重试" localizedString];
                                                       [alertView performSelector:@selector(dismissWithCompletion:) withObject:nil afterDelay:1];
                                                   }
                                                   else {
                                                       NSString* status = responseData[KEY_STATUS];
                                                       
                                                       switch (status.integerValue) {
                                                           case 200:
                                                           {
                                                               [[JYModelInterface sharedInstance] registWithUsername:self.usernameTextField.text
                                                                                                         andPassword:self.passwordField.text
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
                                                               return;
                                                           }
                                                               break;
                                                           case 101:
                                                           case 102:
                                                           case 103:
                                                           {
                                                               //101用户名不能为空
                                                               //102用户名不合法
                                                               //103 ckid不能为空
                                                               msg = responseData[KEY_MSG];
                                                           }
                                                               break;
                                                           case 104:
                                                           {
                                                               //104用户名已存在
                                                               msg = [@"用户名已存在" localizedString];
                                                           }
                                                               break;
                                                           default:
                                                               msg= responseData[KEY_MSG];
                                                               break;
                                                       }
                                                   }
                                                   [alertView performSelector:@selector(dismissWithCompletion:) withObject:nil afterDelay:1];
                                                   [self showPopText:msg withView:nil];
                                               }];
            
        }
        
    }
}

- (IBAction)handleBindAccountAction:(id)sender {
    if (!self.confirmAgreementBtn.selected) {
        [self showPopText:[@"请同意《乐恒帐户使用协议》" localizedString] withView:nil];
        self.confirmAgreementBtn.selected = YES;
    }else{
        if ([self.usernameTextField.text length] == 0 || [self.passwordField.text length] == 0) {
            [self showPopText:[@"帐号或密码不能为空" localizedString] withView:self.accountBg];
        }else if ([self.usernameTextField.text length] < 4 || [self.usernameTextField.text length] > 20){
            [self showPopText:[@"帐号为6–20位，请修改" localizedString] withView:self.accountBg];
        }else if ([self.passwordField.text length]<6 || [self.passwordField.text length]>15){
            [self showPopText:[@"密码为6—15位，请修改" localizedString] withView:self.passwordBg];
        }else if (NO == [self.usernameTextField.text validateUserAccount]){
            [self showPopText:[@"帐号为6–20位字母数字组合，可使用“_”" localizedString] withView:self.accountBg];
        }else if (NO == [self.passwordField.text validateUserPassword]){
            [self showPopText:[@"密码必须为6—15位，仅支持英文、数字和符号" localizedString] withView:self.passwordBg];
        }else{
            JYLoadingView *cacheLoading = (JYLoadingView *)[UIView createNibView:@"JYLoadingView"];
            cacheLoading.lodingType = JYLoading_Binding;
            JYAlertView *alertView = [[JYAlertView alloc] initWithCustomView:cacheLoading dismissWhenTouchedBackground:NO];
            [alertView show];
            
            JYUserContent *user = [[JYUserCache sharedInstance] currentUser];
            [[JYModelInterface sharedInstance] bindAccountWithUsername:self.usernameTextField.text
                                                              password:self.passwordField.text
                                                                userId:user.userid
                                                         callbackBlock:^(NSError *error, NSDictionary *responseData) {
                                                             [alertView performSelector:@selector(dismissWithCompletion:) withObject:nil afterDelay:1];
                                                             
                                                             NSString * msg= [@"绑定失败" localizedString];
                                                             if (error) {
                                                                 JYDLog(@"Tourist login error = %@", error);
                                                                 msg = [@"网络状态不好，请稍后重试" localizedString];
                                                             }
                                                             else {
                                                                 NSString* status = responseData[KEY_STATUS];
                                                                 
                                                                 switch (status.integerValue) {
                                                                     case 200:
                                                                     {
                                                                         cacheLoading.lodingType = JYLoading_bindSuccess;
                                                                         [[NSNotificationCenter defaultCenter] postNotificationName:JYNotificationShowSuccess object:[NSNumber numberWithInteger:JYLoading_bindSuccess]];
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
                                                                     case 108:
                                                                     {
                                                                         //101 用户id不能为空
                                                                         //102 ckid不能为空
                                                                         //103 用户名不能为空
                                                                         //104 用户名不合法
                                                                         //105 密码不能为空
                                                                         //106 该用户已经绑定过
                                                                         //107 查无此用户
                                                                         //108用户名存在，请更换用户名在绑定 （新增）
                                                                         msg = responseData[KEY_MSG];
                                                                     }
                                                                         break;
                                                                     default:
                                                                         msg= [@"绑定失败" localizedString];
                                                                         break;
                                                                 }
                                                             }
                                                             [self showPopText:msg withView:nil];
                                                         }];
        }
    }
}


@end
