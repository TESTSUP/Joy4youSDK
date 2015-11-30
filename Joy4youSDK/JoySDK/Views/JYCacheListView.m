//
//  JYCacheListView.m
//  Joy4youSDK
//
//  Created by joy4you on 15/11/30.
//  Copyright © 2015年 LeHeng. All rights reserved.
//

#import "JYCacheListView.h"
#import "JYUtil.h"
#import "JYCacheCellView.h"

@interface JYCacheListView ()<UITableViewDataSource, UITableViewDelegate>
{
    NSArray* _cacheArray;
}
@end

@implementation JYCacheListView

- (void)awakeFromNib
{
    _cacheArray = [[JYUserCache sharedInstance] normalUserList];
    
    self.clipsToBounds = YES;
    self.listView.separatorColor = [UIColor colorWithRed:211./255. green:209./255 blue:213./255 alpha:1];
    
    [self.listView registerNib:[UINib nibWithNibName:@"JYCacheCellView" bundle:[NSBundle resourceBundle]] forCellReuseIdentifier:cacheCellId];
    
    
    UIEdgeInsets edge = UIEdgeInsetsMake(10,2,10,2);
    if ([[UIDevice currentDevice].systemVersion floatValue] > 5.0)
    {
        _bgView.image = [_bgView.image resizableImageWithCapInsets:edge];
    }
    else
    {
        _bgView.image = [_bgView.image stretchableImageWithLeftCapWidth:3 topCapHeight:20];
    }
    
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        self.listView.separatorInset = UIEdgeInsetsZero;
    }
}

- (void)deleteCache:(UIButton *)aBtn
{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:aBtn.tag inSection:0];
    
    [_listView beginUpdates];
    [_listView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationMiddle];
    
    JYUserContent *user = [_cacheArray objectAtIndex:aBtn.tag];
    _cacheArray = [[JYUserCache sharedInstance] deleteLoginCache:user.userid];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(JYCacheUserListDidDeletedUser:)])
    {
        [self.delegate JYCacheUserListDidDeletedUser:user];
    }
    
    [_listView endUpdates];
    
    [_listView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_cacheArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYCacheCellView *cell = (JYCacheCellView *)[tableView dequeueReusableCellWithIdentifier:cacheCellId];
    
    JYUserContent *user = [_cacheArray objectAtIndex:[indexPath row]];
    [cell.delBtn addTarget:self action:@selector(deleteCache:) forControlEvents:UIControlEventTouchUpInside];
    cell.delBtn.tag = [indexPath row];
    
    if ([user.username length]>0) {
        cell.userName.text = user.username;
    } else if ([user.phone length]){
        cell.userName.text = user.phone;
    }
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYUserContent *user = [_cacheArray objectAtIndex:[indexPath row]];
    if (self.delegate && [self.delegate respondsToSelector:@selector(JYCacheUserListDidSelectedUser:)])
    {
        [self.delegate JYCacheUserListDidSelectedUser:user];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
