//
//  CCUnderLineButton.m
//  coco-v2
//
//  Created by 孙永刚 on 14-6-5.
//  Copyright (c) 2014年 CocoaChina. All rights reserved.
//

#import "JYButton.h"
#import "JYUtil.h"

@interface JYButton ()
{
    UIColor *_normalColor;
}

@end

@implementation JYButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self addTarget:self action:@selector(handleTouchEvent) forControlEvents:UIControlEventTouchDown |UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    }
    return self;
}

//- (void)awakeFromNib
//{
//    [super awakeFromNib];
//    
//    
//    
//    [self addTarget:self action:@selector(handleTouchEvent) forControlEvents:UIControlEventTouchDown |UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
//}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setExclusiveTouch:YES];
//    [self addTarget:self action:@selector(handleTouchEvent) forControlEvents:UIControlEventTouchDown |UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    
    [self setBackgroundImage:[[self backgroundImageForState:UIControlStateNormal] stretchBGImage]forState:UIControlStateNormal];
    [self setBackgroundImage:[[self backgroundImageForState:UIControlStateHighlighted] stretchBGImage]forState:UIControlStateHighlighted];
    [self setBackgroundImage:[[self backgroundImageForState:UIControlStateDisabled] stretchBGImage]forState:UIControlStateDisabled];
    [self setBackgroundImage:[[self backgroundImageForState:UIControlStateSelected] stretchBGImage]forState:UIControlStateSelected];
}


- (void)handleTouchEvent
{
    [self setNeedsDisplay];
}

- (void)setShowUnderLine:(BOOL)aShowUnderLine
{
    _showUnderLine = aShowUnderLine;
    [self setNeedsDisplay];
}

- (void)setNormalColor:(UIColor *)aNormalColor
{
    _normalColor = aNormalColor;
    [self setNeedsDisplay];
}

- (void)setHighlightedColor:(UIColor *)aHighlightedColor
{
    _highlightedColor = aHighlightedColor;
    [self setNeedsDisplay];
}

- (void)setBtnType:(JYButtonType)aBtnType
{
    self.backgroundColor = [UIColor clearColor];
    switch (aBtnType) {
        case JYButtonType_Default:
        {
            _normalColor = [UIColor clearColor];
            _highlightedColor = [UIColor clearColor];
        }
            break;
        case JYButtonType_Gray:
        {
            _normalColor = [UIColor colorWithRed:242.0/255
                                           green:242.0/255.
                                            blue:245./255
                                           alpha:1.0];
            _highlightedColor = [UIColor colorWithRed:226./255
                                                green:226./255.
                                                 blue:230./255
                                                alpha:1.0];
        }
            break;
        case JYButtonType_Blue:
        {
            _normalColor = [UIColor colorWithRed:17./255
                                           green:112./255.
                                            blue:231./255
                                           alpha:1.0];
            _highlightedColor = [UIColor colorWithRed:15./255
                                                green:97./255.
                                                 blue:200./255
                                                alpha:1.0];
        }
        default:
            break;
    }
}

- (void) drawRect:(CGRect)rect {
    //圆角+填充色
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGFloat radius = CC_CORNERRADIUS;
    CGContextSetRGBStrokeColor(contextRef, 1.0, 1.0, 1.0, 1);
    UIColor *tempColor;
    if (self.state == UIControlStateNormal) {
        tempColor = _normalColor==nil? [UIColor clearColor]:_normalColor;
    }
    else
    {
        tempColor = _highlightedColor==nil? [UIColor clearColor]:_highlightedColor;
    }
    CGContextSetFillColorWithColor(contextRef, [tempColor CGColor]);
    CGContextSetStrokeColorWithColor(contextRef, [tempColor CGColor]);
    
    CGFloat minx = CGRectGetMinX(rect), midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect);
    CGFloat miny = CGRectGetMinY(rect), midy = CGRectGetMidY(rect), maxy = CGRectGetMaxY(rect);
    CGContextMoveToPoint(contextRef, minx, midy);
    CGContextAddArcToPoint(contextRef, minx, miny, midx, miny, radius);
    CGContextAddArcToPoint(contextRef, maxx, miny, maxx, midy, radius);
    CGContextAddArcToPoint(contextRef, maxx, maxy, midx, maxy, radius);
    CGContextAddArcToPoint(contextRef, minx, maxy, minx, midy, radius);
    CGContextClosePath(contextRef);
    CGContextDrawPath(contextRef, kCGPathFillStroke);
    
    //下划线
    if (_showUnderLine)
    {
        CGContextRef contextRef = UIGraphicsGetCurrentContext();
        CGRect textRect = self.titleLabel.frame;
        // need to put the line at top of descenders (negative value)
        CGFloat descender = self.titleLabel.font.descender;
        // set to same colour as text
        CGContextSetStrokeColorWithColor(contextRef, self.titleLabel.textColor.CGColor);
        CGContextMoveToPoint(contextRef, textRect.origin.x, textRect.origin.y + textRect.size.height+2 + descender);
        CGContextAddLineToPoint(contextRef, textRect.origin.x + textRect.size.width, textRect.origin.y + textRect.size.height + descender+2);
        CGContextClosePath(contextRef);
        CGContextDrawPath(contextRef, kCGPathStroke);
    }
}




@end
