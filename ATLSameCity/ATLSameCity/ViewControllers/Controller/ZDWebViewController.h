//
//  ZDWebViewController.h
//  Real
//
//  Created by WangShuChao on 15/9/29.
//  Copyright (c) 2015年 真的网络科技公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
@interface ZDWebViewController : UIViewController<UIWebViewDelegate,NJKWebViewProgressDelegate>

-(instancetype) initWithUrl:(NSString*) url title:(NSString*) title;

@end
