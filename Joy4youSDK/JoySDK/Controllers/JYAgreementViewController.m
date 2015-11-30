//
//  JYAgreementViewController.m
//  Joy4youSDK
//
//  Created by joy4you on 15/11/30.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import "JYAgreementViewController.h"

@interface JYAgreementViewController ()

@end

@implementation JYAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *path = [[NSBundle resourceBundle] pathForResource:@"license" ofType:@"html"];
    NSString *htmlStr = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:nil];
    
    self.license.backgroundColor = [UIColor clearColor];
    [self.license loadHTMLString:htmlStr baseURL:nil];
    [self.license setOpaque:NO];
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

@end
