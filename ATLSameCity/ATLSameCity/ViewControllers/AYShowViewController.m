//
//  AYShowViewController.m
//  ATLSameCity
//
//  Created by AYLiOS on 2018/12/11.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//

#import "AYShowViewController.h"
#import "CLBottomCommentView.h"
#import "CLProgressHUD.h"
#import "PublishModel.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import "SayModel.h"
#import "CommentsShowCell.h"
#import "CommentsSayCell.h"

static CGFloat const kBottomViewHeight = 46.0;
@interface AYShowViewController ()<CLBottomCommentViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) CLBottomCommentView *bottomView;

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)NSMutableArray *commentsArray;

@end


static NSString *cellIdentifier = @"cellIdentifier";

static NSString *commentsSayCellIdentifier = @"CommentsSayCell";

@implementation AYShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
}

-(void)initUI{
    [self.view addSubview:self.bottomView];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - kBottomViewHeight) style:UITableViewStyleGrouped];
    
    [self.tableView registerClass:[CommentsShowCell class] forCellReuseIdentifier:cellIdentifier];
   
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CommentsSayCell class]) bundle:nil] forCellReuseIdentifier:commentsSayCellIdentifier];
    
  
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *leftBackItem = [UIFactory createLeftArrowBarButtonItemWithTarget:self withAction:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftBackItem;
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)changeMarkButtonState:(UIButton *)sender {
    sender.selected = !sender.selected;
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else{
        return self.commentsArray.count;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0.01;
    }else{
        return 40;
    }
    
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }else{
        return 0.01;
    }
}

-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }else{
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(14, 10, 200, 20)];
        [label setText:@"全部评论"];
        [view addSubview:label];
        return view;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        CGFloat gap = 30;
        CGFloat userNameLableY = gap;
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
            userNameLableY += ((image.size.height/2) + 14);
        }
        userNameLableY += 14;
        for (int i = 0; i < self.model.publishVideoList.count; i++) {
            NSString *filePath = self.model.publishVideoCoverList[i];
            NSRange range = [filePath rangeOfString:@"cover"];
            if (range.location != NSNotFound) {
                NSString *fileName = [filePath substringFromIndex:(range.location)];
                NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
                
                NSString *file = [NSString stringWithFormat:@"%@/%@", docDir, fileName];
                UIImage *image = [UIImage imageWithContentsOfFile:file];
                
                userNameLableY += (image.size.height/2 + 14);
            }
        }
        return userNameLableY+20+44;
    }else{
        return 80;
    }
}

-(UITableViewCell *) tableView:(UITableView *)tableViews cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        CommentsShowCell *cell = [tableViews dequeueReusableCellWithIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setModel:self.model];
        return cell;
    }else{
        CommentsSayCell *cell = [tableViews dequeueReusableCellWithIdentifier:commentsSayCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setModel:[self.commentsArray objectAtIndex:indexPath.row]];
        return cell;
    }
    
}

#pragma mark - CLBottomCommentViewDelegate

- (void)bottomViewDidShare {
    [CLProgressHUD showInView:self.view delegate:self title:@"正在分享中..." duration:0.3];
    
    NSString *shareText = @"sharetitle";
    UIImage *shareImage = [UIImage imageNamed:@"touxiang"];
    NSURL *shareURL = [NSURL URLWithString:@"https://www.baidu.com/"];
    NSArray *activityItems = [[NSArray alloc] initWithObjects:shareText, shareImage, shareURL, nil];
    
    UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    
    UIActivityViewControllerCompletionWithItemsHandler myBlock = ^(UIActivityType activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {
        NSLog(@"%@",activityType);
        if (completed) {
            NSLog(@"分享成功");
        } else {
            NSLog(@"分享失败");
        }
        [vc dismissViewControllerAnimated:YES completion:nil];
    };
    
    vc.completionWithItemsHandler = myBlock;
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)bottomViewDidMark:(UIButton *)markButton {
    [CLProgressHUD showInView:self.view delegate:self title:@"正在收藏中..." duration:0.3];
    
    [self performSelector:@selector(changeMarkButtonState:) withObject:markButton afterDelay:2.0];
}

- (void)cl_textViewDidChange:(CLTextView *)textView {
    if (textView.commentTextView.text.length > 0) {
        NSString *originalString = [NSString stringWithFormat:@"[草稿]%@",textView.commentTextView.text];
        NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:originalString];
        [attriString addAttributes:@{NSForegroundColorAttributeName: kColorNavigationBar} range:NSMakeRange(0, 4)];
        [attriString addAttributes:@{NSForegroundColorAttributeName: kColorTextMain} range:NSMakeRange(4, attriString.length - 4)];
        
        self.bottomView.editTextField.attributedText = attriString;
    }
}

- (void)cl_textViewDidEndEditing:(CLTextView *)textView {
    
    SayModel *sayModel = [[SayModel alloc]init];
    sayModel.user = [UserModel shareInstance];
    sayModel.say = textView.commentTextView.text;
    sayModel.pid = self.model.publishID;
    sayModel.time = [self getCurrentTimes];
    
    [[DBManager shareInstance]insertData:sayModel table:@"sayInfo" columns:@"userName, userSculptureImage, publishTime, pid, say"];
    
    NSString *entry = [NSString stringWithFormat:@"%ld", self.commentsArray.count];
    NSString *where = [NSString stringWithFormat:@"id = %d",[self.model.publishID intValue]];
    NSString *setStr = [NSString stringWithFormat:@"comments = %@", entry];
    [[DBManager shareInstance]update:where newValues:entry cums:setStr table:@"publishInfo"];
    
    [self.commentsArray addObject:sayModel];
    
    [CLProgressHUD showInView:self.view delegate:self title:@"正在发送评论中..." duration:0.3];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3    * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.bottomView clearComment];
        [self.tableView reloadData];
    });
}

-(NSString*)getCurrentTimes{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
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

#pragma mark - setter
- (CLBottomCommentView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[CLBottomCommentView alloc] initWithFrame:CGRectMake(0, cl_ScreenHeight - kBottomViewHeight, cl_ScreenWidth, kBottomViewHeight)];
        _bottomView.delegate = self;
        _bottomView.clTextView.delegate = self;
    }
    return _bottomView;
}

-(NSMutableArray *)commentsArray{
    
    if (_commentsArray == nil){
        NSString *where = [NSString stringWithFormat:@"pid = '%@'", self.model.publishID];
        NSArray *sayList = [[DBManager shareInstance]queryData:where table:@"sayInfo"];
        _commentsArray = [NSMutableArray arrayWithArray:sayList];
    }
    return _commentsArray;
}

@end
