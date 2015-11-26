//
//  CCUnderLineButton.h
//  coco-v2
//
//  Created by 孙永刚 on 14-6-5.
//  Copyright (c) 2014年 CocoaChina. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum JYButtonType{
    JYButtonType_Default = 0,
    JYButtonType_Gray,
    JYButtonType_Blue
}JYButtonType;

@interface JYButton : UIButton

@property (nonatomic, assign) JYButtonType btnType;

@property (nonatomic, assign) BOOL showUnderLine;

@property (nonatomic, strong) UIColor *normalColor;

@property (nonatomic, strong) UIColor *highlightedColor;


@end
