//
//  AYLMainViewController.m
//  ATLSameCity
//
//  Created by AYLiOS on 2018/12/6.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//

#import "AYLMainViewController.h"
#import "DefinedKeys.h"
#import "AYLNavgationView.h"
#import "UIViewController+CWLateralSlide.h"
#import "AYLLeftViewController.h"
#import "CityViewController.h"
#import "ZDBannerTableViewCell.h"
#import "ZDWebViewController.h"
#import "HomeContentCell.h"
#import "AYLLocalCityViewController.h"
#import "PublishModel.h"
#import "AYShowViewController.h"

static NSString *cellIdentifier = @"cellIdentifier";

static NSString *homeContentCellIdentifier = @"HomeContentCell";

@interface AYLMainViewController ()<AYLNavgationViewDelegate, UITableViewDataSource, UITableViewDelegate, ZDBannerTableViewCellDelegate>

@property(nonatomic, strong)AYLNavgationView *navgationView;
@property(nonatomic, strong)AYLLeftViewController *leftVC;

@property (nonatomic,strong)NSArray  *dataSource;//数据源
@property (nonatomic,strong)UITableView  *tableView;
@property (nonatomic,strong)NSArray  *bannerArray;//banner数据

@property (nonatomic, strong)NSString *currentCityString;

@end

@implementation AYLMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    self.currentCityString = @"北京";
    
    [self setupRefresh];
    
    // 注册手势驱动
    __weak typeof(self)weakSelf = self;
    [self cw_registerShowIntractiveWithEdgeGesture:NO transitionDirectionAutoBlock:^(CWDrawerTransitionDirection direction) {
        if (direction == CWDrawerTransitionFromLeft) { // 左侧滑出
            [weakSelf defaultAnimationFromLeft];
        }
    }];
}

// 下拉刷新
- (void)setupRefresh {
    NSLog(@"setupRefresh -- 下拉刷新");
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    [refreshControl beginRefreshing];
    [self refreshClick:refreshControl];
}
// 下拉刷新触发，在此获取数据
- (void)refreshClick:(UIRefreshControl *)refreshControl {
    
    
    [UserModel shareInstance].cityName = self.currentCityString;
    
    NSString *conditionsString = [NSString stringWithFormat:@"cityName = '%@'", self.currentCityString];
    self.dataSource = [[DBManager shareInstance]queryData:conditionsString table:@"publishInfo"];
    
    // 此处添加刷新tableView数据的代码
    [refreshControl endRefreshing];
    [self.tableView reloadData];// 刷新tableView即可
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}


#pragma mark - private
//初始化UI
-(void)initUI{
    CGFloat statusHeight = 0.0;
    if (StatusBarHeight > 20) {
        statusHeight = 20;
    }
    self.navgationView = [[AYLNavgationView alloc]initWithFrame:CGRectMake(0, statusHeight, ScreenWidth, NavigatorHeight)];
    [self.navgationView setDelegate:self];
    [self.view addSubview:self.navgationView];
    
    CGFloat navgationViewY = CGRectGetMaxY(self.navgationView.frame);
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,navgationViewY, ScreenWidth, ScreenHeight-navgationViewY) style:UITableViewStyleGrouped];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZDBannerTableViewCell class]) bundle:nil] forCellReuseIdentifier:kZDBannerTableViewCellIdentifier];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeContentCell class]) bundle:nil] forCellReuseIdentifier:homeContentCellIdentifier];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.view addSubview:self.tableView];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1]];
    
}
//抽屉
- (void)defaultAnimationFromLeft {
    // 强引用leftVC，不用每次创建新的,也可以每次在这里创建leftVC，抽屉收起的时候会释放掉
    [self cw_showDefaultDrawerViewController:self.leftVC];
}

#pragma mark - AYLNavgationViewDelegate
//点击侧滑
-(void)userAction{
    [self defaultAnimationFromLeft];
}

-(void)selectCity{
    CityViewController *cityVC = [[CityViewController alloc]init];
    cityVC.currentCityString=@"北京";
    cityVC.selectString=^(NSString *city){
        self.currentCityString = city;
        [self.navgationView setCityName:city];
    };
    
    [self.navigationController pushViewController:cityVC animated:YES];
}


#pragma mark - UITableViewDataSource && UITableViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else{
        if (self.dataSource.count == 0) {
            return 1;
        }else{
            return self.dataSource.count;
        }
    }
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
    if (indexPath.section == 0) {
        return ScreenWidth * 180/375+100-10;//banner
    }else{
        
        if (self.dataSource.count == 0) {
            return ScreenHeight - (ScreenWidth * 180/375+100-10);
        }else{
            CGFloat rowHeight = 230;
            
            PublishModel *model =  [self.dataSource objectAtIndex:indexPath.row];
           
            if ([model.isCar isEqualToString:@"1"] == NO) {
                NSMutableArray *tem = [NSMutableArray arrayWithArray:model.publishVideoList];
                [tem removeObject:@""];
                model.publishVideoList = [NSArray arrayWithArray:tem];
                
                NSMutableArray *tem1 = [NSMutableArray arrayWithArray:model.publishPicList];
                [tem1 removeObject:@""];
                model.publishPicList = [NSArray arrayWithArray:tem1];
                
                if (model.publishContent.length > 0) {
                    rowHeight = 36+50+22+9;
                }
                
                if ((model.publishPicList.count > 0) || (model.publishVideoList.count > 0)) {
                    rowHeight = 36+50+22+8 + 92;
                }
                
                rowHeight += 10;
            }else{
                rowHeight = 220;
            }
            
            return rowHeight;
        }
    }
}

