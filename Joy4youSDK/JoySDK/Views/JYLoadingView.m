//
//  JYLoadingView.m
//  Joy4youSDK
//
//  Created by 孙永刚 on 15/11/25.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import "JYLoadingView.h"
#import "JYUtil.h"

#define CC_ANIMATION_KEY @"rotation_key"
#define CC_LOADING_HEIGHT 67;


@interface JYLoadingView ()
{
    CGFloat _defaultHeight;
}

@property (nonatomic, assign) BOOL loading;

@property (nonatomic, assign) BOOL showButton;



@property (nonatomic, strong) NSString *detail;

@property (nonatomic, strong) IBOutlet UIImageView *circleView;
@property (nonatomic, strong) IBOutlet UIImageView *centerView;
@property (nonatomic, strong) IBOutlet UILabel *mainLabel;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *detailLabel;

@end


@implementation JYLoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    self.loading = YES;
    self.layer.cornerRadius = CC_CORNERRADIUS;
    self.switchBtn.btnType = JYButtonType_Blue;
    _defaultHeight = self.frame.size.height;
    self.showButton = NO;
}

- (void)rotateAnimation:(BOOL)aRotate
{
    if (aRotate) {
        CABasicAnimation* rotationAnimation;
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
        rotationAnimation.duration = 1;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = HUGE;
        [self.circleView.layer addAnimation:rotationAnimation forKey:CC_ANIMATION_KEY];
    }
    else {
        [self.circleView.layer removeAnimationForKey:CC_ANIMATION_KEY];
    }
    
}

- (void)showMainLabel:(BOOL)aShow
{
    self.mainLabel.hidden = !aShow;
    self.titleLabel.hidden =aShow;
    self.detailLabel.hidden = aShow;
}

#pragma mark public -

- (void)setLoading:(BOOL)aLoading
{
    if (_loading != aLoading) {
        if (aLoading) {
            self.circleView.image = [UIImage imageNamedFromBundle:@"loading_circle_half.png"];
            self.centerView.image = [UIImage imageNamedFromBundle:@"loading_logo.png"];
        } else {
            self.circleView.image = [UIImage imageNamedFromBundle:@"loading_circle_full.png"];
            self.centerView.image = [UIImage imageNamedFromBundle:@"loading_success.png"];
        }
        
        _loading = aLoading;
        [self rotateAnimation:_loading];
    }
}

- (void)setTitle:(NSString *)aTitle
{
    if (_detail) {
        self.titleLabel.text = aTitle;
        self.detailLabel.text = _detail;
        [self showMainLabel:NO];
    } else {
        self.mainLabel.text = aTitle;
        [self showMainLabel:YES];
    }
    
    _title = aTitle;
}

- (void)setDetail:(NSString *)aDetail
{
    if (_title) {
        self.detailLabel.text = aDetail;
        self.titleLabel.text = _title;
        [self showMainLabel:NO];
    } else {
        self.mainLabel.text = aDetail;
        [self showMainLabel:YES];
    }
    
    _detail = aDetail;
}

- (void)setShowButton:(BOOL)aShowButton
{
    CGFloat height = aShowButton? _defaultHeight:CC_LOADING_HEIGHT;
    self.switchBtn.hidden = !aShowButton;
    
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            self.frame.size.width,
                            height);
}

- (void)setLodingType:(JYLoadingType)aLodingType
{
    switch (aLodingType) {
        case CCLoading_cacheLogin:
        {
            self.showButton = YES;
            self.loading = YES;
            self.detail = [@"正在登录..." localizedString];
        }
            break;
        case CCLoading_registWithUsername:
        {
            self.showButton = NO;
            self.loading = YES;
            self.title = [@"正在注册..." localizedString];
        }
            break;
        case CCLoading_registWithUsernameResult:
        {
            self.showButton = NO;
            self.loading = NO;
            self.detail = [@"注册成功" localizedString];
        }
            break;
        case CCLoading_loginWithUsername:
        {
            self.showButton = NO;
            self.loading = YES;
            self.detail = [@"正在登录..." localizedString];
        }
            break;
        case CCLoading_guestLogin:
        {
            self.showButton = NO;
            self.loading = YES;
            self.title = [@"游客登录中..." localizedString];
        }
            break;
        case CCLoading_loginWithUsernameResult:
        {
            self.showButton = NO;
            self.loading = NO;
            self.detail = [@"登录成功" localizedString];
        }
            break;
        case CCLoading_registWithPhoneGetCode:
        {
            self.showButton = NO;
            self.loading = YES;
            self.detail = [@"正在验证..." localizedString];
        }
            break;
        case CCLoading_registWithOneKey:
        {
            self.showButton = NO;
            self.loading = YES;
            self.detail = [@"正在注册..." localizedString];
        }
            break;
        case CCLoading_registWithPhone:
        {
            self.showButton = NO;
            self.loading = YES;
            self.detail = [@"正在创建帐号" localizedString];
        }
            break;
        case CCLoading_setNewPassword:
        {
            self.showButton = NO;
            self.loading = YES;
            self.title = [@"请稍后..." localizedString];
        }
            break;
        case CCLoading_forgetPWSetPassword:
        {
            self.showButton = NO;
            self.loading = YES;
            self.title = [@"正在重设密码" localizedString];
        }
            break;
        case CCLoading_forgetSetPWLogin:
        {
            self.showButton = NO;
            self.loading = YES;
            self.title = [@"密码重设成功" localizedString];
            self.detail = [@"正在登录" localizedString];
        }
            break;
        case CCLoading_registPWSetPassword:
        {
            self.showButton = NO;
            self.loading = YES;
            self.title = [@"正在设定密码" localizedString];
        }
            break;
        case CCLoading_registPWSetPasswordLogin:
        {
            self.showButton = NO;
            self.loading = YES;
            self.title = [@"密码设置成功" localizedString];
            self.detail = [@"正在登录" localizedString];
        }
            break;
        case CCLoading_Binding:
        case CCLoading_bindEmail:
        {
            self.showButton = NO;
            self.loading = YES;
            self.title = [@"正在绑定" localizedString];
        }
            break;
        case CCLoading_UserBind:
        case CCLoading_bindSuccess:
        {
            self.showButton = NO;
            self.loading = NO;
            self.detail = [@"绑定成功" localizedString];
        }
            break;
        case CCLoading_SendSuccess:
        {
            self.showButton = NO;
            self.loading = NO;
            self.title = [@"密码重设邮件已发送,请查收" localizedString];
            //            self.mainLabel.adjustsFontSizeToFitWidth = YES;
            self.mainLabel.font = [UIFont systemFontOfSize:15];
        }
            break;
        case CCLoading_SendEmail:
        {
            self.showButton = NO;
            self.loading = YES;
            self.title = [@"正在发送" localizedString];
        }
            break;
        case CCLoading_PhoneBind:
        {
            self.showButton = NO;
            self.loading = NO;
            self.detailLabel.font = [UIFont systemFontOfSize:13];
            self.detail = [@"绑定成功,下次请使用该帐号登录" localizedString];
        }
            break;
        default:
            break;
    }
    
    _lodingType = aLodingType;
}

@end
