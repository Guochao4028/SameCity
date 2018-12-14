//
//  CommentsShowCell.m
//  ATLSameCity
//
//  Created by AYLiOS on 2018/12/12.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//

#import "CommentsShowCell.h"
#import "PublishModel.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

@interface CommentsShowCell()

@property(strong, nonatomic)UIImageView *picImageView;
@property(strong, nonatomic)UILabel *userNameLabel;
@property(strong, nonatomic)UILabel *publishLabel;
@property(strong, nonatomic)UILabel *publishContentLabel;

@end

@implementation CommentsShowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(PublishModel *)model{
    _model = model;
    
    for (UIView *tem in [self.contentView subviews]) {
        [tem removeFromSuperview];
    }
    [self initUI];
}


-(void)initUI{
    
    CGFloat gap = 14;
    
    self.picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(gap, 14, 30, 30)];
    [self.contentView addSubview:self.picImageView];
    [self.picImageView setImage:[UIImage imageNamed:@"touxiang"]];
    
    CGFloat picImageViewX = CGRectGetMaxX(self.picImageView.frame);
    self.userNameLabel  = [[UILabel alloc]initWithFrame:CGRectMake(picImageViewX + 5, 30, 50, 16)];
    [self.contentView addSubview:self.userNameLabel];
    
    [self.userNameLabel setText:[[UserModel shareInstance]userName] ];
    
    CGFloat userNameLabelX = CGRectGetMaxX(self.userNameLabel.frame);
    self.publishLabel = [[UILabel alloc]initWithFrame:CGRectMake(userNameLabelX + 5, 30, 140, 16)];
    [self.contentView addSubview:self.publishLabel];
    [self.publishLabel setFont:[UIFont systemFontOfSize:14]];
    [self.publishLabel setText:self.model.publishTime];
    
    CGFloat cY = CGRectGetMaxY(self.publishLabel.frame);
    
    self.publishContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(14, cY + 14, ScreenWidth - 28, 30)];
    [self.contentView addSubview:self.publishContentLabel];
    [self.publishContentLabel setText:self.model.publishContent];
    
    
    CGFloat userNameLableY = CGRectGetMaxY(self.publishContentLabel.frame);
    
    for (int i = 0; i < self.model.publishPicList.count; i++) {
        NSString *filePath = self.model.publishPicList[i];
        NSRange range = [filePath rangeOfString:@"pic"];
        NSString *fileName;
        if (range.location != NSNotFound) {
            fileName = [filePath substringFromIndex:(range.location)];
        }
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *file = [NSString stringWithFormat:@"%@/%@", docDir, fileName];
        UIImage *image = [UIImage imageWithContentsOfFile:file];
        
        UIImageView *tempImage = [[UIImageView alloc]initWithFrame:CGRectMake(14, userNameLableY + 14 , ScreenWidth - 28, image.size.height/2)];
        [tempImage setImage:image];
        [self.contentView addSubview:tempImage];
        
        userNameLableY += (image.size.height/2 + 14);
    }
    userNameLableY += 14;
    for (int i = 0; i < self.model.publishVideoList.count; i++) {
//        NSString *filePath = self.model.publishVideoList[i];
        
//        NSURL *url = [NSURL URLWithString:filePath];
//        UIImage *image = [self thumbnailImageForVideo:url atTime:1];
//
//        UIImageView *tempImage = [[UIImageView alloc]initWithFrame:CGRectMake(14, userNameLableY + 14 , ScreenWidth - 28, image.size.height)];
//        [self.contentView addSubview:tempImage];
        
        
        
        NSString *filePath = self.model.publishVideoCoverList[i];
        NSRange range = [filePath rangeOfString:@"cover"];
        if (range.location != NSNotFound) {
            NSString *fileName = [filePath substringFromIndex:(range.location)];
            NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
            
            NSString *file = [NSString stringWithFormat:@"%@/%@", docDir, fileName];
            UIImage *image = [UIImage imageWithContentsOfFile:file];
            
             UIImageView *tempImage = [[UIImageView alloc]initWithFrame:CGRectMake(14, userNameLableY + 14 , ScreenWidth - 28, image.size.height/2)];
            [tempImage setImage:image];
            [self.contentView addSubview:tempImage];
            
            userNameLableY += (image.size.height/2 + 14);
        }
    }
}

- (void)getVideoImageFromPHAsset:(PHAsset *)asset Complete:(void (^)(UIImage *image))resultBack{
    
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.resizeMode = PHImageRequestOptionsResizeModeFast;
    
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(200, 200) contentMode:PHImageContentModeDefault options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        UIImage *iamge = result;
        resultBack(iamge);
    }];
}


-(UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)actualTime:NULL error:&thumbnailImageGenerationError];
    
    if(!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
    
    UIImage*thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage: thumbnailImageRef] : nil;
    
    return thumbnailImage;
}


@end
