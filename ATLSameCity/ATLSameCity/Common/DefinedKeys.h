//
//  DefinedKeys.h
//  AYLWeather
//
//  Created by AYLiOS on 2018/11/28.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//

#ifndef DefinedKeys_h
#define DefinedKeys_h

#define HEFENGUSERID   @"HE1811271854341071"
#define HEFENGAPPKEY   @"14a4319d283e49fd921555006f25a0fa"

#define StatusBarHeight   [[UIApplication sharedApplication] statusBarFrame].size.height

 #define NavigatorHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?88:64)
#define NAVIBAR_Space  (NavHeight - 64.f)
#define ScreenWidth    [[UIScreen mainScreen]bounds].size.width
#define ScreenHeight   [[UIScreen mainScreen]bounds].size.height

#define BGCOLOR        [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];//背景颜色

#define  HISTORYDATAIDENTIFIER   @"historyData"

//历史城市
#define HISTORYDATA     [[NSUserDefaults standardUserDefaults] valueForKey:HISTORYDATAIDENTIFIER]

#define FONT(size) [UIFont systemFontOfSize:size]

#define ISFIRST         @"isFirst"

#define COLOR_WHITECOLOR [UIColor whiteColor]


#define NOTIFICATION_LOCATION @"UserLocation"


#endif /* DefinedKeys_h */
