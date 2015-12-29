// About me
// GitHub: https://github.com/HJaycee/JCAlertView
// Blog: http://blog.csdn.net/hjaycee
// Email: hjaycee@163.com (Feel free to connect me)

// About you
// Add "Accelerate.frameWork" first in your project otherwise error!

#import <UIKit/UIKit.h>

// maybe useful
UIKIT_EXTERN NSString *const JYAlertViewWillShowNotification;

typedef void(^clickHandle)(void);

typedef void(^clickHandleWithIndex)(NSInteger index);

typedef NS_ENUM(NSInteger, JYAlertViewButtonType) {
    JYAlertViewButtonTypeDefault = 0,
    JYAlertViewButtonTypeCancel,
    JYAlertViewButtonTypeWarn
};

@interface JYAlertView : UIView

@property (nonatomic, strong) UIView *customView;

// ------------------------Show AlertView with title and message----------------------

// show alertView with 1 button
+ (void)showOneButtonWithTitle:(NSString *)title Message:(NSString *)message ButtonType:(JYAlertViewButtonType)buttonType ButtonTitle:(NSString *)buttonTitle Click:(clickHandle)click;

// show alertView with 2 buttons
+ (void)showTwoButtonsWithTitle:(NSString *)title Message:(NSString *)message ButtonType:(JYAlertViewButtonType)buttonType ButtonTitle:(NSString *)buttonTitle Click:(clickHandle)click ButtonType:(JYAlertViewButtonType)buttonType ButtonTitle:(NSString *)buttonType Click:(clickHandle)click;

// show alertView with greater than or equal to 3 buttons
// parameter of 'buttons' , pass by NSDictionary like @{JYAlertViewButtonTypeDefault : @"ok"}
+ (void)showMultipleButtonsWithTitle:(NSString *)title Message:(NSString *)message Click:(clickHandleWithIndex)click Buttons:(NSDictionary *)buttons,... NS_REQUIRES_NIL_TERMINATION;

// ------------------------Show AlertView with customView-----------------------------

// create a alertView with customView.
// 'dismissWhenTouchBackground' : If you don't want to add a button on customView to call 'dismiss' method manually, set this property to 'YES'.
- (instancetype)initWithCustomView:(UIView *)customView dismissWhenTouchedBackground:(BOOL)dismissWhenTouchBackground;

- (void)show;

// alert will resign keywindow in the completion.
- (void)dismissWithCompletion:(void(^)(void))completion;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com