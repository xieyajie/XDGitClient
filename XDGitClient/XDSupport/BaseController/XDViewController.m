//
//  XDViewController.m
//  XDUI
//
//  Created by xieyajie on 13-10-14.
//  Copyright (c) 2013年 XD. All rights reserved.
//

#import "XDViewController.h"

@interface XDViewController ()
{
    CGFloat _version;
    
    UIView *_loadingView;
    UIActivityIndicatorView *_activityIndicatorView;
}

@end

@implementation XDViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _version = [[[UIDevice currentDevice] systemVersion] floatValue];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    if (_version >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getting

- (NSString *)barTitle
{
    if (_barTitle == nil) {
        _barTitle = @"";
    }
    
    return _barTitle;
}

- (NSMutableArray *)leftItems
{
    if (_leftItems == nil) {
        _leftItems = [NSMutableArray array];
    }
    
    return _leftItems;
}

- (NSMutableArray *)rightItems
{
    if (_rightItems == nil) {
        _rightItems = [NSMutableArray array];
    }
    
    return _rightItems;
}

#pragma mark - public

- (void)showLoadingView
{
    if (!_loadingView) {
        _loadingView = [[UIView alloc] initWithFrame:self.view.bounds];
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100.0, 100.0)];
        backgroundView.center = _loadingView.center;
        backgroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        backgroundView.layer.cornerRadius = 6.0;
        [_loadingView addSubview:backgroundView];
        
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activityIndicatorView.center = backgroundView.center;
        [_loadingView addSubview:_activityIndicatorView];
        
        [self.view addSubview:_loadingView];
    }
    
    [self.view bringSubviewToFront:_loadingView];
    _loadingView.hidden = NO;
    
    [_activityIndicatorView startAnimating];
}

- (void)hideLoadingView
{
    _loadingView.hidden = YES;
    [_activityIndicatorView stopAnimating];
}

@end
