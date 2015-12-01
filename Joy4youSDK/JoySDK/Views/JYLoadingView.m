//
//  JYLoadingView.m
//  Joy4youSDK
//
//  Created by 孙永刚 on 15/11/25.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import "JYLoadingView.h"
#import "JYUtil.h"
#import "JYUserCache.h"

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
//            self.centerView.image = [UIImage imageNamedFromBundle:@"loading_logo.png"];
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
    JYUserContent *userInfo = [[JYUserCache sharedInstance] currentUser];
    NSString *username = userInfo.type == 2? @"游客":userInfo.username;
    NSString *title = [NSString stringWithFormat:@"账号：%@", username];
    
    switch (aLodingType) {
        case JYLoading_cacheLogin:
        {
            self.showButton = YES;
            self.loading = YES;
            self.detail = [@"正在登录..." localizedString];
        }
            break;
        case JYLoading_guestLogin:
        {
            self.showButton = NO;
            self.loading = YES;
            self.title = [@"游客登录中..." localizedString];
        }
            break;
        case JYLoading_registWithUsername:
        {
            self.showButton = NO;
            self.loading = YES;
            self.title = [@"正在注册..." localizedString];
        }
            break;
        case JYLoading_registWithUsernameSuccess:
        {
            self.showButton = NO;
            self.loading = NO;
            self.title = title;
            self.detail = [@"注册成功" localizedString];
        }
            break;
        case JYLoading_loginWithUsername:
        {
            self.showButton = NO;
            self.loading = YES;
            self.detail = [@"正在登录..." localizedString];
        }
            break;
        case JYLoading_loginWithUsernameSuccess:
        {
            self.showButton = NO;
            self.loading = NO;
            self.title = title;
            self.detail = [@"登录成功" localizedString];
        }
            break;
        case JYLoading_Binding:
        {
            self.showButton = NO;
            self.loading = YES;
            self.title = [@"正在绑定" localizedString];
        }
            break;
        case JYLoading_bindSuccess:
        {
            self.showButton = NO;
            self.loading = NO;
            self.title = title;
            self.detail = [@"绑定成功" localizedString];
        }
            break;
        case JYLoading_Sending:
        {
            self.showButton = NO;
            self.loading = YES;
            self.title = [@"正在发送" localizedString];
        }
            break;
            
        case JYLoading_SendSuccess:
        {
            self.showButton = NO;
            self.loading = NO;
            self.title = [@"密码重设邮件已发送,请查收" localizedString];
            self.mainLabel.font = [UIFont systemFontOfSize:15];
        }
            break;
        default:
            break;
    }
    
    _lodingType = aLodingType;
}

@end
