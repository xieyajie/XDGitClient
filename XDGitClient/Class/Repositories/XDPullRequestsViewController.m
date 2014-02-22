//
//  XDPullRequestsViewController.m
//  XDGitClient
//
//  Created by dhcdht on 14-2-22.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDPullRequestsViewController.h"

@interface XDPullRequestsViewController ()
{
    NSString *_repoFullName;
}

@end

@implementation XDPullRequestsViewController

- (id)initWithRepoFullName:(NSString *)fullName
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        _repoFullName = fullName;
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



#pragma mark - data

- (void)requestDataWithRefresh:(BOOL)isRefresh
{
    __block __weak XDPullRequestsViewController *weakSelf = self;
    AFHTTPRequestOperation *operation = [[[XDRequestManager defaultManager] activityGitEngine] pullRequestsForRepository:_repoFullName page:self.page success:^(id object, BOOL haveNextPage) {
        if (isRefresh) {
            [weakSelf.dataArray removeAllObjects];
        }
        weakSelf.haveNextPage = haveNextPage;
        
        if (object) {
            for (NSDictionary *dic in object) {
                
            }
            
            [weakSelf tableViewDidFinishHeaderRefresh];
        }
    } failure:^(NSError *error) {
        [weakSelf tableViewDidFailHeaderRefresh];
    }];
    
    [self showLoadingViewWithRequestOperation:operation];
}

- (void)tableViewDidTriggerHeaderRefresh
{
    self.page = 1;
    [self requestDataWithRefresh:YES];
}

- (void)tableViewDidTriggerFooterRefresh
{
    self.page++;
    [self requestDataWithRefresh:NO];
}

@end
