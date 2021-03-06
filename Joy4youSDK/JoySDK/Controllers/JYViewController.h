//
//  JYViewController.h
//  Joy4youSDK
//
//  Created by 孙永刚 on 15/11/25.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYLoadingView.h"
#import "JYModelInterface.h"
#import "JYUtil.h"

extern NSString *const JYNotificationCloseSDK;
extern NSString *const JYNotificationShowSuccess;
extern NSString *const JYNotificationRemoveView;
extern NSString *const JYNotificationHideKeybord;

/**
 *  视图controller父类
 */
@interface JYViewController : UIViewController <UITextFieldDelegate>
{
    UITextField *_actionTextField;
    __weak UITextField *_upsideTextField;
    __weak UITextField *_undersideTextField;
    __weak UITextField *_bottomTextField;
    CGRect _keyBordRect;
    CGRect _orgFrame;
    
}

@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property (nonatomic, assign) NSInteger upsideLimit;

@property (nonatomic, assign) NSInteger undersideLimit;

//隐藏键盘
- (void)hideKeybord;

//导航栏关闭按钮事件
- (void)handleClose;

//导航栏返回按钮事件
- (IBAction)handleBackAction:(id)sender;

/**
 *  显示错误提示
 *
 *  @param aText 文字
 *  @param aView 所显示在的UIView
 */
- (void)showPopText:(NSString *)aText withView:(UIView *)aView;

/**
 *  显示loading框
 *
 *  @param aType <#aType description#>
 */
- (void)showLoadingViewWith:(JYLoadingType)aType;

/**
 *  隐藏loading框
 *
 *  @param completion <#completion description#>
 */
- (void)dismissWithCompletion:(void(^)(void))completion;

@end

