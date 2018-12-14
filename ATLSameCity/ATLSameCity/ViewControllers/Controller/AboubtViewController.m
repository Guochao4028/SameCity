//
//  AoubtViewController.m
//  Real
//
//  Created by WangShuChao on 15/7/23.
//  Copyright (c) 2015年 真的网络科技公司. All rights reserved.
//

#import "AboubtViewController.h"
#import "AYLAboutVersionViewController.h"



@interface AboubtViewController ()
{
    UITableView * tableView;
    UIView * rightArrow;
    UILabel *redNewLabel;
    UILabel *newVersionLabel;
}

@end
static NSString * cellIdentifier = @"about";
@implementation AboubtViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
}

-(void) initUI{
    self.title = @"关于我们";
    self.view.backgroundColor = [UIColor whiteColor];
    
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0 , ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator  = NO;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier ];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    [self setExtraCellLineHidden:tableView];
    [self.view addSubview:tableView];
    
    UIBarButtonItem * left =  [self createLeftArrowBarButtonItemWithTarget:self withAction:@selector(back)];
    self.navigationItem.leftBarButtonItem = left;

    UILabel * copyRight = [[UILabel alloc] initWithFrame:CGRectMake(0, ScreenHeight-43, ScreenWidth, 43)];
    copyRight.text = @"© 2015-2016 zhen-de.com.all rights reserved.";
    copyRight.textColor = [UIColor colorWithRed:216.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:0.99];
    copyRight.textAlignment = NSTextAlignmentCenter;
    copyRight.font = [UIFont systemFontOfSize:11];
    
    [self.view addSubview:copyRight];
}

- (void)setExtraCellLineHidden: (UITableView *)tableViews
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableViews setTableFooterView:view];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UIView*) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footer = [[UIView alloc] init];
    footer.backgroundColor = [UIColor clearColor];
    return footer;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:{
            return 332/2;
        }
            break;
        case 1:{
            return 93/2;
        }
            break;
    }
    return 0;
  }

-(UITableViewCell*) tableView:(UITableView *)tableViews cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableViews dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    cell.backgroundColor = [UIColor whiteColor];
    
    if (indexPath.section == 0) {
        //
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 332/2)];
        view.backgroundColor = [UIColor whiteColor];
        
        UIImageView * icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
        icon.frame = CGRectMake((ScreenWidth - 150)/2.0f, 0, 150, 150);
        
        UILabel * versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 238/2, ScreenWidth, 15)];
        versionLabel.text = @"版本：1.0.0";
        versionLabel.textColor = [UIColor blackColor];
        versionLabel.font = [UIFont systemFontOfSize:15];
        versionLabel.textAlignment = NSTextAlignmentCenter;
        
        [view addSubview:icon];
        [view addSubview:versionLabel];
        
        [cell.contentView addSubview:view];
        
    }else{
    
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 93/2)];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, ScreenWidth - 20, 93/2)];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:label];
        switch (indexPath.row) {
            case 0:{
                rightArrow =[self createRightArrowView];
                CGFloat width =rightArrow.frame.size.width;
                CGFloat height = rightArrow.frame.size.height;
                rightArrow.frame = CGRectMake(ScreenWidth - 75/2 - width, (42 - height)/2.0f, width, height);
                [label addSubview:rightArrow];
                label.text = @"版本介绍";
                break;
            }
        }
        [view addSubview:label];
        [cell.contentView addSubview:view];
    }
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 1:{
            if (indexPath.row == 0) {
                //版本介绍
                AYLAboutVersionViewController * controller = [[AYLAboutVersionViewController alloc] init];
                controller.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:controller animated:YES];
            }
        }
            break;
            
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(UIBarButtonItem *) createLeftArrowBarButtonItemWithTarget:(id)target withAction:(SEL)action{
    
    UIImageView *arrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow"]];
    arrow.frame = CGRectMake(0, 0, 30, 40);
    arrow.contentMode = UIViewContentModeLeft;
    [arrow setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
    [arrow addGestureRecognizer:tapGest];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:arrow];
    return item;
}

-(UIView*) createRightArrowView{
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 14)];
    UIImageView * rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightArrow"]];
    rightArrow.frame = CGRectMake(0, 0, 8, 14);
    [view addSubview:rightArrow];
    return view;
}


@end
