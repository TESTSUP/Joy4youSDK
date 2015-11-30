//
//  JYCacheCellView.h
//  Joy4youSDK
//
//  Created by joy4you on 15/11/30.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *cacheCellId = @"JYCacheNameCell";

@interface JYCacheCellView : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (weak, nonatomic) IBOutlet UIButton *delBtn;

@end
