//
//  PublishModel.h
//  ATLSameCity
//
//  Created by AYLiOS on 2018/12/11.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserModel;

@interface PublishModel : NSObject
//城市
@property(nonatomic, strong)NSString *cityName;
//用户信息
@property(nonatomic, strong)UserModel *user;
//发布时间
@property(nonatomic, strong)NSString *publishTime;
//发布类型
@property(nonatomic, strong)NSString *publishType;
//查看数
@property(nonatomic, strong)NSString *checkNumber;
//评论数
@property(nonatomic, strong)NSString *comments;
//点赞
@property(nonatomic, strong)NSString *giveLike;
//发布文字
@property(nonatomic, strong)NSString *publishContent;
//发布图片数组
@property(nonatomic, strong)NSArray *publishPicList;
//发布视频数组
@property(nonatomic, strong)NSArray *publishVideoList;
//发布视频封面数组
@property(nonatomic, strong)NSArray *publishVideoCoverList;
//发布大分类
@property(nonatomic, strong)NSString *categoryType;
//发布id
@property(nonatomic, strong)NSString *publishID;
//是否是车的
@property(nonatomic, strong)NSString *isCar;
//起点
@property(nonatomic, strong)NSString *startingPoint;
//终点
@property(nonatomic, strong)NSString *endPoint;
//手机号
@property(nonatomic, strong)NSString *phone;
//备注
@property(nonatomic, strong)NSString *note;
//价格
@property(nonatomic, strong)NSString *price;


@end
