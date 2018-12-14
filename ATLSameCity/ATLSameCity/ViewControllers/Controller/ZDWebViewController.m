//
//  ZDWebViewController.m
//  Real
//
//  Created by WangShuChao on 15/9/29.
//  Copyright (c) 2015年 真的网络科技公司. All rights reserved.
//
#import "ZDWebViewController.h"
#import "WebViewJavascriptBridge.h"

@interface ZDWebViewController (){
    UIWebView * webView;
    NJKWebViewProgress *progressProxy;
    NJKWebViewProgressView * progressView;
    NSString * loadUrl;
    NSString * title;
}
@end

@implementation ZDWebViewController

-(instancetype) initWithUrl:(NSString*) url title:(NSString*) name{
    self = [super init];
    loadUrl = url;
    title = name;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
}

-(void) initUI{

    self.title = title;
    UIBarButtonItem * leftItem =  [self createLeftArrowBarButtonItemWithTarget:self withAction:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftItem;

    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    progressView.progress = 0;
//    progressView.progressBarView.backgroundColor = [UIColor redColor];
    progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self.navigationController.navigationBar addSubview:progressView];
    
    progressProxy = [[NJKWebViewProgress alloc] init]; // instance variable
    progressProxy.webViewProxyDelegate = self;
    progressProxy.progressDelegate = self;
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    webView.backgroundColor = [UIColor whiteColor];
    webView.delegate = progressProxy;
   
    [WebViewJavascriptBridge enableLogging];
    
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:loadUrl]];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [webView loadRequest:request];
    
    [self.view addSubview:webView];
}

-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress{
    [progressView setProgress:progress animated:NO];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    if (error) {
        [progressView setProgress:1 animated:NO];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

    [progressView removeFromSuperview];
}
#pragma mark delegate

-(void) back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
