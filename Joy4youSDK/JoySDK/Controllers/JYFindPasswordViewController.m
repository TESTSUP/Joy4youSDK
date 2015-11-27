//
//  JYFindPasswordViewController.m
//  Joy4youSDK
//
//  Created by temp on 15/11/24.
//  Copyright (c) 2015年 LeHeng. All rights reserved.
//

#import "JYFindPasswordViewController.h"
#import "JYServiceViewController.h"
#import "NSBundle+JYBundle.h"

@interface JYFindPasswordViewController ()

@end

@implementation JYFindPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)handleFindAction:(id)sender {
}

- (IBAction)handleShowServiceAction:(id)sender {
    JYServiceViewController *serviceVC = [[JYServiceViewController alloc] initWithNibName:@"JYServiceViewController" bundle:[NSBundle resourceBundle]];
    
    [self.navigationController pushViewController:serviceVC animated:YES];
    
}
@end
