//
//  PublishMiddleCell.m
//  ATLSameCity
//
//  Created by AYLiOS on 2018/12/10.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//

#import "PublishMiddleCell.h"


@interface PublishMiddleCell()
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UIButton *clooseButton;
@end

@implementation PublishMiddleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.wordLabel setHidden:YES];
    [self.picImageView setHidden:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

#pragma mark - action
- (IBAction)clooseButtonAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(cell:tapCloose:)] == YES) {
        [self.delegate cell:self tapCloose:self.indexPath];
    }
}

#pragma mark - setter
-(void)setModel:(NSDictionary *)model{
    _model = model;
    
    if ([model objectForKey:@"text"] != nil) {
        [self.wordLabel setHidden:NO];
        [self.picImageView setHidden:YES];
        [self.wordLabel setText:model[@"text"]];
    }else if ([model objectForKey:@"pic"] != nil){
        [self.wordLabel setHidden:YES];
        [self.picImageView setHidden:NO];
        [self.picImageView setImage:model[@"pic"]];
    }else{
        [self.wordLabel setHidden:YES];
        [self.picImageView setHidden:NO];
        
        NSDictionary *dic = model[@"video"];
        
//        NSDictionary *temDic = @{@"url" : url, @"cover" : cover, @"avAsset" : avAsset};
        
        [self.picImageView setImage:dic[@"cover"]];
    }
    
}

@end
