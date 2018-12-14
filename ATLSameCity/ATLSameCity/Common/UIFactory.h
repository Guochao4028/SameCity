//
//  UIFactory.h
//  ATLSameCity
//
//  Created by AYLiOS on 2018/12/10.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIFactory : NSObject

+(UILabel*) createLineWithFrame:(CGRect) frame;

+(UILabel*) createLineWithFrame:(CGRect) frame withColor:(UIColor*) color;

+(UIColor*) createColorWithRed:(CGFloat) red withGreen:(CGFloat) green withBlue:(CGFloat) blue;

+(UIBarButtonItem *) createLeftArrowBarButtonItemWithTarget:(id)target withAction:(SEL)action;


+(UIView*) createRightArrowView;

@end
