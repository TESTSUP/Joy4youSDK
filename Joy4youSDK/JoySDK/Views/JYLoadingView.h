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
    JYLoading_cacheLogin = 0,
    JYLoading_guestLogin = 1,
    JYLoading_loginWithUsername = 2,
    JYLoading_loginWithUsernameSuccess = 3,
    JYLoading_registWithUsername = 4,
    JYLoading_registWithUsernameSuccess = 5,
    JYLoading_Sending = 6,
    JYLoading_SendSuccess = 7,
    JYLoading_bindSuccess = 8,
    JYLoading_Binding = 9,
    JYLoading_GetCode = 10,
    JYLoading_VerifyCode = 11,
    JYLoading_Setting = 12
    
}JYLoadingType;


@interface JYLoadingView : UIView


@property (nonatomic, assign) JYLoadingType lodingType;

@property (nonatomic, strong) IBOutlet JYButton *switchBtn;

@property (nonatomic, strong) NSString *title;

@end
