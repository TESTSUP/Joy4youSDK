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
    JYLoading_guestLogin = 13,
    JYLoading_loginWithUsername = 3,
    JYLoading_loginWithUsernameSuccess = 4,
    JYLoading_registWithUsername = 1,
    JYLoading_registWithUsernameSuccess = 2,
    JYLoading_Sending = 17,
    JYLoading_SendSuccess = 16,
    JYLoading_bindSuccess = 15,
    JYLoading_Binding = 18,
    
    
    
}JYLoadingType;


@interface JYLoadingView : UIView


@property (nonatomic, assign) JYLoadingType lodingType;

@property (nonatomic, strong) IBOutlet JYButton *switchBtn;

@property (nonatomic, strong) NSString *title;

@end
