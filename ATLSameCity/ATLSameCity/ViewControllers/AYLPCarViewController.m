//
//  AYLPCarViewController.m
//  ATLSameCity
//
//  Created by AYLiOS on 2018/12/12.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//

#import "AYLPCarViewController.h"
#import "PublishModel.h"


@interface AYLPCarViewController ()
@property (weak, nonatomic) IBOutlet UITextField *startingPoint;
@property (weak, nonatomic) IBOutlet UITextField *endPoint;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextView *note;
@property (weak, nonatomic) IBOutlet UITextField *price;

@end

@implementation AYLPCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)send{
    NSString *type = @"同城拼车";
    PublishModel *model = [[PublishModel alloc]init];
    model.cityName = [UserModel shareInstance].cityName;
    model.user = [UserModel shareInstance];
    model.publishTime = [self getCurrentTimes];
    model.publishType = [NSString stringWithFormat:@"%ld",self.type];
    model.checkNumber = @"0";
    model.comments = @"0";
    model.giveLike = @"0";
    model.categoryType = type;
    model.isCar = @"1";
    model.startingPoint = self.startingPoint.text;
    model.endPoint = self.endPoint.text;
    model.phone = self.phone.text;
    model.note = self.note.text;
    model.price = self.price.text;
    
    
    
    [[DBManager shareInstance]insertData:model table:@"publishInfo" columns:@"userName, userSculptureImage, publishTime, publishType, checkNumber, comments, giveLike, publishContent, publishPicList, publishVideoList, cityName, categoryType, isCar, startingPoint, endPoint, phone, note, price, videoCover"];
    
    
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSString*)getCurrentTimes{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
}

@end
