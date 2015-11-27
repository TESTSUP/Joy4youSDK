//
//  JYLoginViewController.m
//  Joy4youSDK
//
//  Created by temp on 15/11/24.
//  Copyright (c) 2015年 LeHeng. All rights reserved.
//

#import "JYLoginViewController.h"
#import "JYRegistViewController.h"
#import "JYBindEmailViewController.h"
#import "JYFindPasswordViewController.h"
#import "JYUtil.h"
#import "JYUserCache.h"
#import "JYModelInterface.h"
#import "JYLoadingView.h"
#import "JYAlertView.h"

@interface JYLoginViewController ()

@end

@implementation JYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self configTextField];
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
    
    if ([[JYUserCache sharedInstance].normalUserList count])
    {
        UIButton *cacheBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
        [cacheBtn setImage:[UIImage imageNamedFromBundle:@"jy_login_pulldown_btn.png"] forState:UIControlStateNormal];
        [cacheBtn addTarget:self action:@selector(handleShowCacheUser) forControlEvents:UIControlEventTouchUpInside];
        self.accountTextField.rightView = cacheBtn;
        self.accountTextField.rightViewMode = UITextFieldViewModeAlways;
    }
}

- (void)handleShowCacheUser
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    return YES;
}

 -(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator
{
    self.view.center = self.view.superview.center;
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

- (IBAction)handleRegistAction:(id)sender
{
    JYRegistViewController *registVC = [[JYRegistViewController alloc] initWithNibName:@"JYRegistViewController" bundle:[NSBundle resourceBundle]];
    
    [self.navigationController pushViewController:registVC animated:YES];
    
}

- (IBAction)handleBindEmailACion:(id)sender
{
    JYBindEmailViewController *registVC = [[JYBindEmailViewController alloc] initWithNibName:@"JYBindEmailViewController" bundle:[NSBundle resourceBundle]];
    
    [self.navigationController pushViewController:registVC animated:YES];
}

- (IBAction)handleFindPasswordAction:(id)sender
{
    JYFindPasswordViewController *registVC = [[JYFindPasswordViewController alloc] initWithNibName:@"JYFindPasswordViewController" bundle:[NSBundle resourceBundle]];
    
    [self.navigationController pushViewController:registVC animated:YES];
    
}

- (IBAction)handleTouristLoginAction:(id)sender {
    
    JYUserContent *cacheUser = [[JYUserCache sharedInstance] currentUser];
    JYLoadingView *cacheLoading = (JYLoadingView *)[UIView createNibView:@"JYLoadingView"];
    cacheLoading.lodingType = CCLoading_cacheLogin;
    cacheLoading.title = [NSString stringWithFormat:@"%@ %@", [@"coco帐号" localizedString], [cacheUser.username length]==0? cacheUser.phone:cacheUser.username];
    
    JYAlertView *alertView = [[JYAlertView alloc] initWithCustomView:cacheLoading dismissWhenTouchedBackground:NO];
    [alertView show];
    
    [[JYModelInterface sharedInstance] touristLoginWithCallbackBlcok:^(NSError *error, NSDictionary *responseData) {
        
    }];
}

- (IBAction)handleLoginAction:(id)sender
{
    
    
}


@end
