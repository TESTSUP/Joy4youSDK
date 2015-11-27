//
//  JYViewController.m
//  Joy4youSDK
//
//  Created by 孙永刚 on 15/11/25.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import "JYViewController.h"
#import "UIView+JYView.h"
#import "JYPopView.h"
#import "NSBundle+JYBundle.h"

NSString *const JYNotificationCloseSDK = @"joy4you_notification_closeSDK";
NSString *const JYNotificationShowSuccess = @"joy4you_notification_login_success";
NSString *const JYNotificationRemoveView = @"joy4you_notification_view_remove";
NSString *const JYNotificationHideKeybord = @"joy4you_notification_hideKeybord";

@interface JYViewController ()
{
    JYPopView *_popView;
    NSTimer *_showTimer;
    NSInteger _count;
    BOOL _isShowPop;
}

@end

@implementation JYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.layer.cornerRadius = CC_CORNERRADIUS;
    self.view.center = self.view.superview.center;
    
    [self addObservers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

- (CGPoint)mainViewCenter
{
    return CGPointMake(self.navigationController.view.superview.bounds.size.width/2,
                       self.navigationController.view.superview.bounds.size.height/2);
}

- (void)addObservers
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPad) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
    }
}

- (IBAction)handleBackAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)handleClose
{
    [[NSNotificationCenter defaultCenter] postNotificationName:JYNotificationCloseSDK object:nil];
}

- (void)handleTap
{
    [self hideKeybord];
}

#pragma mark - popview

- (void)popViewDisplayAnimation:(BOOL)aShow;
{
    if (_isShowPop == aShow) {
        return;
    }
    
    if (aShow)
    {
        _popView.alpha = 0.0;
        [self.view addSubview:_popView];
        
        [UIView animateWithDuration:0.3
                         animations:^{
                             _popView.alpha = 1.0;
                         }];
    }
    else
    {
        [UIView animateWithDuration:0.3
                         animations:^{
                             _popView.alpha = 0.0;
                         } completion:^(BOOL finished) {
                             [_popView removeFromSuperview];
                         }];
    }
    
    _isShowPop = aShow;
}

- (void)showPopText:(NSString *)aText withView:(UIView *)aView
{
    if (!_popView) {
        _popView = (JYPopView *)[UIView createNibView:@"CCPopupView"];
    }
    _popView.popText = aText;
    
    CGRect rect = CGRectZero;
    if (aView) {
        rect = CGRectMake(aView.frame.origin.x,
                          aView.frame.origin.y-_popView.frame.size.height,
                          _popView.frame.size.width,
                          _popView.frame.size.height);
    }
    else
    {
        rect = CGRectMake((self.view.frame.size.width - _popView.frame.size.width)/2,
                          self.view.frame.size.height- _popView.frame.size.height,
                          _popView.frame.size.width,
                          _popView.frame.size.height);
    }
    _popView.frame = rect;
    
    if (_showTimer) {
        [_showTimer invalidate];
        _showTimer = nil;
    }
    [self popViewDisplayAnimation:YES];
    
    _count = 5;
    _showTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(displayCount)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)displayCount
{
    NSLog(@"count --");
    _count--;
    if (0 == _count)
    {
        [self popViewDisplayAnimation:NO];
        [_showTimer invalidate];
        _showTimer = nil;
    }
}

#pragma mark - keybord

- (void)hideKeybord
{
    [_actionTextField resignFirstResponder];
    _actionTextField = nil;
}

- (void)keyboardWillAppear:(NSNotification *)aNotify
{
    _keyBordRect = [[aNotify.userInfo objectForKey:@"UIKeyboardBoundsUserInfoKey"] CGRectValue];
    
    [self configViewPointWithKeybord];
}

- (void)keyboardWillDisappear:(NSNotification *)aNotify
{
    _keyBordRect = CGRectZero;
    
    [self configViewPointWithKeybord];
}

//解决所有界面键盘遮盖问题
- (void)configViewPointWithKeybord
{
    [UIView animateWithDuration:0.25
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         if (CGRectEqualToRect(_keyBordRect, CGRectZero)) {
                             self.navigationController.view.center = [self mainViewCenter];
                         }
                         else
                         {
                             CGSize orgSize = self.navigationController.view.superview.bounds.size;
                             CGFloat height = _actionTextField.frame.size.height;
                             CGFloat newY = (orgSize.height - _keyBordRect.size.height) - height-10;
                             CGPoint oldPoint = [self.navigationController.view.superview convertPoint:_actionTextField.frame.origin fromView:self.view];
                             CGFloat length = oldPoint.y -newY;
                             if (length > 0) {
                                 self.navigationController.view.center = CGPointMake(self.navigationController.view.center.x,
                                                                              self.navigationController.view.center.y - length);
                             }
                         }
                     } completion:^(BOOL finished) {
                         
                     }];
}


#pragma mark - UITextFieldDelegate

- (NSUInteger)getLimitLengthWith:(UITextField *)aTextField
{
    
    return 10;
    
//    NSUInteger length = NSUIntegerMax;
//    
//    if ([_surfaceActionView isKindOfClass:[CCRegistWithUsernameView class]])
//    {
//        if (aTextField == _upsideTextField)
//        {
//            length = CC_ACCLOUNT_LIMIT;
//        }
//        else
//        {
//            length = CC_PW_LIMIT;
//        }
//    }
//    else if ([_surfaceActionView isKindOfClass:[CCForgetPhdCheckPhoneView class]])
//    {
//        CCForgetPhdCheckPhoneView *tempView = (CCForgetPhdCheckPhoneView *)_surfaceActionView;
//        if (tempView.phdCodeField == aTextField)
//        {
//            length = CC_VCODE_LIMIT;
//        }
//    }
//    
//    return length;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _actionTextField = textField;
    
    [self configViewPointWithKeybord];
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUInteger limitLength = [self getLimitLengthWith:textField];

    if ([textField.text length] >= limitLength && ![string isEqualToString:@""])
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (_undersideTextField &&
        _undersideTextField != _actionTextField) {
        [_undersideTextField becomeFirstResponder];
        _actionTextField = _undersideTextField;
    }
    else
    {
        [_actionTextField resignFirstResponder];
        _actionTextField = nil;
    }
    
    return YES;
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
