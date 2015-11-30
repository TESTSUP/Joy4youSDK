//
//  JYCacheCellView.m
//  Joy4youSDK
//
//  Created by joy4you on 15/11/30.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import "JYCacheCellView.h"

@implementation JYCacheCellView

- (void)awakeFromNib {
    // Initialization code
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    bgView.backgroundColor = [UIColor colorWithRed:226.0/255.0
                                             green:226.0/255.0
                                              blue:230.0/255.0
                                             alpha:1.0];
    self.selectedBackgroundView = bgView;
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
