//
//  UserModel.h
//  ATLSameCity
//
//  Created by AYLiOS on 2018/12/6.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

+(UserModel *) shareInstance;
//记录需要平移的距离
@property(nonatomic)CGFloat translationX;
//用户名
@property(nonatomic, strong)NSString *userName;
//用户头像
@property(nonatomic, strong)UIImage *userSculptureImage;
//用户头像Str
@property(nonatomic, strong)NSString *userSculptureImageStr;
//是否登录
@property(nonatomic)BOOL isLogin;
//密码
@property(nonatomic)NSString *passWord;
//城市
@property(nonatomic, strong)NSString *cityName;

@end
