//
//  XDGridViewController.h
//  leCar
//
//  Created by xieyajie on 14-1-13.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDViewController.h"

#import "NRGridView.h"
#import "XDGridViewCell.h"
#import "SVPullToRefresh.h"

@interface XDGridViewController : XDViewController<NRGridViewDataSource, NRGridViewDelegate>

@property (strong, nonatomic) NRGridView *gridView;
@property (nonatomic, readonly) NRGridViewLayoutStyle gridStyle;
@property (nonatomic) BOOL clearsSelectionOnViewWillAppear;

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableDictionary *dataDictionary;
@property (strong, nonatomic) NSString *cursorString;

@property (nonatomic) BOOL showRefreshHeader;//是否支持下拉刷新
@property (nonatomic) BOOL showRefreshFooter;//是否支持上拉加载
@property (nonatomic) BOOL showTableBlankView;//是否显示无数据时默认背景

- (id)initWithGridStyle:(NRGridViewLayoutStyle)style;

- (void)gridViewDidTriggerHeaderRefresh;//下拉刷新事件
- (void)gridViewDidTriggerFooterRefresh;//上拉加载事件

- (void)gridViewDidFinishHeaderRefresh;//下拉刷新回调，刷新表视图
- (void)gridViewDidFinishHeaderRefreshReload:(BOOL)reload;//下拉刷新回调
- (void)gridViewDidFinishFooterRefresh;//上拉刷新回调，刷新表视图
- (void)gridViewDidFinishFooterRefreshReload:(BOOL)reload;//上拉刷新回调

@end
