//
//  XDWatchersViewController.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-21.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDWatchersViewController.h"

@interface XDWatchersViewController ()
{
    NSString *_fullName;
}

@end

@implementation XDWatchersViewController

- (id)initWithRepoFullname:(NSString *)fullName
{
    self = [super init];
    if (self) {
        // Custom initialization
        _fullName = fullName;
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

- (void)fetchDataAtPage:(int)page isHeaderRefresh:(BOOL)isHeaderRefresh
{
    if (_fullName == nil || _fullName.length == 0) {
        return;
    }
    
    __block __weak XDWatchersViewController *weakSelf = self;
    AFHTTPRequestOperation *operation = [[DXGithubEngine shareEngine] watchersForRepository:_fullName page:page success:^(id object, BOOL haveNextPage) {
        if (isHeaderRefresh) {
            [weakSelf.dataArray removeAllObjects];
        }
        weakSelf.haveNextPage = haveNextPage;
        
        if (object) {
            for (NSDictionary *dic in object) {
                UserModel *model = [[UserModel alloc] initWithDictionary:dic];
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
