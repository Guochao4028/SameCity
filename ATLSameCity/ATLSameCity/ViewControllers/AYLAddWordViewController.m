//
//  AYLAddWordViewController.m
//  ATLSameCity
//
//  Created by AYLiOS on 2018/12/7.
//  Copyright © 2018年 AYLiOS. All rights reserved.
//

#import "AYLAddWordViewController.h"

@interface AYLAddWordViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation AYLAddWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"请输入文案";
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initUI{
    UIBarButtonItem *leftBackItem = [UIFactory createLeftArrowBarButtonItemWithTarget:self withAction:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftBackItem;
}


-(void)back{
    
    if ([self.delegate respondsToSelector:@selector(addWordViewController:backAction:)] == YES) {
        [self.delegate addWordViewController:self backAction:self.textView.text];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
