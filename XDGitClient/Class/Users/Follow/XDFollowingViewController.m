//
//  XDFollowingViewController.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDFollowingViewController.h"

#import "XDTableViewCell.h"
#import "XDAccountCardViewController.h"

@interface XDFollowingViewController ()

@end

@implementation XDFollowingViewController

- (id)initWithUserName:(NSString *)userName
{
    self = [super initWithUsername:userName];
    if (self) {
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"我关注的人";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - data

- (void)requestDataWithRefresh:(BOOL)isRefresh
{
    __block __weak XDFollowingViewController *weakSelf = self;
    AFHTTPRequestOperation *operation = [[XDGithubEngine shareEngine] following:self.userName page:self.page success:^(id object, BOOL haveNextPage) {
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
}

@end
