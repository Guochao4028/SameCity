//
//  HomeContentCell.m
//  ATLSameCity
//
//  Created by AYLiOS on 2018/12/7.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//

#import "HomeContentCell.h"
#import <Photos/Photos.h>
#import "PublishModel.h"
#import <MediaPlayer/MediaPlayer.h>


@interface HomeContentCell()
@property (weak, nonatomic) IBOutlet UIImageView *userHeardImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLable;
@property (weak, nonatomic) IBOutlet UILabel *publishTime;
@property (weak, nonatomic) IBOutlet UILabel *categoryTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *publishContentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UILabel *checkNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;
@property (weak, nonatomic) IBOutlet UILabel *giveLikeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *publishContentLabelH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewH;
@property (weak, nonatomic) IBOutlet UIView *ordinaryView;
@property (weak, nonatomic) IBOutlet UIView *specialView;



@property (weak, nonatomic) IBOutlet UIImageView *specialHeardView;
@property (weak, nonatomic) IBOutlet UILabel *specialTime;
@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;
@property (weak, nonatomic) IBOutlet UILabel *specialCarType;
@property (weak, nonatomic) IBOutlet UITextView *specialText;
@property (weak, nonatomic) IBOutlet UILabel *specialUserName;

@end

@implementation HomeContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.videoImageView setHidden:YES];
    [self.imageView1 setHidden:YES];
    [self.imageView2 setHidden:YES];
    [self.imageView3 setHidden:YES];
    // Initialization code
    [self.ordinaryView setHidden:YES];
    [self.specialView setHidden:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(PublishModel *)model{
    _model = model;
    
    
    
    if([model.isCar isEqualToString:@"1"] == NO) {
        [self.ordinaryView setHidden:NO];
        [self.specialView setHidden:YES];
        [self initOrdinary:model];
    }else{
        [self.specialView setHidden:NO];
        [self initSpecialView:model];
        [self.ordinaryView setHidden:YES];
    }
    
}

-(void)initOrdinary:(PublishModel *)model{
    NSMutableArray *tem = [NSMutableArray arrayWithArray:model.publishVideoList];
    [tem removeObject:@""];
    model.publishVideoList = [NSArray arrayWithArray:tem];
    
    NSMutableArray *tem1 = [NSMutableArray arrayWithArray:model.publishPicList];
    [tem1 removeObject:@""];
    model.publishPicList = [NSArray arrayWithArray:tem1];
    
    if (model.publishPicList.count == 0) {
        self.imageViewH.constant = 0;
    }
    
    [self.userNameLable setText:[[UserModel shareInstance]userName]];
    
    [self.publishTime setText:model.publishTime];
    
    [self.userHeardImageView setImage:[UIImage imageNamed:@"touxiang"]];
    
    [self.publishContentLabel setText:model.publishContent];
    if (model.publishContent.length == 0) {
        self.publishContentLabelH.constant = 0;
    }else{
        self.publishContentLabelH.constant = 36;
    }
    
    if (model.publishVideoList.count > 0) {
        [self.videoImageView setHidden:NO];
        [self.imageView1 setHidden:YES];
        [self.imageView2 setHidden:YES];
        [self.imageView3 setHidden:YES];
        
        NSString *filePath = model.publishVideoCoverList[0];
        NSRange range = [filePath rangeOfString:@"cover"];
        if (range.location != NSNotFound) {
            NSString *fileName = [filePath substringFromIndex:(range.location)];
            NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
            
            NSString *file = [NSString stringWithFormat:@"%@/%@", docDir, fileName];
            UIImage *image = [UIImage imageWithContentsOfFile:file];
            [self.videoImageView setImage:image];
        }
        

    }else{
        [self.videoImageView setHidden:YES];
        [self.imageView1 setHidden:NO];
        [self.imageView2 setHidden:NO];
        [self.imageView3 setHidden:NO];
        for (int i = 0; i < model.publishPicList.count; i++) {
            if (i>2) {
                break;
            }else{
                NSString *filePath = model.publishPicList[i];
                NSRange range = [filePath rangeOfString:@"pic"];
                if (range.location != NSNotFound) {
                    NSString *fileName = [filePath substringFromIndex:(range.location)];
                    
                    switch (i) {
                        case 0:
                        {
                            NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
                            NSString *file = [NSString stringWithFormat:@"%@/%@", docDir, fileName];
                            UIImage *image = [UIImage imageWithContentsOfFile:file];
                            
                            [self.imageView1 setImage:image];
                        }
                            break;
                        case 1:
                        {
                            NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
                            NSString *file = [NSString stringWithFormat:@"%@/%@", docDir, fileName];
                            UIImage *image = [UIImage imageWithContentsOfFile:file];
                            [self.imageView2 setImage:image];
                        }
                            break;
                        case 2:
                        {
                            NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
                            NSString *file = [NSString stringWithFormat:@"%@/%@", docDir, fileName];
                            UIImage *image = [UIImage imageWithContentsOfFile:file];
                            [self.imageView3 setImage:image];
                        }
                            break;
                        default:
                            break;
                    }
                }
            }
        }
    }
    
    if (model.publishPicList.count == 0) {
        [self.imageView1 setHidden:YES];
        [self.imageView2 setHidden:YES];
        [self.imageView3 setHidden:YES];
    }
    
    [self.commentsLabel setText:model.comments];
    
    
    if ([model.categoryType isEqualToString:@"求职招聘"] == YES) {
        [self.categoryTypeLabel setHidden:NO];
        switch ([model.publishType integerValue]) {
            case 0:{
                [self.categoryTypeLabel setText:@"求职"];
            }
                break;
            case 1:
                [self.categoryTypeLabel setText:@"招聘"];
                break;
            case 2:
                [self.categoryTypeLabel setText:@"兼职"];
                break;
            default:
                break;
        }
    }else if ([model.categoryType isEqualToString:@"租房售房"] == YES) {
        [self.categoryTypeLabel setHidden:NO];
        switch ([model.publishType integerValue]) {
            case 0:{
                [self.categoryTypeLabel setText:@"出租"];
            }
                break;
            case 1:
                [self.categoryTypeLabel setText:@"出售"];
                break;
            case 2:
                [self.categoryTypeLabel setText:@"合租"];
                break;
            default:
                break;
        }
    }else{
        [self.categoryTypeLabel setHidden:YES];
    }
}

-(void)initSpecialView:(PublishModel *)model{
    [self.specialUserName setText:[[UserModel shareInstance]userName]];
    [self.specialHeardView setImage:[UIImage imageNamed:@"touxiang"]];
    [self.specialTime setText:model.publishTime];
    [self.startLabel setText:model.startingPoint];
    [self.endLabel setText:model.endPoint];
    [self.specialText setText:model.note];
    
    if([model.publishType intValue] == 1){
        [self.specialCarType setText:@"人找车"];
    }else{
        [self.specialCarType setText:@"车找人"];
    }
    
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
