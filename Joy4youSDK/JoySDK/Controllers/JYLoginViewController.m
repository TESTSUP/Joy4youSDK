//
//  JYLoginViewController.m
//  Joy4youSDK
//
//  Created by temp on 15/11/24.
//  Copyright (c) 2015年 LeHeng. All rights reserved.
//

#import "JYLoginViewController.h"
#import "JYRegistViewController.h"
#import "JYUtil.h"
#import "JYUserCache.h"

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

- (IBAction)handleRegistAction:(id)sender {
    JYRegistViewController *registVC = [[JYRegistViewController alloc] initWithNibName:@"JYRegistViewController" bundle:[NSBundle resourceBundle]];
    
    [self.navigationController pushViewController:registVC animated:YES];
    
}
@end
