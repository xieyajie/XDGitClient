//
//  XDGridViewController.m
//  leCar
//
//  Created by xieyajie on 14-1-13.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDGridViewController.h"

@interface XDGridViewController ()

@end

@implementation XDGridViewController

@synthesize gridView = _gridView;
@synthesize gridStyle = _gridStyle;

- (id)initWithGridStyle:(NRGridViewLayoutStyle)style
{
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        _gridStyle = style;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _gridStyle = NRGridViewLayoutStyleVertical;
        _clearsSelectionOnViewWillAppear = NO;
        _showRefreshHeader = NO;
        _showRefreshFooter = NO;
        _showTableBlankView = NO;
        
        _cursorString = @"";
    }
    return self;
}

- (void)loadView
{
    if([self nibName] != nil)
    {
        [super loadView];
    }
    else
    {
        // Create the gridView manually
        NRGridView *tempGridView = [[NRGridView alloc] initWithLayoutStyle:[self gridStyle]];
        [tempGridView setCellSize:CGSizeMake(160, 120)];
        [tempGridView setDelegate:self];
        [tempGridView setDataSource:self];
        
        [self setGridView:tempGridView];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    __block XDGridViewController *weakSelf = self;
    [self.gridView addPullToRefreshWithActionHandler:^{
        [weakSelf gridViewDidTriggerHeaderRefresh];
    }];
    [self.gridView addInfiniteScrollingWithActionHandler:^{
        [weakSelf gridViewDidTriggerFooterRefresh];
    }];
    
    self.gridView.showsPullToRefresh = self.showRefreshHeader;
    self.gridView.showsInfiniteScrolling = self.showRefreshFooter;
//    self.gridView =
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.clearsSelectionOnViewWillAppear) {
        [self.gridView deselectCellAtIndexPath:self.gridView.selectedCellIndexPath animated:animated];
    }
}

#pragma mark - getter

- (NRGridViewLayoutStyle)gridStyle
{
    if([self isViewLoaded])
    {
        return [self.gridView layoutStyle];
    }
    
    return _gridStyle;
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

#pragma mark - setter

- (void)setView:(UIView *)view
{
    // Raise an exception if 'view' is not an instance of NRGridView.
    NSAssert([view isKindOfClass:[NRGridView class]] || view == nil, @"NRGridViewController -setView: method only supports view which class is NRGridView");
    [super setView:view];
    
    if([self gridView] != view)
    {
        [self setGridView:(NRGridView*)view];
    }
}

- (void)setGridView:(NRGridView *)gridView
{
    if(_gridView != gridView)
    {
        _gridView = gridView;
        [self setView:gridView];
    }
}

- (void)setShowRefreshHeader:(BOOL)showRefreshHeader
{
    if (_showRefreshHeader != showRefreshHeader) {
        _showRefreshHeader = showRefreshHeader;
        self.gridView.showsPullToRefresh = _showRefreshHeader;
    }
}

- (void)setShowRefreshFooter:(BOOL)showRefreshFooter
{
    if (_showRefreshFooter != showRefreshFooter) {
        _showRefreshFooter = showRefreshFooter;
        self.gridView.showsInfiniteScrolling = _showRefreshFooter;
    }
}

- (void)setShowTableBlankView:(BOOL)showTableBlankView
{
    if (_showTableBlankView != showTableBlankView) {
        _showTableBlankView = showTableBlankView;
    }
}

#pragma mark - GridView DataSource

- (NSInteger)gridView:(NRGridView *)gridView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}

- (NRGridViewCell*)gridView:(NRGridView *)gridView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* GridCellIdentifier = @"GridCellIdentifier";
    NRGridViewCell* cell = [gridView dequeueReusableCellWithIdentifier:GridCellIdentifier];
    
    if(cell == nil)
    {
        cell = [[NRGridViewCell alloc] initWithReuseIdentifier:GridCellIdentifier];
    }
    
    return cell;
}

#pragma mark - public refresh

/**
 *  下拉刷新事件
 */
- (void)gridViewDidTriggerHeaderRefresh
{
    
}

/**
 *  上拉加载事件
 */
- (void)gridViewDidTriggerFooterRefresh
{
    
}

/**
 *  下拉刷新回调，刷新表视图
 */
- (void)gridViewDidFinishHeaderRefresh
{
    [self gridViewDidFinishHeaderRefreshReload:YES];
}

///下拉刷新回调
- (void)gridViewDidFinishHeaderRefreshReload:(BOOL)reload
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.gridView.pullToRefreshView stopAnimating];
        
        if (reload) {
            [self.gridView reloadData];
        }
    });
}

///上拉刷新回调，刷新表视图
- (void)gridViewDidFinishFooterRefresh
{
    [self gridViewDidFinishFooterRefreshReload:YES];
}

///上拉刷新回调
- (void)gridViewDidFinishFooterRefreshReload:(BOOL)reload
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.gridView.infiniteScrollingView stopAnimating];
        
        if (reload) {
            [self.gridView reloadData];
        }
    });
}


@end
