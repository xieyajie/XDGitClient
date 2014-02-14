//
//  XDTableViewController.m
//  XDHoHo
//
//  Created by xieyajie on 13-12-2.
//  Copyright (c) 2013年 XD. All rights reserved.
//

#import "XDTableViewController.h"

@interface XDTableViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableViewStyle _tableViewStyle;
}

@end

@implementation XDTableViewController

- (id)init
{
    self = [super init];
    if (self) {
        _tableViewStyle = UITableViewStylePlain;
        _cursorString = @"";
        
        _showRefreshHeader = NO;
        _showRefreshFooter = NO;
        _showTableBlankView = NO;
    }
    
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [self init];
    if (self) {
        _tableViewStyle = style;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
     __weak XDTableViewController *weakSelf = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf tableViewDidTriggerHeaderRefresh];
    }];
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf tableViewDidTriggerFooterRefresh];
    }];
    
    self.tableView.showsPullToRefresh = self.showRefreshHeader;
    self.tableView.showsInfiniteScrolling = self.showRefreshFooter;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setting

- (void)setShowRefreshHeader:(BOOL)showRefreshHeader
{
    if (_showRefreshHeader != showRefreshHeader) {
        _showRefreshHeader = showRefreshHeader;
        self.tableView.showsPullToRefresh = _showRefreshHeader;
    }
}

- (void)setShowRefreshFooter:(BOOL)showRefreshFooter
{
    if (_showRefreshFooter != showRefreshFooter) {
        _showRefreshFooter = showRefreshFooter;
        self.tableView.showsInfiniteScrolling = _showRefreshFooter;
    }
}

- (void)setShowTableBlankView:(BOOL)showTableBlankView
{
    if (_showTableBlankView != showTableBlankView) {
        _showTableBlankView = showTableBlankView;
    }
}

#pragma mark - getting

- (UITableView *)tableView
{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:_tableViewStyle];
        _tableView.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

- (NSMutableDictionary *)dataDictionary
{
    if (_dataDictionary == nil) {
        _dataDictionary = [NSMutableDictionary dictionary];
    }
    
    return _dataDictionary;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - public refresh

/**
 *  下拉刷新事件
 */
- (void)tableViewDidTriggerHeaderRefresh
{
    
}

/**
 *  上拉加载事件
 */
- (void)tableViewDidTriggerFooterRefresh
{
    
}

/**
 *  下拉刷新回调，刷新表视图
 */
- (void)tableViewDidFinishHeaderRefresh
{
    [self tableViewDidFinishHeaderRefreshReload:YES];
}

///下拉刷新回调
- (void)tableViewDidFinishHeaderRefreshReload:(BOOL)reload
{
    __weak XDTableViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.tableView.pullToRefreshView stopAnimating];
        
        if (reload) {
            [weakSelf.tableView reloadData];
        }
    });
}

///上拉刷新回调，刷新表视图
- (void)tableViewDidFinishFooterRefresh
{
    [self tableViewDidFinishFooterRefreshReload:YES];
}

///上拉刷新回调
- (void)tableViewDidFinishFooterRefreshReload:(BOOL)reload
{
    __weak XDTableViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.tableView.infiniteScrollingView stopAnimating];
        
        if (reload) {
            [weakSelf.tableView reloadData];
        }
    });
}

@end
