//
//  AYLNavgationView.h
//  ATLSameCity
//
//  Created by AYLiOS on 2018/12/6.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol  AYLNavgationViewDelegate;


@interface AYLNavgationView : UIView
@property(nonatomic, weak)id<AYLNavgationViewDelegate>delegate;
@property(nonatomic, assign)BOOL isChange;
@property(nonatomic, strong)NSString *cityName;
@end

@protocol AYLNavgationViewDelegate <NSObject>
@optional
-(void)userAction;
-(void)selectCity;
-(void)selectJumpPage:(NSInteger)type;
@end
