//
//  PublishFirstCell.h
//  ATLSameCity
//
//  Created by AYLiOS on 2018/12/7.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  PublishFirstCellDelegate;

@interface PublishFirstCell : UITableViewCell

@property(nonatomic, strong)id<PublishFirstCellDelegate>delegate;

@end

@protocol PublishFirstCellDelegate <NSObject>
@optional
-(void)cell:(PublishFirstCell *)cell withTextFieldString:(NSString *)str;
@end
