//
//  JYSetNewPWViewController.h
//  Joy4youSDK
//
//  Created by joy4you on 15/12/24.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import "JYViewController.h"

@interface JYSetNewPWViewController : JYViewController

@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *token;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIImageView *passwordBg;
@property (weak, nonatomic) IBOutlet JYButton *confirmBtn;

@end
