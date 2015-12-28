//
//  JYFindPWByPhoneViewController.h
//  Joy4youSDK
//
//  Created by joy4you on 15/12/24.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import "JYViewController.h"

@interface JYFindPWByPhoneViewController : JYViewController

@property (weak, nonatomic) IBOutlet UIImageView *accountBG;
@property (weak, nonatomic) IBOutlet UIImageView *codeBg;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *codeField;
@property (weak, nonatomic) IBOutlet JYButton *verifyButton;
@property (weak, nonatomic) IBOutlet JYButton *showServiceBtn;
@property (weak, nonatomic) IBOutlet JYButton *codeButton;
@property (weak, nonatomic) IBOutlet UIButton *showEmailBtn;


- (IBAction)handleVerifyCodeACtion:(id)sender;

- (IBAction)handleShowServiceAction:(id)sender;

- (IBAction)handleGetCodeAction:(id)sender;

- (IBAction)handleShowEmail:(id)sender;

@end
