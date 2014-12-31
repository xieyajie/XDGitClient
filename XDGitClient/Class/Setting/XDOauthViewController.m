//
//  XDOauthViewController.m
//  XDGitClient
//
//  Created by dhcdht on 14-12-15.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDOauthViewController.h"

#import "XDGithubEngine.h"
#import "XDConfigManager.h"

@interface XDOauthViewController ()<UIWebViewDelegate>
{
    UIButton *_backButton;
    BOOL _isLoadFinish;
}

@property (strong, nonatomic) UIWebView *webView;

@end

@implementation XDOauthViewController

@synthesize webView = _webView;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _isLoadFinish = NO;
        
        _webView = [[UIWebView alloc] init];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _webView.delegate = self;
        [self.view addSubview:_webView];
        
        NSString *path = [[XDGithubEngine shareEngine] requestPathForOauth];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]];
        [_webView loadRequest:request];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _webView.frame = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height);
    
    _backButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 5, 40, 40)];
    [_backButton setTitle:@"返回" forState:UIControlStateNormal];
    [_backButton setTitleColor:[UIColor colorWithRed:48 / 255.0 green:169 / 255.0 blue:55 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [_webView addSubview:_backButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchToken:) name:KNOTIFICATION_GETCODE object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!_isLoadFinish) {
        [self showLoadingViewWithTitle:@"加载github授权页面..."];
    }
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *path = [request.URL absoluteString];
    NSRange range = [path rangeOfString:@"http://www.easemob.com/"];
    if (range.location != NSNotFound) {
        range = [path rangeOfString:@"code="];
        if (range.location != NSNotFound) {
            NSString *code = [path substringFromIndex:(range.location + range.length)];
            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_GETCODE object:code];
        }
    }
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    _isLoadFinish = YES;
    [self hideLoadingView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    _isLoadFinish = YES;
    [self hideLoadingView];
}

#pragma mark - action

- (void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - private

- (void)fetchToken:(NSNotification *)notification
{
    NSString *code = [notification object];
    [[XDGithubEngine shareEngine] fetchTokenWithUsername:nil password:nil code:code success:^(id object) {
        if (object) {
            [[XDConfigManager defaultManager] setLoginToken:object];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOFINSTATECHANGED object:nil];
        }
    } failure:^(NSError *error) {
        
    }];
}

@end