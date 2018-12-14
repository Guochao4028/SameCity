//
//  DBManager.h
//  ATLSameCity
//
//  Created by AYLiOS on 2018/12/11.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject

+(instancetype)shareInstance;

-(void)clearAllForTable:(NSString *)tableName;

-(void)createTableSqlString:(NSArray *)sqlStrings tableNames:(NSArray <NSString *>*)tableNames;

-(void)insertData:(id)data table:(NSString *)tableName columns:(NSString *)column;

-(void)update:(NSString *)conditions newValues:(NSString *)value cums:(NSString *)cums  table:(NSString *)tableName;

-(NSArray *)queryData:(NSString *)conditions table:(NSString *)tableName;

@end
