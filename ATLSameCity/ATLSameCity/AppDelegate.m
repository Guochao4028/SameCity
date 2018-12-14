//
//  AppDelegate.m
//  ATLSameCity
//
//  Created by AYLiOS on 2018/12/6.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//

#import "AppDelegate.h"

#import "AYLMainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    AYLMainViewController *rootVC = [[AYLMainViewController alloc] init];
    
    UINavigationController *nar = [[UINavigationController alloc]initWithRootViewController:rootVC];
    
    self.window.rootViewController = nar;
    
    [self initData];
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)copyMissingFile:(NSString *)sourcePath toPath:(NSString *)toPath
{
    BOOL retVal = YES; // If the file already exists, we'll return success…
    NSString * finalLocation = [toPath stringByAppendingPathComponent:[sourcePath lastPathComponent]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:finalLocation])
    {
        retVal = [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:finalLocation error:NULL];
    }
    return retVal;
}

-(void)initData{
    NSString *localPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 要检查的文件目录
    NSString *filePath = [localPath  stringByAppendingPathComponent:@"User.sqlite"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        NSLog(@"文件abc.doc存在");
    }else {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"User" ofType:@"sqlite"];
        
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        //    self.dbPath = [doc stringByAppendingPathComponent:@"User.sqlite"];
        [self copyMissingFile:filePath toPath:doc];
    }

    
    
    [[UserModel shareInstance] setCityName:@"北京"];

    /*  创建数据库 */
    [[DBManager shareInstance]createTableSqlString:@[
                                                     @"\
                                                     CREATE TABLE publishInfo('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL , 'userName' VARCHAR(255), 'userSculptureImage' TEXT, 'publishTime' VARCHAR(255), 'publishType' VARCHAR(10), 'checkNumber' VARCHAR(10), 'comments' VARCHAR(10), 'giveLike' VARCHAR(10), 'publishContent' TEXT, 'publishPicList' TEXT, 'publishVideoList' TEXT,'cityName' VARCHAR(255),'categoryType' VARCHAR(255),'isCar' VARCHAR(1) DEFAULT '0','startingPoint' VARCHAR(255),'endPoint' VARCHAR(255),'phone' VARCHAR(255), 'note' TEXT, 'price' VARCHAR(255), 'videoCover' TEXT);\
                                                     ",
                                                     @"\
                                                     CREATE TABLE userInfo ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL , \
                                                     'userName' VARCHAR(255),\
                                                     'userSculptureImage' VARCHAR(255),\
                                                     'isLogin'VARCHAR(1) DEFAULT '0',\
                                                     'passWord'VARCHAR(255));\
                                                     ",
                                                     @"\
                                                     CREATE TABLE sayInfo('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL , 'userName' VARCHAR(255), 'userSculptureImage' TEXT, 'publishTime' VARCHAR(255), 'say' TEXT, 'pid' VARCHAR(255));\
                                                     "
                                                     ] tableNames:@[@"publishInfo", @"userInfo"]];

    
    NSArray *resultsArray = [[DBManager shareInstance]queryData:nil table:@"userInfo"];
    if (resultsArray.count == 0) {

        UserModel *user = [UserModel shareInstance];
        user.userName = @"13588888888";
        user.passWord = @"123456789";
        user.isLogin = 0;
        [[DBManager shareInstance]insertData:user table:@"userInfo" columns:@"userName, userSculptureImage,isLogin,passWord"];
    }else{
         NSArray *resultsArray = [[DBManager shareInstance]queryData:@"isLogin = '1'" table:@"userInfo"];
        
        if (resultsArray.count > 0) {
            UserModel *user = [resultsArray lastObject];
            [[UserModel shareInstance]setIsLogin:YES];
            [[UserModel shareInstance]setUserName:user.userName];
            [[UserModel shareInstance]setPassWord:user.passWord];
            [[UserModel shareInstance]setUserSculptureImage:[UIImage imageNamed:@"touxiang"]];
        }else{
            [[UserModel shareInstance]setIsLogin:NO];
            [[UserModel shareInstance]setUserSculptureImage:[UIImage imageNamed:@"touxiang"]];
        }
        
        
    }
}


@end
