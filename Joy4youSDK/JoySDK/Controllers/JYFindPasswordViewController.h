//
//  JYFindPasswordViewController.h
//  Joy4youSDK
//
//  Created by temp on 15/11/24.
//  Copyright (c) 2015年 LeHeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYViewController.h"

@interface JYFindPasswordViewController : JYViewController

@property (weak, nonatomic) IBOutlet UIImageView *accountBg;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

- (IBAction)handleFindAction:(id)sender;

- (IBAction)handleShowServiceAction:(id)sender;

@end
