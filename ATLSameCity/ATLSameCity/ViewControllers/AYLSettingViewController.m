//
//  AYLSettingViewController.m
//  ATLSameCity
//
//  Created by AYLiOS on 2018/12/13.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//

#import "AYLSettingViewController.h"

#import "AYLLogViewController.h"

@interface AYLSettingViewController ()
- (IBAction)exitAction:(id)sender;
- (IBAction)regActin:(id)sender;

@end

@implementation AYLSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"设置";
    
    UIBarButtonItem *leftBackItem = [UIFactory createLeftArrowBarButtonItemWithTarget:self withAction:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftBackItem;
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)exitAction:(id)sender {
    
    NSString *where = [NSString stringWithFormat:@"userName = '%@'and passWord = '%@'",[[UserModel shareInstance] userName], [[UserModel shareInstance] passWord]];
    NSString *setStr = @"isLogin = '0'";
    [[DBManager shareInstance]update:where newValues:@"1" cums:setStr table:@"userInfo"];
    [[UserModel shareInstance]setIsLogin:NO];
}

- (IBAction)regActin:(id)sender {
    AYLLogViewController * controller = [[AYLLogViewController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}
@end
