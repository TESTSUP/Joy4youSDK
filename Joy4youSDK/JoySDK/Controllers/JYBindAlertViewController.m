//
//  JYBindAlertViewController.m
//  Joy4youSDK
//
//  Created by joy4you on 15/11/27.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import "JYBindAlertViewController.h"
#import "JYPhoneRegistViewController.h"
#import "NSBundle+JYBundle.h"

@implementation JYBindAlertViewController

- (IBAction)handleRegistAction:(id)sender {
    JYPhoneRegistViewController *registVC = [[JYPhoneRegistViewController alloc] initWithNibName:@"JYPhoneRegistViewController" bundle:[NSBundle resourceBundle]];
    registVC.isBind = YES;
    [self.navigationController pushViewController:registVC animated:YES];
}

- (IBAction)handleTouristAction:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:JYNotificationRemoveView object:nil];
}
@end
