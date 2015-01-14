//
//  XDWebViewController.m
//  XDGitClient
//
//  Created by dhcdht on 15-1-5.
//  Copyright (c) 2015年 XDIOS. All rights reserved.
//

#import "XDWebViewController.h"

@interface XDWebViewController ()
{
    UIWebView *_webView;
    
    NSString *_urlPath;
    NSString *_htmlString;
}

@end

@implementation XDWebViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    
    return self;
}

- (instancetype)initWithUrlPath:(NSString *)urlPath
{
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        _urlPath = urlPath;
    }
    
    return self;
}

- (instancetype)initWithHtmlString:(NSString *)htmlString
{
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        _htmlString = htmlString;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _webView.backgroundColor = [UIColor clearColor];
    _webView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:_webView];
    
    if ([_htmlString length] > 0) {
        [_webView loadHTMLString:_htmlString baseURL:nil];
    }
    else if ([_urlPath length] > 0){
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_urlPath]];
        [_webView loadRequest:request];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - public

- (void)loadHtmlString:(NSString *)htmlString
{
    _htmlString = htmlString;
    if ([_htmlString length] > 0) {
        [_webView loadHTMLString:_htmlString baseURL:nil];
    }
}

- (void)loadPath:(NSString *)path
{
    _urlPath = path;
    if ([_urlPath length] > 0) {
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_urlPath]];
        [_webView loadRequest:request];
    }
}

- (void)closeWithDismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)closeWithPop
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
