//
//  JYRegistViewController.h
//  Joy4youSDK
//
//  Created by temp on 15/11/24.
//  Copyright (c) 2015年 LeHeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYViewController.h"
#import "JYButton.h"

@interface JYRegistViewController : JYViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *showPasswordBtn;
@property (weak, nonatomic) IBOutlet UILabel *confirmAgreementBtn;
@property (weak, nonatomic) IBOutlet UIButton *showAgreementBtn;
@property (weak, nonatomic) IBOutlet JYButton *registBtn;

- (IBAction)handleShowAgreementAction:(id)sender;

- (IBAction)handleShowPasswordAction:(id)sender;

- (IBAction)handleConfirmAgreementAction:(id)sender;

- (IBAction)handleRegistAction:(id)sender;

@end
