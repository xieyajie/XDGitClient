//
//  XDPullRequestsViewController.m
//  XDGitClient
//
//  Created by dhcdht on 14-2-22.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDPullRequestsViewController.h"

#import "PullRequestModel.h"
#import "XDPullRequestCell.h"

@interface XDPullRequestsViewController ()
{
    NSString *_repoFullName;
    XDPullRequestState _state;
}

@end

@implementation XDPullRequestsViewController

- (id)initWithRepoFullName:(NSString *)fullName
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        _repoFullName = fullName;
        _state = XDPullRequestStateClosed;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.showRefreshHeader = YES;
    
    [self tableViewDidTriggerHeaderRefresh];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PullRequestCell";
    XDPullRequestCell *cell = (XDPullRequestCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[XDPullRequestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    PullRequestModel *model = [self.dataArray objectAtIndex:indexPath.row];
    if (model) {
        cell.model = model;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PullRequestModel *model = [self.dataArray objectAtIndex:indexPath.row];
    return [XDPullRequestCell heightWithModel:model];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - data

- (void)fetchDataAtPage:(NSInteger)page isHeaderRefresh:(BOOL)isHeaderRefresh
{
    __block __weak XDPullRequestsViewController *weakSelf = self;
    AFHTTPRequestOperation *operation = [[XDGithubEngine shareEngine] pullRequestsForRepository:_repoFullName state:_state page:page success:^(id object, BOOL haveNextPage) {
        if (isHeaderRefresh) {
            [weakSelf.dataArray removeAllObjects];
        }
        weakSelf.haveNextPage = haveNextPage;
        
        if (object) {
            for (NSDictionary *dic in object) {
                PullRequestModel *model = [[PullRequestModel alloc] initWithDictionary:dic];
                [weakSelf.dataArray addObject:model];
            }
        }
        
        if (isHeaderRefresh) {
            [weakSelf tableViewDidFinishHeaderRefresh];
        }
        else{
            [weakSelf tableViewDidFinishFooterRefresh];
        }
    } failure:^(NSError *error) {
        if (isHeaderRefresh) {
            [weakSelf tableViewDidFailHeaderRefresh];
        }
        else{
            [weakSelf tableViewDidFailFooterRefresh];
        }
    }];
    
    [self showLoadingViewWithRequestOperation:operation];
}

@end
