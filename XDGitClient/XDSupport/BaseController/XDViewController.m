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
    [self showLoadingViewWithRequestOperation:nil];
}

- (void)showLoadingViewWithRequestOperation:(AFHTTPRequestOperation *)requestOperation
{
    [[XDViewManager defaultManager] showLoadingViewWithTitle:@"数据申请..." requestOperation:requestOperation];
}

- (void)hideLoadingView
{
    [[XDViewManager defaultManager] hideLoadingView];
}

@end
