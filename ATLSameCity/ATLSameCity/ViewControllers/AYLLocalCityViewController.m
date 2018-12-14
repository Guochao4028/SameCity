//
//  AYLLocalCityViewController.m
//  ATLSameCity
//
//  Created by AYLiOS on 2018/12/7.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//

#import "AYLLocalCityViewController.h"
#import "HomeContentCell.h"
#import "AYLPublichViewController.h"
#import "PublishModel.h"
#import "AYLPCarViewController.h"
#import "AYShowViewController.h"
#import "AYLLogViewController.h"

@interface AYLLocalCityViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)UIView * topHeader;

@property(nonatomic, strong)NSArray *dataList;

@property(nonatomic, strong)UIButton *writingButton;


@property(nonatomic, strong)UIButton * top1Button;
@property(nonatomic, strong)UIButton * top2Button;
@property(nonatomic, strong)UIButton * top3Button;
@property(nonatomic, strong)UILabel * slider;

@property(nonatomic, strong)NSArray *titleArray;
@property(nonatomic, strong)UIScrollView * scrollView;


@property(nonatomic, strong)UITableView *top1TableView;
@property(nonatomic, strong)UITableView *top2TableView;
@property(nonatomic, strong)UITableView *top3TableView;

@end


static NSString *cellIdentifier = @"cellIdentifier";

static NSString *homeContentCellIdentifier = @"HomeContentCell";

@implementation AYLLocalCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    switch (self.type) {
        case 0:
            self.title = @"同城爆料";
            break;
        case 1:
            self.title = @"求职招聘";
            self.titleArray = @[@"求职", @"招聘", @"兼职"];
            break;
        case 2:
            self.title = @"同城拼车";
            self.titleArray = @[@"全部", @"车找人", @"人找车"];
            break;
        case 3:
            self.title = @"租房售房";
            self.titleArray = @[@"房屋出租", @"房屋出售", @"求租合租"];
            break;
        default:
            break;
    }
    
    [self initUI];
    
    [super viewWillAppear:animated];
}

-(void)initData{
    
}

-(void)initUI{
    
    UIBarButtonItem *leftBackItem = [UIFactory createLeftArrowBarButtonItemWithTarget:self withAction:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftBackItem;
    
    switch (self.type) {
        case 0:{
            self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
            [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
            
            [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeContentCell class]) bundle:nil] forCellReuseIdentifier:homeContentCellIdentifier];
            
            [self.tableView setDelegate:self];
            [self.tableView setDataSource:self];
            [self.view addSubview:self.tableView];
            [self.tableView setBackgroundColor:[UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1]];
        }
            break;
    
        default:{
            self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40+NavigatorHeight, ScreenWidth, ScreenHeight - 40 - NavigatorHeight)];
            self.scrollView.contentSize = CGSizeMake(3*ScreenWidth, ScreenHeight-40-NavigatorHeight);
            self.scrollView.showsHorizontalScrollIndicator = NO;
            self.scrollView.showsVerticalScrollIndicator = NO;
            self.scrollView.backgroundColor = [UIColor clearColor];
            [self.view addSubview:self.scrollView];
            self.scrollView.delegate = self;
            self.scrollView.pagingEnabled = YES;
            [self initTopHeader];
            [self initTableViews];
        }
            break;
    }
    [self setupRefresh];
    
    self.writingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.writingButton setFrame:CGRectMake(ScreenWidth - 45 -50, ScreenHeight - 45 -100, 45, 45)];
    [self.writingButton setImage:[UIImage imageNamed:@"50"] forState:UIControlStateNormal];
    [self.writingButton addTarget:self action:@selector(pushPublich) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.writingButton];
}


-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void) initTopHeader{
    self.topHeader = [[UIView alloc] initWithFrame:CGRectMake(0, NavigatorHeight, ScreenWidth, 40)];
    
    CGFloat width = ScreenWidth/3;
    CGFloat height = 40;
    UIColor *nomalColor = [UIColor lightGrayColor];
    UIColor *highlightedColor = [UIColor blackColor];
    
    self.top1Button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.top1Button.tag = 0;
    self.top1Button.frame = CGRectMake(0, 0, width, height);
    [self.top1Button setSelected:YES];
    
    self.top2Button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.top2Button.tag = 1;
    self.top2Button.frame = CGRectMake(CGRectGetMaxX(self.top1Button.frame), 0, width, height);
    
    self.top3Button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.top3Button.tag = 2;
    self.top3Button.frame = CGRectMake(CGRectGetMaxX(self.top2Button.frame) , 0, width, height);
   
    
    [self setButton:self.top1Button Withtitle:self.titleArray[0] WithNormalColor:nomalColor withSelectedColor:highlightedColor];
    
    [self setButton:self.top2Button Withtitle:self.titleArray[1] WithNormalColor:nomalColor withSelectedColor:highlightedColor];
    
    [self setButton:self.top3Button Withtitle:self.titleArray[2] WithNormalColor:nomalColor withSelectedColor:highlightedColor];

    [self.top1Button addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.top2Button addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.top3Button addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.topHeader addSubview:self.top1Button];
    [self.topHeader addSubview:self.top2Button];
    [self.topHeader addSubview:self.top3Button];
    [self.view addSubview:self.topHeader];
}

