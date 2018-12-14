//
//  ZDBannerTableViewCell.h
//  Real
//
//  Created by AIlls on 2017/11/8.
//  Copyright © 2017年 真的网络科技公司. All rights reserved.
//

@protocol ZDBannerTableViewCellDelegate <NSObject>
- (void)pushToOtherViewControllerwithHomeItem:(NSString *)str;
- (void)selectNavItemWithType:(NSString *)type;
@end

static NSString *const kZDBannerTableViewCellIdentifier = @"ZDBannerTableViewCell";

//首页banner板块
@interface ZDBannerTableViewCell : UITableViewCell
@property (nonatomic,assign) id<ZDBannerTableViewCellDelegate>delegate;
@property (nonatomic,strong)NSArray  *dataSource;

@end
