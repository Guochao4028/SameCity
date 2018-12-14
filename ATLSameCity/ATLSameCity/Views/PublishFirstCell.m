//
//  PublishFirstCell.m
//  ATLSameCity
//
//  Created by AYLiOS on 2018/12/7.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//

#import "PublishFirstCell.h"


@interface PublishFirstCell()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation PublishFirstCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.textField setDelegate:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - UITextFieldDelegate

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if ([self.delegate respondsToSelector:@selector(cell:withTextFieldString:)] == YES) {
        [self.delegate cell:self withTextFieldString:textField.text];
    }
}

@end
