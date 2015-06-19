//
//  XDFollowerViewController.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDFollowerViewController.h"

#import "XDTableViewCell.h"
#import "XDUserCardViewController.h"

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - data

- (void)fetchDataAtPage:(int)page isHeaderRefresh:(BOOL)isHeaderRefresh
{
    __block __weak XDFollowerViewController *weakSelf = self;
    AFHTTPRequestOperation *operation = [[DXGithubEngine shareEngine] followers:self.userName page:page success:^(id object, BOOL haveNextPage) {
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
