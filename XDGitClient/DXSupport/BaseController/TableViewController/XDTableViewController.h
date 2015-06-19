//
//  XDTableViewController.h
//  DXStudio
//
//  Created by xieyajie on 13-12-2.
//  Copyright (c) 2013年 DXStudio. All rights reserved.
//

#import "DXViewController.h"

#import "SVPullToRefresh.h"

@interface XDTableViewController : DXViewController<UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableDictionary *dataDictionary;

@property (nonatomic) BOOL showRefreshHeader;//是否支持下拉刷新
@property (nonatomic) BOOL showRefreshFooter;//是否支持上拉加载
@property (nonatomic) BOOL showTableBlankView;//是否显示无数据时默认背景

- (id)initWithStyle:(UITableViewStyle)style;

- (void)tableViewDidTriggerHeaderRefresh;//下拉刷新事件
- (void)tableViewDidTriggerFooterRefresh;//上拉加载事件

- (void)tableViewDidFinishHeaderRefresh;//下拉刷新回调，刷新表视图
- (void)tableViewDidFailHeaderRefresh;
- (void)tableViewDidFinishHeaderRefreshReload:(BOOL)reload;//下拉刷新回调
- (void)tableViewDidFinishFooterRefresh;//上拉刷新回调，刷新表视图
- (void)tableViewDidFailFooterRefresh;
- (void)tableViewDidFinishFooterRefreshReload:(BOOL)reload;//上拉刷新回调

@end
