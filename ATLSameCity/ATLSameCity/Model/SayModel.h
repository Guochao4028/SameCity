//
//  SayModel.h
//  ATLSameCity
//
//  Created by AYLiOS on 2018/12/12.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserModel;

@interface SayModel : NSObject

@property(nonatomic, strong)UserModel *user;

@property(nonatomic, strong)NSString *time;

@property(nonatomic, strong)NSString *pid;

@property(nonatomic, strong)NSString *say;

@end
