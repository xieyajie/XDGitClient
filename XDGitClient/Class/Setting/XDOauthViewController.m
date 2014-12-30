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

@property (strong, nonatomic) UIWebView *webView;

@end

@implementation XDOauthViewController

@synthesize webView = _webView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"登录";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchToken:) name:KNOTIFICATION_GETCODE object:nil];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    NSString *path = [[XDGithubEngine shareEngine] requestPathForOauth];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]];
    [_webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
