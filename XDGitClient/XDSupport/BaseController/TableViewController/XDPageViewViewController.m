//
//  XDPageViewViewController.m
//  XDGitClient
//
//  Created by dhcdht on 14-12-19.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDPageViewViewController.h"

@interface XDPageViewViewController ()

@end

@implementation XDPageViewViewController

@synthesize page = _page;
@synthesize haveNextPage = _haveNextPage;

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        _page = 1;
        _haveNextPage = NO;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.showRefreshHeader = YES;
    self.showRefreshFooter = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setHaveNextPage:(BOOL)haveNextPage
{
    if (_haveNextPage != haveNextPage) {
        _haveNextPage = haveNextPage;
        
        if (!haveNextPage) {
            self.showRefreshFooter = NO;
        }
    }
}

#pragma mark - public refresh

/**
 *  下拉刷新事件
 */
- (void)tableViewDidTriggerHeaderRefresh
{
    self.page = 1;
    [self fetchDataAtPage:self.page isHeaderRefresh:YES];
}

/**
 *  上拉加载事件
 */
- (void)tableViewDidTriggerFooterRefresh
{
    self.page++;
    [self fetchDataAtPage:self.page isHeaderRefresh:NO];
}

#pragma mark - public fetch data

- (void)fetchDataAtPage:(NSInteger)page isHeaderRefresh:(BOOL)isHeaderRefresh
{
    
}

@end
