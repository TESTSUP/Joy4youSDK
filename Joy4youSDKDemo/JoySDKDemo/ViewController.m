//
//  ViewController.m
//  JoySDKDemo
//
//  Created by 孙永刚 on 15/11/16.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import "ViewController.h"
#import "Joy4youSDK.h"

@interface ViewController ()<Joy4youCallback>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (IBAction)handleLogin:(id)sender {
    
    [Joy4youSDK login:self];
//    [Joy4youSDK setLogEnabled:NO];
}

- (IBAction)handleCreateRole:(id)sender {
    [Joy4youSDK onCreateRole:@"角色"];
}

- (IBAction)handlePayAction:(id)sender {
    NSString *time = [NSString stringWithFormat:@"%@", [NSDate date]];
    [Joy4youSDK onPay:@"user" withOrderId:time withAmount:600 withCurrencyType:@"CNY" withPayType:@"AliPay"];
}

- (NSDateFormatter *)dateFormatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale autoupdatingCurrentLocale];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return dateFormatter;
}

#pragma mark - Joy4youCallback
//回调实现
- (void)loginCallback:(NSDictionary *)jsonDic
{
//    NSString *newLog = [NSString stringWithFormat:@"\n%@", jsonDic];
//    
//    self.logView.text = [self.logView.text stringByAppendingString:newLog];
    
    NSString *dateStr = [[self dateFormatter] stringFromDate:[NSDate date]];
    NSString *text = [dateStr stringByAppendingString:[NSString stringWithFormat:@"\n%@\n\n", jsonDic]];
    text = [text stringByAppendingString:_logView.text];
    self.logView.text = text;
}

@end
