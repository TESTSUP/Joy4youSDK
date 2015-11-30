//
//  JYCacheListView.h
//  Joy4youSDK
//
//  Created by joy4you on 15/11/30.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYUserCache.h"


@protocol JYCacheUserListDelegate <NSObject>

- (void)JYCacheUserListDidSelectedUser:(JYUserContent *)aUser;

- (void)JYCacheUserListDidDeletedUser:(JYUserContent *)aUser;

@end


@interface JYCacheListView : UIView

@property (nonatomic, weak) id<JYCacheUserListDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *bgView;

@property (weak, nonatomic) IBOutlet UITableView *listView;

@end
