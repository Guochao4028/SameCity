//
//  PublishLastCell.h
//  ATLSameCity
//
//  Created by AYLiOS on 2018/12/7.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  PublishLastCellDelegate;
@interface PublishLastCell : UITableViewCell
@property(nonatomic, strong)id<PublishLastCellDelegate>delegate;
@end
@protocol PublishLastCellDelegate <NSObject>
@optional
-(void)cell:(PublishLastCell *)cell tapAciton:(NSInteger)type;
@end
