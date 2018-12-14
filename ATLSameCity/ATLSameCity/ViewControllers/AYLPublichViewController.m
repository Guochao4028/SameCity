//
//  AYLPublichViewController.m
//  ATLSameCity
//
//  Created by AYLiOS on 2018/12/7.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//

#import "AYLPublichViewController.h"
#import "PublishFirstCell.h"
#import "PublishLastCell.h"
#import "PublishMiddleCell.h"
#import "IQKeyboardManager.h"
#import "IQUIView+IQKeyboardToolbar.h"
#import "IQUITextFieldView+Additions.h"

#import "AYLAddWordViewController.h"
#import "PhotoAlbums.h"
#import "PublishModel.h"
#import "PublishCategoryCell.h"

@interface AYLPublichViewController ()<UITableViewDelegate, UITableViewDataSource, PublishFirstCellDelegate, PublishLastCellDelegate, AYLAddWordViewControllerDelegate, PublishMiddleCellDelegate, PublishCategoryCellDelegate>

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)NSMutableArray *dataList;

@property(nonatomic, strong)NSString *titleString;

@property(nonatomic, assign)NSInteger selcetType;


@end

static NSString *publishFirstCell = @"PublishFirstCellIdentifier";

static NSString *publishLastCell = @"PublishLastCellIdentifier";

static NSString *publishMiddleCell = @"PublishMiddleCellIdentifier";

static NSString *publishCategoryCell = @"PublishCategoryCellIdentifier";




@implementation AYLPublichViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initUI{
    self.title = @"发布内容";
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PublishFirstCell class]) bundle:nil] forCellReuseIdentifier:publishFirstCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PublishMiddleCell class]) bundle:nil] forCellReuseIdentifier:publishMiddleCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PublishLastCell class]) bundle:nil] forCellReuseIdentifier:publishLastCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PublishCategoryCell class]) bundle:nil] forCellReuseIdentifier:publishCategoryCell];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *leftBackItem = [UIFactory createLeftArrowBarButtonItemWithTarget:self withAction:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftBackItem;
    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [rightButton setTitle:@"发布" forState:UIControlStateNormal];
    [rightButton setFrame:CGRectMake(0, 0, 50, 50)];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)initData{
    self.dataList = [NSMutableArray array];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)send{

    NSString *type;
    switch (self.type) {
        case 0:{
            type = @"同城爆料";
        }
            break;
        case 1:{
            type = @"求职招聘";
        }
            break;
        case 2:{
            type = @"同城拼车";
        }
            break;
        case 3:{
            type = @"租房售房";
        }
            break;
            
        default:
            break;
    }
    PublishModel *model = [[PublishModel alloc]init];
    model.cityName = [UserModel shareInstance].cityName;
    model.user = [UserModel shareInstance];
    model.publishTime = [self getCurrentTimes];
    model.publishType = [NSString stringWithFormat:@"%ld",self.selcetType];
    model.checkNumber = @"0";
    model.comments = @"0";
    model.giveLike = @"0";
    model.categoryType = type;
    NSMutableArray *imagePathArray  = [NSMutableArray array];
    NSMutableArray *videoPathArray  = [NSMutableArray array];
    NSMutableArray *videoCoverArray = [NSMutableArray array];
    for (NSDictionary * dic in self.dataList) {
        if ([dic objectForKey:@"text"] != nil) {
            if (model.publishContent != nil) {
                model.publishContent = [model.publishContent stringByAppendingString:dic[@"text"]];
            }else{
                model.publishContent = dic[@"text"];
            }
        }else if ([dic objectForKey:@"pic"] != nil){
            static int i = 0;
            NSString *path_document = NSHomeDirectory();
            //设置一个图片的存储路径
            NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
            NSTimeInterval time=[date timeIntervalSince1970]*1000;
            NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
            NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/pic%@to%d.png", timeString,i]];
            [UIImagePNGRepresentation(dic[@"pic"])writeToFile:imagePath atomically:YES];
            [imagePathArray addObject:imagePath];
            i++;
            NSLog(@"<imagePath : %@ >", imagePath);
            
        }else{
            NSDictionary *temp = dic[@"video"];
            [videoPathArray addObject:temp[@"url"]];
            
            static int i = 0;
            NSString *path_document = NSHomeDirectory();
            //设置一个图片的存储路径
            NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
            NSTimeInterval time=[date timeIntervalSince1970]*1000;
            NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
            NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/cover%@to%d.png", timeString,i]];
            
            [UIImagePNGRepresentation(temp[@"cover"])writeToFile:imagePath atomically:YES];
            
            [videoCoverArray addObject:imagePath];
            
            i++;
        }
    }
    
    model.publishPicList = imagePathArray;
    model.publishVideoList = videoPathArray;
    model.publishVideoCoverList = videoCoverArray;
    
    [[DBManager shareInstance]insertData:model table:@"publishInfo" columns:@"userName, userSculptureImage, publishTime, publishType, checkNumber, comments, giveLike, publishContent, publishPicList, publishVideoList, cityName, categoryType, isCar, startingPoint, endPoint, phone, note, price, videoCover"];

    
    
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UITableViewDataSource && UITableViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (self.type == 0) {
        if (self.dataList.count == 0) {
            return 2;
        }else{
            return self.dataList.count + 2;
        }
    }else{
        if (self.dataList.count == 0) {
            return 3;
        }else{
            return self.dataList.count + 3;
        }
    }
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }else{
        return 0.01;
    }
}

