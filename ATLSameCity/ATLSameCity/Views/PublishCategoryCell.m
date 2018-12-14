//
//  PublishCategoryCell.m
//  ATLSameCity
//
//  Created by AYLiOS on 2018/12/10.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//

#import "PublishCategoryCell.h"

@interface PublishCategoryCell()
@property (weak, nonatomic) IBOutlet UIButton *zeroButton;
@property (weak, nonatomic) IBOutlet UIButton *oneButton;
@property (weak, nonatomic) IBOutlet UIButton *twoButton;
- (IBAction)zeroButtonAction:(id)sender;
- (IBAction)oneButtonAction:(id)sender;
- (IBAction)twoButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *zeroTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *oneTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *twoTitleLabel;

@end


@implementation PublishCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark - action
- (IBAction)zeroButtonAction:(id)sender {
    
    [self.zeroButton setImage:[UIImage imageNamed:@"cart_selected_btn"] forState:UIControlStateNormal];
     [self.oneButton setImage:[UIImage imageNamed:@"cart_unSelect_btn"] forState:UIControlStateNormal];
     [self.twoButton setImage:[UIImage imageNamed:@"cart_unSelect_btn"] forState:UIControlStateNormal];
    if ([self.delegate respondsToSelector:@selector(cell:tapType:)]) {
        [self.delegate cell:self tapType:0];
    }
}

- (IBAction)oneButtonAction:(id)sender {
    [self.zeroButton setImage:[UIImage imageNamed:@"cart_unSelect_btn"] forState:UIControlStateNormal];
    [self.oneButton setImage:[UIImage imageNamed:@"cart_selected_btn"] forState:UIControlStateNormal];
    [self.twoButton setImage:[UIImage imageNamed:@"cart_unSelect_btn"] forState:UIControlStateNormal];
    if ([self.delegate respondsToSelector:@selector(cell:tapType:)]) {
        [self.delegate cell:self tapType:1];
    }
}

- (IBAction)twoButtonAction:(id)sender {
    [self.zeroButton setImage:[UIImage imageNamed:@"cart_unSelect_btn"] forState:UIControlStateNormal];
    [self.oneButton setImage:[UIImage imageNamed:@"cart_unSelect_btn"] forState:UIControlStateNormal];
    [self.twoButton setImage:[UIImage imageNamed:@"cart_selected_btn"] forState:UIControlStateNormal];
    if ([self.delegate respondsToSelector:@selector(cell:tapType:)]) {
        [self.delegate cell:self tapType:2];
    }
}

#pragma mark - setter
-(void)setType:(NSInteger)type{
    
    switch (type) {
        case 1:{
            [self.zeroTitleLabel setText:@"求职"];
            [self.oneTitleLabel setText:@"招聘"];
            [self.twoTitleLabel setText:@"兼职"];
        }
            break;
        
        case 3:{
            [self.zeroTitleLabel setText:@"房屋出租"];
            [self.oneTitleLabel setText:@"房屋出售"];
            [self.twoTitleLabel setText:@"求租合租"];
        }
            break;
        default:
            break;
    }
    
}

@end