-(UITableViewCell *) tableView:(UITableView *)tableViews cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell;
    if (indexPath.section == 0) {
        ZDBannerTableViewCell *bannerCell = [tableViews dequeueReusableCellWithIdentifier:kZDBannerTableViewCellIdentifier];
        bannerCell.dataSource = self.bannerArray;
        bannerCell.delegate = self;
        return bannerCell;
    }else{
        if (self.dataSource.count == 0) {
            UITableViewCell *cell = [tableViews dequeueReusableCellWithIdentifier:cellIdentifier];

            [cell setFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - (ScreenWidth * 180/375+100-10))];

            UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"100"]];
            [cell addSubview:imageView];

            CGFloat y =((ScreenHeight - (ScreenWidth * 180/375+100-10)/2) )/2;
            CGFloat x =(ScreenWidth - 280)/2+100;
            [imageView setFrame:CGRectMake(x, y, 280, 280)];
            imageView.center = CGPointMake(cell.center.x, cell.center.y - 100);

            return cell;
        }else{
            HomeContentCell *cell = [tableViews dequeueReusableCellWithIdentifier:homeContentCellIdentifier];
            [cell setModel:[self.dataSource objectAtIndex:indexPath.row]];
            return cell;
        }
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PublishModel *model = [self.dataSource objectAtIndex:indexPath.row];

    if([model.isCar isEqualToString:@"1"] == NO ){
        AYShowViewController *showVC = [[AYShowViewController alloc]init];
        [showVC setModel:model];
        [self.navigationController pushViewController:showVC animated:YES];
    }else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://(010)53630529"]];
    }
}
#pragma mark - TableViewCell Delegate
- (void)pushToOtherViewControllerwithHomeItem:(NSString *)str
{
   // NSInteger type = [str integerValue];
//    switch (type) {
//        case 0:{
//            ZDWebViewController *controller =  [[ZDWebViewController alloc]initWithUrl:@"https://www.dizhubi.com/upload/poster1.jpg" title:@"招聘"];
//            controller.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:controller animated:YES];
//        }
//            break;
//        case 2:{
//            ZDWebViewController *controller =  [[ZDWebViewController alloc]initWithUrl:@"https://www.veer.com/" title:@"城市"];
//            controller.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:controller animated:YES];
//        }
//            break;
//        default:{
//            ZDWebViewController *controller =  [[ZDWebViewController alloc]initWithUrl:@"https://www.dizhubi.com" title:@"城市"];
//            controller.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:controller animated:YES];
//        }
//            break;
//    }

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.y;
    if (offset >= ScreenWidth * 180/375+100-10) {
        [self.navgationView setIsChange:YES];
    }else{
        [self.navgationView setIsChange:NO];
    }
}

#pragma mark - ZDBannerTableViewCell Delegate

- (void)selectNavItemWithType:(NSString *)type
{
    if([type isEqualToString:@"同城爆料"]==YES){
        AYLLocalCityViewController *cityVC = [[AYLLocalCityViewController alloc]init];
        cityVC.type = 0;
        [self.navigationController pushViewController:cityVC animated:YES];
    }else if([type isEqualToString:@"求职招聘"]==YES){
        AYLLocalCityViewController *cityVC = [[AYLLocalCityViewController alloc]init];
        cityVC.type = 1;
        [self.navigationController pushViewController:cityVC animated:YES];
    }else if([type isEqualToString:@"同城拼车"]==YES){
        AYLLocalCityViewController *cityVC = [[AYLLocalCityViewController alloc]init];
        cityVC.type = 2;
        [self.navigationController pushViewController:cityVC animated:YES];
    }else if([type isEqualToString:@"租房售房"]==YES){
        AYLLocalCityViewController *cityVC = [[AYLLocalCityViewController alloc]init];
        cityVC.type = 3;
        [self.navigationController pushViewController:cityVC animated:YES];
    }
}

-(void)selectJumpPage:(NSInteger)type{
    AYLLocalCityViewController *cityVC = [[AYLLocalCityViewController alloc]init];
    cityVC.type = type;
    [self.navigationController pushViewController:cityVC animated:YES];
    
}

#pragma mark - getter/ setter
- (AYLLeftViewController *)leftVC {
    if (_leftVC == nil) {
        _leftVC = [[AYLLeftViewController alloc]init];
    }
    return _leftVC;
}

-(NSArray *)bannerArray{
    if (_bannerArray == nil) {
        _bannerArray = @[@"0", @"10", @"11", @"12", @"13", @"14"];
    }
    return _bannerArray;
}


@end
