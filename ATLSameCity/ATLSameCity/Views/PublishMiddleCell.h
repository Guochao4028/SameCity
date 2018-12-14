//
//  PublishMiddleCell.h
//  ATLSameCity
//
//  Created by AYLiOS on 2018/12/10.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  PublishMiddleCellDelegate;
@interface PublishMiddleCell : UITableViewCell

@property(nonatomic, strong)id<PublishMiddleCellDelegate>delegate;
@property(nonatomic, strong)NSIndexPath *indexPath;
@property(nonatomic, strong)NSDictionary *model;

@end

@protocol PublishMiddleCellDelegate <NSObject>
@optional
-(void)cell:(PublishMiddleCell *)cell tapCloose:(NSIndexPath *)indexPath;
@end
