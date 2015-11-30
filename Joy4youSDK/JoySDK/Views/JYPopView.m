//
//  JYPopView.m
//  Joy4youSDK
//
//  Created by joy4you on 15/11/27.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import "JYPopView.h"
#import "UIView+JYView.h"
#import "UIImage+JYImage.h"

@interface JYPopView ()

@property (strong, nonatomic) UIImageView *popBg;
@property (strong, nonatomic) UILabel *popTextLabel;

@end

@implementation JYPopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self createSubView];
    }
    return self;
}

- (void)createSubView
{
    self.layer.cornerRadius = CC_CORNERRADIUS;
    _popBg = [[UIImageView alloc] initWithFrame:self.bounds];
    _popBg.image = [UIImage imageNamedFromBundle:@"jy_popBg.png"];
    UIEdgeInsets edge = UIEdgeInsetsMake(6,3,3,6);
    self.popBg.image = [self.popBg.image resizableImageWithCapInsets:edge];
    
    _popTextLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _popTextLabel.textColor = [UIColor colorWithRed:235.0/255.0
                                             green:97.0/255.0
                                              blue:0
                                             alpha:1];
    _popTextLabel.font = [UIFont systemFontOfSize:10];
    _popTextLabel.backgroundColor = [UIColor clearColor];
    _popTextLabel.textAlignment = NSTextAlignmentCenter;
    _popTextLabel.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleHeight;
    
    _popBg.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleHeight;
    
    [self addSubview:_popBg];
    [self addSubview:_popTextLabel];
}

- (void)setPopText:(NSString *)aPopText
{
    CGSize configSize;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:self.popTextLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        configSize = [aPopText boundingRectWithSize:CGSizeMake(320, self.bounds.size.height)
                                            options:
                      NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                         attributes:attributes
                                            context:nil].size;
    }
    else
    {
        configSize = [aPopText sizeWithFont:self.popTextLabel.font
                          constrainedToSize:CGSizeMake(320, self.bounds.size.height)
                              lineBreakMode:NSLineBreakByWordWrapping];
        
    }
    CGPoint center = self.center;
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            configSize.width+4,
                            self.frame.size.height);
    self.center = center;
    self.popTextLabel.text = aPopText;
    _popText = aPopText;
}


@end
