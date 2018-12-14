//
//  PublishCategoryCell.h
//  ATLSameCity
//
//  Created by AYLiOS on 2018/12/10.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  PublishCategoryCellDelegate;
@interface PublishCategoryCell : UITableViewCell
@property(nonatomic, strong)id<PublishCategoryCellDelegate>delegate;
@property(nonatomic, assign)NSInteger type;
@end
@protocol PublishCategoryCellDelegate <NSObject>
@optional
-(void)cell:(PublishCategoryCell *)cell tapType:(NSInteger)type;
@end
