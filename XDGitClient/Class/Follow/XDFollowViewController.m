//
//  XDFollowViewController.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDFollowViewController.h"

#import "XDTableViewCell.h"
#import "XDAccountCardViewController.h"

@interface XDFollowViewController ()
{
    BOOL _isFollowers;
}

@end

@implementation XDFollowViewController

- (id)initWithFollowers:(BOOL)isFollowers
{
    self = [self initWithUserName:nil isFollowers:isFollowers];
    if (self) {
    }
    
    return self;
}

- (id)initWithUserName:(NSString *)userName isFollowers:(BOOL)isFollowers
{
    self = [super initWithUsername:userName];
    if (self) {
        _isFollowers = isFollowers;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - data

- (void)requestDataWithRefresh:(BOOL)isRefresh
{
    __block __weak XDFollowViewController *weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AFHTTPRequestOperation *operation = nil;
        if (_isFollowers) {
            operation = [[XDGithubEngine shareEngine] followers:self.userName page:self.page success:^(id object, BOOL haveNextPage) {
                if (isRefresh) {
                    [weakSelf.dataArray removeAllObjects];
                }
                weakSelf.haveNextPage = haveNextPage;
                
                if (object) {
                    for (NSDictionary *dic in object) {
                        AccountModel *model = [[AccountModel alloc] initWithDictionary:dic];
                        [weakSelf.dataArray addObject:model];
                    }
                    
                    [weakSelf tableViewDidFinishHeaderRefresh];
                }
            } failure:^(NSError *error) {
                [weakSelf tableViewDidFailHeaderRefresh];
            }];
        }
        else{
            operation = [[XDGithubEngine shareEngine] following:self.userName page:self.page success:^(id object, BOOL haveNextPage) {
                if (isRefresh) {
                    [weakSelf.dataArray removeAllObjects];
                }
                weakSelf.haveNextPage = haveNextPage;
                
                if (object) {
                    for (NSDictionary *dic in object) {
                        AccountModel *model = [[AccountModel alloc] initWithDictionary:dic];
                        [weakSelf.dataArray addObject:model];
                    }
                    
                    [weakSelf tableViewDidFinishHeaderRefresh];
                }
            } failure:^(NSError *error) {
                [weakSelf tableViewDidFailHeaderRefresh];
            }];
        }
        [self showLoadingViewWithRequestOperation:operation];
    });

}

@end
