//
//  PublishLastCell.m
//  ATLSameCity
//
//  Created by AYLiOS on 2018/12/7.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//


#import "PublishLastCell.h"


@interface PublishLastCell()
@property (weak, nonatomic) IBOutlet UIButton *addWordButton;

- (IBAction)addWordAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *addPicButton;
- (IBAction)addPicAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *addVideoButton;
- (IBAction)addVideoAction:(id)sender;

@end

@implementation PublishLastCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)addWordAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(cell:tapAciton:)] == YES) {
        [self.delegate cell:self tapAciton:0];
    }
}

- (IBAction)addPicAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(cell:tapAciton:)] == YES) {
        [self.delegate cell:self tapAciton:1];
    }
}

- (IBAction)addVideoAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(cell:tapAciton:)] == YES) {
        [self.delegate cell:self tapAciton:2];
    }
}

@end
