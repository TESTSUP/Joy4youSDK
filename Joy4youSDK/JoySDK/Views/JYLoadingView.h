//
//  JYLoadingView.h
//  Joy4youSDK
//
//  Created by 孙永刚 on 15/11/25.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYButton.h"

typedef enum JYLoadingType{
    CCLoading_cacheLogin = 0,
    CCLoading_registWithUsername = 1,
    CCLoading_registWithUsernameResult = 2,
    CCLoading_loginWithUsername = 3,
    CCLoading_loginWithUsernameResult = 4,
    CCLoading_registWithPhoneGetCode = 5,
    CCLoading_registWithOneKey = 6,
    CCLoading_registWithPhone = 7,
    CCLoading_setNewPassword = 8,
    CCLoading_forgetPWSetPassword = 9,
    CCLoading_forgetSetPWLogin = 10,
    CCLoading_registPWSetPassword = 11,
    CCLoading_registPWSetPasswordLogin = 12,
    CCLoading_guestLogin = 13,
    CCLoading_bindEmail = 14,
    CCLoading_bindSuccess = 15,
    CCLoading_SendSuccess = 16,
    CCLoading_SendEmail = 17,
    CCLoading_Binding = 18,
    CCLoading_UserBind = 19,
    CCLoading_PhoneBind = 20
    
    
}JYLoadingType;


@interface JYLoadingView : UIView


@property (nonatomic, assign) JYLoadingType lodingType;

@property (nonatomic, strong) IBOutlet JYButton *switchBtn;

@property (nonatomic, strong) NSString *title;

@end
