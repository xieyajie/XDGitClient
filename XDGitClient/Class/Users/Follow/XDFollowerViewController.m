//
//  XDFollowerViewController.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDFollowerViewController.h"

#import "XDTableViewCell.h"
#import "XDAccountCardViewController.h"

@interface XDFollowerViewController ()

@end

@implementation XDFollowerViewController

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
    self.title = @"关注我的人";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - data

- (void)requestDataWithRefresh:(BOOL)isRefresh
{
    __block __weak XDFollowerViewController *weakSelf = self;
    AFHTTPRequestOperation *operation = [[XDGithubEngine shareEngine] followers:self.userName page:self.page success:^(id object, BOOL haveNextPage) {
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
