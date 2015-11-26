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

@interface JYLoginViewController ()

@end

@implementation JYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleHeight;
    
    self.view.center = self.view.superview.center;
    
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
