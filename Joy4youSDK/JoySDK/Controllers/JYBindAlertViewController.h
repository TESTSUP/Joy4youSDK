//
//  JYBindAlertViewController.h
//  Joy4youSDK
//
//  Created by joy4you on 15/11/27.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import "JYViewController.h"

@interface JYBindAlertViewController : JYViewController

@property (weak, nonatomic) IBOutlet UIButton *registButton;

@property (weak, nonatomic) IBOutlet UIButton *touristButton;


- (IBAction)handleRegistAction:(id)sender;

- (IBAction)handleTouristAction:(id)sender;

@end
