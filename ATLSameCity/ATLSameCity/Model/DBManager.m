//
//  DBManager.m
//  ATLSameCity
//
//  Created by AYLiOS on 2018/12/11.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//

#import "DBManager.h"
#import "FMDatabase.h"
#import "PublishModel.h"
#import "SayModel.h"

@interface DBManager ()

@property(nonatomic, copy)NSString * dbPath;

@end

@implementation DBManager

static DBManager *_instance;
+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(_instance == nil)
            _instance = [[DBManager alloc] init];
    });
    return _instance;
}

-(void)clearAllForTable:(NSString *)tableName{
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString * sql = [NSString stringWithFormat:@"delete from %@",tableName];
        [db executeUpdate:sql];
        [db close];
    }
}

-(void)createTableSqlString:(NSArray *)sqlStrings tableNames:(NSArray <NSString *>*)tableNames{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    self.dbPath = [doc stringByAppendingPathComponent:@"User.sqlite"];
    
    NSLog(@"self.dbPath : %@", self.dbPath);
    
    if ([fileManager fileExistsAtPath:self.dbPath] == NO) {
        FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
        if ([db open]) {
            for (NSString *sql in sqlStrings) {
                BOOL res = [db executeUpdate:sql];
                if (res == NO) {
                    NSLog(@"创建数据表成功");
                }
            }
            [db close];
        } else {
            NSLog(@"创建数据库失败");
        }
    }else{
        //检查数据库有是否有想要创建的数据表
        FMDatabase *db = [FMDatabase databaseWithPath:self.dbPath];
        if ([db open]) {
            int i = 0;
            for (NSString *tableName in tableNames) {
                NSString *existsSql = [NSString stringWithFormat:@"select count(name) as countNum from sqlite_master where type = 'table' and name = '%@'", tableName ];
                FMResultSet *rs = [db executeQuery:existsSql];
                if ([rs next]) {
                    NSInteger count = [rs intForColumn:@"countNum"];
                    if (count == 1) {
                        NSLog(@"存在");
                    }else{
                        NSString *sql = sqlStrings[i];
                        BOOL res = [db executeUpdate:sql];
                        if (res == NO) {
                            NSLog(@"创建数据表成功");
                        }
                    }
                }
                i++;
            }
            [db close];
        }
    }
}

-(void)insertData:(id)data table:(NSString *)tableName columns:(NSString *)column{
    
    if ([data isKindOfClass:[UserModel class]] == YES) {
        UserModel *info = (UserModel *)data;
        FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
        if ([db open]) {
            NSString * sql = [NSString stringWithFormat:@"insert into %@ (%@) values(?, ?, ?,?) ", tableName, column];
            NSString *userName = info.userName;
            NSString *isLogin = [NSString stringWithFormat:@"%d", info.isLogin];
            NSString *passWord = info.passWord;
            NSString *userSculptureImage = info.userSculptureImageStr;
            [db executeUpdate:sql, userName, userSculptureImage, isLogin, passWord];
            [db close];
        }
    }else if([data isKindOfClass:[PublishModel class]] == YES){
        PublishModel *info = (PublishModel *)data;
        FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
        if ([db open]) {
            NSString * sql = [NSString stringWithFormat:@"insert into %@ (%@) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ", tableName, column];
            NSString *userName = info.user.userName;
            NSString *userSculptureImage = info.user.userSculptureImageStr;
            NSString *publishTime = info.publishTime;
            NSString *publishType = info.publishType;
            NSString *checkNumber = info.checkNumber;
            NSString *comments = info.comments;
            NSString *giveLike = info.giveLike;
            NSString *publishContent = info.publishContent;
            NSString *imagePaths = [info.publishPicList componentsJoinedByString:@","];
            NSString *videoPaths = [info.publishVideoList componentsJoinedByString:@","];
            
            NSString *videoCoverPaths = [info.publishVideoCoverList componentsJoinedByString:@","];
            
            NSString *cityName = info.cityName;
            NSString *categoryType =info.categoryType;

            NSString *isCar =info.isCar;
            NSString *startingPoint =info.startingPoint;
            NSString *endPoint =info.endPoint;
            NSString *phone =info.phone;
            NSString *note =info.note;
            NSString *price =info.price;
          
            [db executeUpdate:sql, userName, userSculptureImage, publishTime, publishType, checkNumber, comments, giveLike, publishContent, imagePaths, videoPaths, cityName, categoryType, isCar, startingPoint, endPoint, phone, note, price, videoCoverPaths];
            [db close];
        }
    }else if([data isKindOfClass:[SayModel class]] == YES){
        SayModel *info = (SayModel *)data;
        FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
        if ([db open]) {
            NSString * sql = [NSString stringWithFormat:@"insert into %@ (%@) values(?,?,?,?,?) ", tableName, column];
            NSString *userName = info.user.userName;
            NSString *userSculptureImage = info.user.userSculptureImageStr;
            NSString *publishTime = info.time;
            NSString *pid = info.pid;
            NSString *say = info.say;
            [db executeUpdate:sql, userName, userSculptureImage, publishTime, pid, say];
            [db close];
        }
    }
}

