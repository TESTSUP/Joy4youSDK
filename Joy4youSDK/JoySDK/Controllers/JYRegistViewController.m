//
//  JYRegistViewController.m
//  Joy4youSDK
//
//  Created by temp on 15/11/24.
//  Copyright (c) 2015年 LeHeng. All rights reserved.
//

#import "JYRegistViewController.h"
#import "JYUtil.h"

@interface JYRegistViewController ()

@end

@implementation JYRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configTextField];
}

- (void)configTextField
{    
    self.usernameTextField.delegate = self;
    self.passwordField.delegate = self;
    
    _upsideTextField = self.usernameTextField;
    _undersideTextField = self.passwordField;
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
}

- (IBAction)handleShowPasswordAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    
}

- (IBAction)handleConfirmAgreementAction:(UIButton *)sender {
     sender.selected = !sender.selected;
}

- (IBAction)handleRegistAction:(id)sender {
}
@end
