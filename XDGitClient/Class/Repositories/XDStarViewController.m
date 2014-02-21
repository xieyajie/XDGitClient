//
//  XDStarViewController.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-21.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDStarViewController.h"

@interface XDStarViewController ()

@end

@implementation XDStarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    __block __weak XDStarViewController *weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<XDGitEngineProtocol> activityEngine = [[XDRequestManager defaultManager] activityGitEngine];
        AFHTTPRequestOperation *operation = nil;
        
        operation = [activityEngine followers:self.userName page:self.page success:^(id object, BOOL haveNextPage) {
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