-(void) initTableViews{
    
    
    CGFloat width = ScreenWidth;
    CGFloat height = ScreenHeight -NavigatorHeight- 40;
    
    self.top1TableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    [self.top1TableView setDelegate:self];
    [self.top1TableView setDataSource:self];
    
    self.top2TableView = [[UITableView alloc] initWithFrame:CGRectMake(width, 0, width, height)];
    [self.top2TableView setDelegate:self];
    [self.top2TableView setDataSource:self];
    
    self.top3TableView = [[UITableView alloc] initWithFrame:CGRectMake(2*width, 0, width, height)];
    [self.top3TableView setDelegate:self];
    [self.top3TableView setDataSource:self];
    
    [self.scrollView setScrollsToTop:NO];
    
    [self.top2TableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    
    [self.top2TableView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeContentCell class]) bundle:nil] forCellReuseIdentifier:homeContentCellIdentifier];
    
    [self.top1TableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    
    [self.top1TableView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeContentCell class]) bundle:nil] forCellReuseIdentifier:homeContentCellIdentifier];
    
    [self.top3TableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    
    [self.top3TableView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeContentCell class]) bundle:nil] forCellReuseIdentifier:homeContentCellIdentifier];
    
    
    
    [self.scrollView addSubview:self.top1TableView];
    [self.scrollView addSubview:self.top2TableView];
    [self.scrollView addSubview:self.top3TableView];
    
    [self.top1TableView setBackgroundColor:[UIColor whiteColor]];
    [self.top2TableView setBackgroundColor:[UIColor whiteColor]];
    [self.top3TableView setBackgroundColor:[UIColor whiteColor]];
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollViews{
    CGPoint point =  scrollViews.contentOffset ;
    CGFloat x  = point.x;
    int page = (x + ScreenWidth/2.0f) /ScreenWidth;
    //2:改变颜色
    [self setScrollSelected:page];
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
    
    
    NSString *conditionsString = [NSString stringWithFormat:@"categoryType = '%@' and publishType = '%d'", type,page];
    self.dataList = [[DBManager shareInstance]queryData:conditionsString table:@"publishInfo"];
    
    if (self.type != 2) {
        
        
        if (self.type == 0) {
            NSString *conditionsString = [NSString stringWithFormat:@"categoryType = '%@'", type];
            self.dataList = [[DBManager shareInstance]queryData:conditionsString table:@"publishInfo"];
        }else{
            NSString *conditionsString = [NSString stringWithFormat:@"categoryType = '%@' and publishType = '%d'", type,page];
            self.dataList = [[DBManager shareInstance]queryData:conditionsString table:@"publishInfo"];
        }
    }else{
        if (page == 0) {
            NSString *conditionsString = [NSString stringWithFormat:@"categoryType = '%@'", type];
            self.dataList = [[DBManager shareInstance]queryData:conditionsString table:@"publishInfo"];
        }else{
            NSString *conditionsString = [NSString stringWithFormat:@"categoryType = '%@' and publishType = '%d'", type, (page - 1)];
            self.dataList = [[DBManager shareInstance]queryData:conditionsString table:@"publishInfo"];
        }
    }
 
    [self.top1TableView reloadData];
    [self.top2TableView reloadData];
    [self.top3TableView reloadData];
}

-(void) setScrollSelected:(NSInteger) count{
    if (count == 0) {
        [self.top1Button setSelected:YES];
        [self.top2Button setSelected:NO];
        [self.top3Button setSelected:NO];
    }else if(count == 1){
        [self.top1Button setSelected:NO];
        [self.top2Button setSelected:YES];
        [self.top3Button setSelected:NO];
    }else if(count == 2){
        [self.top1Button setSelected:NO];
        [self.top2Button setSelected:NO];
        [self.top3Button setSelected:YES];
    }
}