-(void)update:(NSString *)conditions newValues:(NSString *)value cums:(NSString *)cums  table:(NSString *)tableName{
    
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        
        NSString * sql;
        if (conditions == nil) {
            sql = [NSString stringWithFormat:@"UPDATE %@ SET %@", tableName, cums];
        }else{
            sql = [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@", tableName, cums, conditions];
        }
        
        [db executeUpdate:sql];
        [db close];
    }
}

-(NSArray *)queryData:(NSString *)conditions table:(NSString *)tableName{
    
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    NSMutableArray *resultsArray = [NSMutableArray array];
    if ([db open]) {
        NSString *sql;
        if (conditions == nil) {
            sql = [NSString stringWithFormat:@"select * from %@",tableName];
        }else{
            sql = [NSString stringWithFormat:@"select * from %@ where  %@",tableName, conditions];
        }
        
        FMResultSet * rs = [db executeQuery:sql];
        
        while ([rs next]) {
            if ([tableName isEqualToString:@"userInfo"] == YES) {
                UserModel *info = [[UserModel alloc]init];
                info.passWord = [rs stringForColumn:@"passWord"];
                NSString *isLogin = [rs stringForColumn:@"isLogin"];
                info.isLogin = [isLogin boolValue];
                info.userName = [rs stringForColumn:@"userName"];
                info.userSculptureImageStr = [rs stringForColumn:@"userSculptureImage"];
                [resultsArray addObject:info];
            }else if ([tableName isEqualToString:@"publishInfo"] == YES) {
                PublishModel *info = [[PublishModel alloc]init];
                
                info.publishID = [NSString stringWithFormat:@"%d",[rs intForColumn:@"id"]];
                
                info.cityName = [rs stringForColumn:@"cityName"];
                info.publishTime = [rs stringForColumn:@"publishTime"];
                info.publishType = [rs stringForColumn:@"publishType"];
                info.checkNumber = [rs stringForColumn:@"checkNumber"];
                info.comments = [rs stringForColumn:@"comments"];
                info.giveLike = [rs stringForColumn:@"giveLike"];
                info.publishContent = [rs stringForColumn:@"publishContent"];
                info.categoryType = [rs stringForColumn:@"categoryType"];

                info.isCar = [rs stringForColumn:@"isCar"];
                info.startingPoint = [rs stringForColumn:@"startingPoint"];
                info.endPoint = [rs stringForColumn:@"endPoint"];
                info.phone = [rs stringForColumn:@"phone"];
                info.note = [rs stringForColumn:@"note"];
                info.price = [rs stringForColumn:@"price"];
                
                NSString *publishPicList = [rs stringForColumn:@"publishPicList"];
                info.publishPicList = [publishPicList componentsSeparatedByString:@","];
                NSString *publishVideoList = [rs stringForColumn:@"publishVideoList"];
                info.publishVideoList = [publishVideoList componentsSeparatedByString:@","];
               
                NSString *publishVideoCoverList = [rs stringForColumn:@"videoCover"];
                info.publishVideoCoverList = [publishVideoCoverList componentsSeparatedByString:@","];
                
                info.user.userName = [rs stringForColumn:@"userName"];
                info.user.userSculptureImageStr = [rs stringForColumn:@"userSculptureImage"];
               
                [resultsArray addObject:info];
                
            }else if ([tableName isEqualToString:@"sayInfo"] == YES) {
                SayModel *info = [[SayModel alloc]init];
                
                info.time = [rs stringForColumn:@"publishTime"];
                info.user.userName = [rs stringForColumn:@"userName"];
                info.user.userSculptureImageStr = [rs stringForColumn:@"userSculptureImage"];
                
                info.pid = [rs stringForColumn:@"pid"];
                
                info.say = [rs stringForColumn:@"say"];
                
                [resultsArray addObject:info];
            }
            
        }
        [db close];
    }
    return resultsArray;
}

@end