-(UIView*) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.type == 0) {
        if (indexPath.section == 0) {
            return 50;
        }else{
            NSInteger sectionNumber = self.dataList.count;
            if (indexPath.section > 0 && indexPath.section <= sectionNumber) {
                NSInteger index = (indexPath.section -1);
                NSDictionary *dic = [self.dataList objectAtIndex:index];
                if ([dic objectForKey:@"text"] != nil) {
                    return 50;
                }else{
                    return 130;
                }
            }else{
                return 50;
            }
        }
        return 50;
    }else{
        if (indexPath.section == 0) {
            return 50;
        }else if (indexPath.section == 1){
            return 50;
        }else{
            NSInteger sectionNumber = self.dataList.count;
            if (indexPath.section > 0 && indexPath.section <= sectionNumber+1) {
                NSInteger index = (indexPath.section -2);
                NSDictionary *dic = [self.dataList objectAtIndex:index];
                if ([dic objectForKey:@"text"] != nil) {
                    return 50;
                }else{
                    return 130;
                }
            }else{
                return 50;
            }
        }
        return 50;
    }
}

-(UITableViewCell *) tableView:(UITableView *)tableViews cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    

    if (self.type == 0) {
        UITableViewCell * cell;
        if (indexPath.section == 0) {
            PublishFirstCell *cell = [tableViews dequeueReusableCellWithIdentifier:publishFirstCell];
            [cell setDelegate:self];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            NSInteger sectionNumber = self.dataList.count;
            if (indexPath.section > 0 && indexPath.section <= sectionNumber) {
                
                PublishMiddleCell *cell = [tableViews dequeueReusableCellWithIdentifier:publishMiddleCell];
                [cell setIndexPath:indexPath];
                [cell setDelegate:self];
                NSInteger index = (indexPath.section -1);
                NSDictionary *dic = [self.dataList objectAtIndex:index];
                [cell setModel:dic];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
                
            }else{
                PublishLastCell *cell = [tableViews dequeueReusableCellWithIdentifier:publishLastCell];
                [cell setDelegate:self];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
        }
        return cell;
    }else{
        UITableViewCell * cell;
        if (indexPath.section == 0) {
            PublishCategoryCell *cell = [tableViews dequeueReusableCellWithIdentifier:publishCategoryCell];
            [cell setDelegate:self];
            [cell setType:self.type];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if(indexPath.section == 1){
            
            PublishFirstCell *cell = [tableViews dequeueReusableCellWithIdentifier:publishFirstCell];
            [cell setDelegate:self];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        } else{
            NSInteger sectionNumber = self.dataList.count;
            if (indexPath.section > 1 && indexPath.section <= sectionNumber+1) {
                
                PublishMiddleCell *cell = [tableViews dequeueReusableCellWithIdentifier:publishMiddleCell];
                [cell setIndexPath:indexPath];
                [cell setDelegate:self];
                NSInteger index = (indexPath.section -2);
                NSDictionary *dic = [self.dataList objectAtIndex:index];
                [cell setModel:dic];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
                
            }else{
                PublishLastCell *cell = [tableViews dequeueReusableCellWithIdentifier:publishLastCell];
                [cell setDelegate:self];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
        }
        return cell;
    }
}

#pragma mark - PublishFirstCellDelegate
-(void)cell:(PublishFirstCell *)cell withTextFieldString:(NSString *)str{
    self.titleString = str;
}

#pragma mark - PublishLastCellDelegate
-(void)cell:(PublishLastCell *)cell tapAciton:(NSInteger)type{
    switch (type) {
        case 0:{
            //NSLog(@"添加文字");
            AYLAddWordViewController *addWordVC = [[AYLAddWordViewController alloc]init];
            [addWordVC setDelegate:self];
            [self.navigationController pushViewController:addWordVC animated:YES];
        }
            break;
        case 1:{
            NSLog(@"添加图片");
            [PhotoAlbums photoMultiSelectWithMaxImagesCount:9 delegate:self didFinishPhotoBlock:^(NSArray<UIImage *> *photos) {
                for (UIImage *photo in photos) {
                    NSDictionary *dic = @{@"pic":photo};
                    [self.dataList addObject:dic];
                    [self.tableView reloadData];
                }
            }];
        }
            break;
        case 2:{
            NSLog(@"添加视频");
            [PhotoAlbums photoVideoWithMaxDurtion:3 Delegate:self updateUIFinishPickingBlock:nil didFinishPickingVideoHandle:^(NSURL *url, UIImage *cover, id avAsset) {
                NSLog(@"%@", url);
                NSLog(@"%@", cover);
                NSLog(@"%@", avAsset);
                NSDictionary *temDic = @{@"url" : url, @"cover" : cover, @"avAsset" : avAsset};
                NSDictionary *dic = @{@"video":temDic};
                [self.dataList addObject:dic];
                [self.tableView reloadData];
            }];
        }
            break;
        default:
            break;
    }
}

#pragma mark - PublishMiddleCellDelegate
-(void)cell:(PublishMiddleCell *)cell tapCloose:(NSIndexPath *)indexPath{
    if (self.type == 0) {
        NSInteger section = indexPath.section-1;
        [self.dataList removeObjectAtIndex:section];
        [self.tableView reloadData];
    }else{
        NSInteger section = indexPath.section-2;
        [self.dataList removeObjectAtIndex:section];
        [self.tableView reloadData];
        
    }
}

#pragma mark - PublishCategoryCellDelegate

-(void)cell:(PublishCategoryCell *)cell tapType:(NSInteger)type{
    self.selcetType = type;
}

#pragma mark - AYLAddWordViewControllerDelegate
-(void)addWordViewController:(AYLAddWordViewController *)vc backAction:(NSString *)inputStr{
    NSDictionary *dic = @{@"text":inputStr};
    [self.dataList addObject:dic];
    [self.tableView reloadData];
}



-(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}

@end
