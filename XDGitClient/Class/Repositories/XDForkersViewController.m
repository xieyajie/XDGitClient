//
//  XDForkersViewController.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-21.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDForkersViewController.h"

#import "RepositoryModel.h"

@interface XDForkersViewController ()
{
    NSString *_fullName;
}

@end

@implementation XDForkersViewController

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

- (void)fetchDataAtPage:(NSInteger)page isHeaderRefresh:(BOOL)isHeaderRefresh
{
    if (_fullName == nil || _fullName.length == 0) {
        return;
    }
    
    __block __weak XDForkersViewController *weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AFHTTPRequestOperation *operation = nil;
        
        operation = [[XDGithubEngine shareEngine] forkersForRepository:_fullName page:page success:^(id object, BOOL haveNextPage) {
            if (isHeaderRefresh) {
                [weakSelf.dataArray removeAllObjects];
            }
            weakSelf.haveNextPage = haveNextPage;
            
            if (object) {
                for (NSDictionary *dic in object) {
                    RepositoryModel *model = [[RepositoryModel alloc] initWithDictionary:dic];
                    [weakSelf.dataArray addObject:model.owner];
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
    });
}

@end
