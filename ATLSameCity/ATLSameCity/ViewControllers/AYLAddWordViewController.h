//
//  AYLAddWordViewController.h
//  ATLSameCity
//
//  Created by AYLiOS on 2018/12/7.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AYLAddWordViewControllerDelegate;

@interface AYLAddWordViewController : UIViewController

@property(nonatomic, weak)id<AYLAddWordViewControllerDelegate>delegate;

@end

@protocol AYLAddWordViewControllerDelegate <NSObject>
- (void)addWordViewController:(AYLAddWordViewController *)vc backAction:(NSString *)inputStr;
@end