-(void) selectButton:(UIButton*) button{
    [self setClickSelected:button.tag];
}

-(void) setClickSelected:(NSInteger) count{
    CGPoint contentOffSet = CGPointMake(count * ScreenWidth, self.scrollView.contentOffset.y);
    [self.scrollView setContentOffset:contentOffSet animated:YES];
}


-(void) setButton:(UIButton *) button Withtitle:(NSString*) title WithNormalColor:(UIColor *) normalColor withSelectedColor:(UIColor*) selectedColor{
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    [button setTitleColor:selectedColor forState:UIControlStateSelected];
    UIFont *font = [UIFont systemFontOfSize:15];
    button.titleLabel.font = font;
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
    // 此处添加刷新tableView数据的代码
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
    if (self.type != 2) {
        if (self.type == 0) {
            NSString *conditionsString = [NSString stringWithFormat:@"categoryType = '%@'", type];
            self.dataList = [[DBManager shareInstance]queryData:conditionsString table:@"publishInfo"];
        }else{
            NSString *conditionsString = [NSString stringWithFormat:@"categoryType = '%@' and publishType = '0'", type];
            self.dataList = [[DBManager shareInstance]queryData:conditionsString table:@"publishInfo"];
        }
        
    }else{
        NSString *conditionsString = [NSString stringWithFormat:@"categoryType = '%@'", type];
        self.dataList = [[DBManager shareInstance]queryData:conditionsString table:@"publishInfo"];
    }
    
    [refreshControl endRefreshing];
    [self.tableView reloadData];// 刷新tableView即可
}
#pragma mark - action
-(void)pushPublich{
    UserModel *user = [UserModel shareInstance];
    
    if (user.isLogin == YES) {
        if(self.type != 2){
            AYLPublichViewController *publishVC = [[AYLPublichViewController alloc]init];
            publishVC.type = self.type;
            [self.navigationController pushViewController:publishVC animated:YES];
        }else{
            
            
            
            UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            // 创建action，这里action1只是方便编写，以后再编程的过程中还是以命名规范为主
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"车找人" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                AYLPCarViewController *carVC = [[AYLPCarViewController alloc]init];
                carVC.type = 0;
                [self.navigationController pushViewController:carVC animated:YES];
            }];
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"点击了取消");
            }];
            UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"人找车" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                //跳到创建alertview的方法，一般在点击删除这里按钮之后，都需要一个提示框，提醒用户是否真的删除
                AYLPCarViewController *carVC = [[AYLPCarViewController alloc]init];
                carVC.type = 1;
                [self.navigationController pushViewController:carVC animated:YES];
            }];
            
            //把action添加到actionSheet里
            [actionSheet addAction:action1];
            [actionSheet addAction:action2];
            [actionSheet addAction:action3];
            
            //相当于之前的[actionSheet show];
            [self presentViewController:actionSheet animated:YES completion:nil];
            
        }
    }else{
     
        AYLLogViewController *loginVC = [[AYLLogViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
        
    }
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataList.count == 0) {
        return 1;
    }else{
        return self.dataList.count;
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
    if (self.dataList.count == 0) {
        return ScreenHeight;
    }else{
        
        CGFloat rowHeight = 230;
        
        PublishModel *model =  [self.dataList objectAtIndex:indexPath.row];
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
        
        return rowHeight+10;
    }
}

-(UITableViewCell *) tableView:(UITableView *)tableViews cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataList.count == 0) {
        
        UITableViewCell *cell = [tableViews dequeueReusableCellWithIdentifier:cellIdentifier];
        
        for (UIView *temp in [cell subviews]) {
            [temp removeFromSuperview];
        }
        
        [cell setFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"100"]];
        [cell addSubview:imageView];
        CGFloat y =((ScreenHeight - (ScreenWidth * 180/375+100-10)/2) )/2;
        CGFloat x =(ScreenWidth - 280)/2+100;
        [imageView setFrame:CGRectMake(x, y, 280, 280)];
        imageView.center = CGPointMake(cell.center.x, cell.center.y - 100);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        HomeContentCell *cell = [tableViews dequeueReusableCellWithIdentifier:homeContentCellIdentifier];
        [cell setModel:[self.dataList objectAtIndex:indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataList.count > 0) {
        if(self.type != 2){
            PublishModel *model = [self.dataList objectAtIndex:indexPath.row];
            AYShowViewController *showVC = [[AYShowViewController alloc]init];
            [showVC setModel:model];
            [self.navigationController pushViewController:showVC animated:YES];
        }else{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://(010)53630529"]];
        }
    }
}


@end
