//
//  AYLNavgationView.m
//  ATLSameCity
//
//  Created by AYLiOS on 2018/12/6.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//

#import "AYLNavgationView.h"


@interface AYLNavgationView()

@property (weak, nonatomic) IBOutlet UIView *contentView;

- (IBAction)userButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;

@property (weak, nonatomic) IBOutlet UIView *actionView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
- (IBAction)fireAction:(id)sender;
- (IBAction)renAction:(id)sender;
- (IBAction)carAtion:(id)sender;
- (IBAction)roomAction:(id)sender;

@end

@implementation AYLNavgationView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [[NSBundle mainBundle] loadNibNamed:@"AYLNavgationView" owner:self options:nil];
        self.backgroundColor = [UIColor clearColor];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self.contentView setFrame:self.bounds];
    
    [self addSubview:self.contentView];
    
    [self.actionView setAlpha:0];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectCity)];
    [self.cityNameLabel setUserInteractionEnabled:YES];
    [self.cityNameLabel addGestureRecognizer:tap];
    
    
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self.contentView setFrame:self.bounds];
}

- (IBAction)userButtonAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(userAction)] == YES) {
        [self.delegate userAction];
    }
}


-(void)selectCity{
    
    if ([self.delegate respondsToSelector:@selector(selectCity)] == YES) {
        [self.delegate selectCity];
    }
}

- (IBAction)fireAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(selectJumpPage:)] == YES) {
        [self.delegate selectJumpPage:0];
    }
}

- (IBAction)renAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(selectJumpPage:)] == YES) {
        [self.delegate selectJumpPage:1];
    }
}

- (IBAction)carAtion:(id)sender {
    if ([self.delegate respondsToSelector:@selector(selectJumpPage:)] == YES) {
        [self.delegate selectJumpPage:2];
    }
}

- (IBAction)roomAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(selectJumpPage:)] == YES) {
        [self.delegate selectJumpPage:3];
    }
}

#pragma mark - setter
-(void)setIsChange:(BOOL)isChange{
    if (isChange == YES) {
        [self.actionView setAlpha:1];
        [self.titleLabel setAlpha:0];
    }else{
        [self.titleLabel setAlpha:1];
        [self.actionView setAlpha:0];
    }
}


-(void)setCityName:(NSString *)cityName{
    [self.cityNameLabel setText:cityName];
}

@end
