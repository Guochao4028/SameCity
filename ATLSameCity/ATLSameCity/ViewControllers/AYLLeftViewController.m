//
//  AYLLeftViewController.m
//  ATLSameCity
//
//  Created by AYLiOS on 2018/12/6.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//

#import "AYLLeftViewController.h"
#import "AYLUserTouXingView.h"
#import "AboubtViewController.h"
#import "UIViewController+CWLateralSlide.h"
#import "AYLLogViewController.h"
#import "AYLSettingViewController.h"

@interface AYLLeftViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UINavigationControllerDelegate>{
    
    UITableView * tableView;
    NSArray * titles;
    UILabel *redNewLabel;
}

@property(nonatomic)CGFloat width;

@end
static NSString * settingCell = @"settingCell";
@implementation AYLLeftViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [self initUI];
    [super viewDidAppear:animated];
}

-(void) initUI
{
    self.width = [UserModel shareInstance].translationX;
    self.view.backgroundColor = [UIColor whiteColor];
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.width, ScreenHeight) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:settingCell];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.backgroundColor = [UIColor colorWithRed:244.0f/255.0f green:247.0f/255.0f blue:248.0f/255.0f alpha:0.99];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    [self setExtraCellLineHidden:tableView];
}

- (void)setExtraCellLineHidden: (UITableView *)tableViews
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableViews setTableFooterView:view];
}

-(UIView*) createRightArrowView
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 14)];
    UIImageView * rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightArrow"]];
    rightArrow.frame = CGRectMake(0, 0, 8, 14);
    [view addSubview:rightArrow];
    return view;
}

-(UILabel*) createLineWithFrame:(CGRect)frame
{
    UILabel *line = [[UILabel alloc] initWithFrame:frame];
    line.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:237.0/255.0 blue:237.0/255.0 alpha:0.99];
    return line;
}

-(UIView*) createRow:(NSString*) title isScreenWidth:(BOOL) isScreenWidth
{
    UIView* row = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 42)];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(34/2, 0, ScreenWidth /2.0f, 42)];
    label.text = title;
    label.textColor =  [UIColor colorWithRed:60.0f/255.0f green:60.0f/255.0f blue:60.0f/255.0f alpha:0.99];
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentLeft;
    
    UIView * rightArrow =[self createRightArrowView];
    CGFloat width =rightArrow.frame.size.width;
    CGFloat height = rightArrow.frame.size.height;
    rightArrow.frame = CGRectMake(self.width - 15 - width, (42 - height)/2.0f, width, height);
    
    [row addSubview:label];
    [row addSubview:rightArrow];
    
    UILabel * topLine;
    if (isScreenWidth) {
        topLine= [self createLineWithFrame:CGRectMake(0, 0, self.width, 0.5)];
    }else{
        topLine = [self createLineWithFrame:CGRectMake(0, 0, self.width, 0.5)];
    }
    [row addSubview:topLine];
    return row;
}

#pragma mark - tableView
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * header = [[UIView alloc] init];
    header.backgroundColor = [UIColor clearColor];
    return header;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

-(UIView*) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:{
            return 139.3;
        }
        default:{
            return 47.3;
        }
    }
}

-(UITableViewCell*) tableView:(UITableView *)tableViews cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableViews dequeueReusableCellWithIdentifier:settingCell forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    cell.backgroundColor = [UIColor whiteColor];
    
    switch (indexPath.row) {
        case 0:{
            cell.backgroundColor = [UIColor clearColor];
            AYLUserTouXingView *touxingView = [[AYLUserTouXingView alloc]initWithFrame:cell.bounds];
            UserModel *model = [UserModel shareInstance];
            if (model.isLogin == YES) {
                [touxingView setModel:model];
            }
            [cell.contentView addSubview:touxingView];
            break;
        }
        case 1:{
            UIView * view = [self createRow:@"关于我们" isScreenWidth:YES];
            [cell.contentView addSubview:view];
            break;
        }
        case 2:{
            UIView * view = [self createRow:@"客服电话:010-5363-0529" isScreenWidth:YES];
            [cell.contentView addSubview:view];
            break;
        }
        case 3:{
            UIView * view = [self createRow:@"分享" isScreenWidth:YES];
            [cell.contentView addSubview:view];
            break;
        }
        case 4:{
            UIView * view = [self createRow:@"设置" isScreenWidth:YES];
            [cell.contentView addSubview:view];
            break;
        }
    }
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:{
            AYLLogViewController * controller = [[AYLLogViewController alloc] init];
            controller.hidesBottomBarWhenPushed = YES;
            [self cw_pushViewController:controller];
        }break;
        case 1:{
            AboubtViewController * controller = [[AboubtViewController alloc] init];
            controller.hidesBottomBarWhenPushed = YES;
            [self cw_pushViewController:controller];
        }
            break;
        case 2:{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://(010)53630529"]];
        }
            break;
        case 3:{
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
            break;
            
        case 4:{
            AYLSettingViewController * controller = [[AYLSettingViewController alloc] init];
            controller.hidesBottomBarWhenPushed = YES;
            [self cw_pushViewController:controller];
        }
            break;
            
    }
}


@end
