//
//  UserModel.m
//  ATLSameCity
//
//  Created by AYLiOS on 2018/12/6.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
static UserModel *_instance;

+(UserModel*)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(_instance == nil)
            _instance = [[UserModel alloc] init];
    });
    return _instance;
}

@end
