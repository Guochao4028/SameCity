//
//  UIFactory.m
//  ATLSameCity
//
//  Created by AYLiOS on 2018/12/10.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//

#import "UIFactory.h"

@implementation UIFactory

+(UILabel*) createLineWithFrame:(CGRect)frame{
    
    UILabel *line = [UIFactory createLineWithFrame:frame withColor:[UIColor colorWithRed:235.0/255.0 green:237.0/255.0 blue:237.0/255.0 alpha:0.99]];
    return line;
}

+(UILabel*) createLineWithFrame:(CGRect) frame withColor:(UIColor*) color{
    
    UILabel *line = [[UILabel alloc] initWithFrame:frame];
    line.backgroundColor = color;
    return line;
}

+(UIColor*) createColorWithRed:(CGFloat) red withGreen:(CGFloat) green withBlue:(CGFloat) blue{
    UIColor *color = [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
    return color;
}

+(UIBarButtonItem *) createLeftArrowBarButtonItemWithTarget:(id)target withAction:(SEL)action{
    
    UIImageView *arrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow"]];
    arrow.frame = CGRectMake(0, 0, 30, 40);
    arrow.contentMode = UIViewContentModeLeft;
    [arrow setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
    [arrow addGestureRecognizer:tapGest];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:arrow];
    return item;
}


+(UIView*) createRightArrowView{
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 14)];
    UIImageView * rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightArrow"]];
    rightArrow.frame = CGRectMake(0, 0, 8, 14);
    [view addSubview:rightArrow];
    return view;
}

@end
