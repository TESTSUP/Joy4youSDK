//
//  JYPhoneRegistViewController.h
//  Joy4youSDK
//
//  Created by joy4you on 15/12/22.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import "JYViewController.h"

@interface JYPhoneRegistViewController : JYViewController

@property (weak, nonatomic) IBOutlet UIImageView *phoneBg;
@property (weak, nonatomic) IBOutlet UIImageView *codeBg;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet JYButton *codeButton;
@property (weak, nonatomic) IBOutlet UITextField *codeField;
@property (weak, nonatomic) IBOutlet UIButton *confirmAgreementBtn;
@property (weak, nonatomic) IBOutlet UIButton *showAgreementBtn;
@property (weak, nonatomic) IBOutlet JYButton *VerifyBtn;
@property (weak, nonatomic) IBOutlet JYButton *accountRegistBtn;

@end

