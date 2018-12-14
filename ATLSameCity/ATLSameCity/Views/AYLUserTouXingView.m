//
//  AYLUserTouXingView.m
//  ATLSameCity
//
//  Created by AYLiOS on 2018/12/6.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//

#import "AYLUserTouXingView.h"

@interface AYLUserTouXingView()

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *touxiangImageView;
@property (weak, nonatomic) IBOutlet UILabel *userName;

@end


@implementation AYLUserTouXingView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [[NSBundle mainBundle] loadNibNamed:@"AYLUserTouXingView" owner:self options:nil];
        self.backgroundColor = [UIColor clearColor];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self.contentView setFrame:self.bounds];
    [self addSubview:self.contentView];
    self.touxiangImageView.layer.masksToBounds = YES;
    self.touxiangImageView.layer.cornerRadius = 25;
    self.touxiangImageView.layer.borderWidth = 2;
    self.touxiangImageView.layer.borderColor = [[UIColor blackColor] CGColor];
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self.contentView setFrame:self.bounds];
}

#pragma mark - setter
-(void)setModel:(UserModel *)model{
    _model = model;
    if (model != nil) {
        NSString *userName = model.userName == nil ? @"未登录" : model.userName;
        [self.userName setText:userName];
        
        UIImage *userSculptureImage = model.userSculptureImage == nil ? [UIImage imageNamed:@"touxiang"] : model.userSculptureImage;
        [self.touxiangImageView setImage:userSculptureImage];
       
    }
}

@end
