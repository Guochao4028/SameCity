//
//  AYLLogViewController.m
//  ATLSameCity
//
//  Created by AYLiOS on 2018/12/13.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//

#import "AYLLogViewController.h"
#import "CLProgressHUD.h"

@interface AYLLogViewController ()
- (IBAction)longinAction:(id)sender;
- (IBAction)regAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


@end

@implementation AYLLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *leftBackItem = [UIFactory createLeftArrowBarButtonItemWithTarget:self withAction:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftBackItem;
    self.title = @"登录";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
}

- (IBAction)longinAction:(id)sender {
    
    BOOL isPhone = [self isChinaMobile:self.phoneTextField.text];
    BOOL isPassword = self.passwordTextField.text.length >= 6 && self.passwordTextField.text.length <= 18 ? YES : NO;
    if (isPhone == YES && isPassword == YES) {
        [CLProgressHUD showInView:self.view delegate:self title:@"正在登录中..." duration:1.0];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0    * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *cun = [NSString stringWithFormat:@"userName = '%@'and passWord = '%@'",self.phoneTextField.text, self.passwordTextField.text];
            NSArray *userList = [[DBManager shareInstance]queryData:cun table:@"userInfo"];
            if (userList.count > 0) {
                
                [[UserModel shareInstance]setIsLogin:YES];
                [[UserModel shareInstance]setUserName:self.phoneTextField.text];
                [[UserModel shareInstance]setPassWord:self.passwordTextField.text];
                [[UserModel shareInstance]setUserSculptureImage:[UIImage imageNamed:@"touxiang"]];
               
                NSString *where = [NSString stringWithFormat:@"userName = '%@'and passWord = '%@'",self.phoneTextField.text, self.passwordTextField.text];
                NSString *setStr = @"isLogin = '1'";
                [[DBManager shareInstance]update:where newValues:@"1" cums:setStr table:@"userInfo"];
                
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                 [CLProgressHUD showInView:self.view delegate:self title:@"手机或密码错误" duration:0.3];
            }
        });
    }else{
        if(isPhone == NO){
            [CLProgressHUD showInView:self.view delegate:self title:@"请输入合法手机号" duration:0.3];
        }else if(isPassword == NO){
            [CLProgressHUD showInView:self.view delegate:self title:@"密码长度错误" duration:0.3];
        }
    }
}

- (IBAction)regAction:(id)sender {
    
    BOOL isPhone = [self isChinaMobile:self.phoneTextField.text];
    BOOL isPassword = self.passwordTextField.text.length >= 6 && self.passwordTextField.text.length <= 18 ? YES : NO;
    if (isPhone == YES && isPassword == YES) {
        [CLProgressHUD showInView:self.view delegate:self title:@"正在注册中..." duration:1.0];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3    * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [[UserModel shareInstance]setIsLogin:YES];
            [[UserModel shareInstance]setUserName:self.phoneTextField.text];
            [[UserModel shareInstance]setPassWord:self.passwordTextField.text];
            [[UserModel shareInstance]setUserSculptureImage:[UIImage imageNamed:@"touxiang"]];
            
            [[DBManager shareInstance]insertData:[UserModel shareInstance] table:@"userInfo" columns:@"userName, userSculptureImage,isLogin,passWord"];
            
            [self.navigationController popViewControllerAnimated:YES];
        });
    }else{
        if(isPhone == NO){
            [CLProgressHUD showInView:self.view delegate:self title:@"请输入合法手机号" duration:0.3];
        }else if(isPassword == NO){
            [CLProgressHUD showInView:self.view delegate:self title:@"密码长度错误" duration:0.3];
        }
    }
    
}


- (BOOL)isChinaMobile:(NSString *)phoneNum
{
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    return [regextestcm evaluateWithObject:phoneNum];
}

@end
