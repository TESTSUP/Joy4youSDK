//
//  JYLoginViewController.h
//  Joy4youSDK
//
//  Created by temp on 15/11/24.
//  Copyright (c) 2015年 LeHeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYViewController.h"

@interface JYLoginViewController : JYViewController

@property (weak, nonatomic) IBOutlet UIButton *registButton;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *findPasswordBtn;
@property (weak, nonatomic) IBOutlet UIButton *touristLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;


- (IBAction)handleRegistAction:(id)sender;

@end
