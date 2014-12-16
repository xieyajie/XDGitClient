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

- (void)requestDataWithRefresh:(BOOL)isRefresh
{
    if (_fullName == nil || _fullName.length == 0) {
        return;
    }
    
    __block __weak XDWatchersViewController *weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AFHTTPRequestOperation *operation = nil;
        
        operation = [[XDGithubEngine shareEngine] watchersForRepository:_fullName page:self.page success:^(id object, BOOL haveNextPage) {
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
        [self showLoadingViewWithRequestOperation:operation];
    });
}

@end
