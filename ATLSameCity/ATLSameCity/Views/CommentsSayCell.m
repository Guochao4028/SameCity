//
//  CommentsSayCell.m
//  ATLSameCity
//
//  Created by AYLiOS on 2018/12/12.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//

#import "CommentsSayCell.h"
#import "SayModel.h"


@interface CommentsSayCell()
@property (weak, nonatomic) IBOutlet UIImageView *heardImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *publishTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sayLabel;

@end


@implementation CommentsSayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(SayModel *)model{
    _model = model;
    [self.heardImageView setImage:model.user.userSculptureImage];
    [self.userNameLabel setText:model.user.userName];
    [self.publishTimeLabel setText:model.time];
    [self.sayLabel setText:model.say];
}

@end
