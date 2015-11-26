//
//  JYViewController.h
//  Joy4youSDK
//
//  Created by 孙永刚 on 15/11/25.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const JYNotificationCloseSDK;
extern NSString *const JYNotificationShowSuccess;
extern NSString *const JYNotificationRemoveView;
extern NSString *const JYNotificationHideKeybord;

/**
 *  视图controller父类
 */
@interface JYViewController : UIViewController <UITextFieldDelegate>
{
    __weak UITextField *_actionTextField;
    __weak UITextField *_upsideTextField;
    __weak UITextField *_undersideTextField;
    CGRect _keyBordRect;
    CGRect _orgFrame;
    
}

@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property (nonatomic, assign) NSInteger upsideLimit;

@property (nonatomic, assign) NSInteger undersideLimit;

- (void)hideKeybord;    //隐藏键盘

- (void)handleBack;     //导航栏返回按钮事件

- (void)handleClose;    //导航栏关闭按钮事件

- (IBAction)handleBackAction:(id)sender;

@end

