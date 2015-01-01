//
//  XDEventsViewController.m
//  XDGitClient
//
//  Created by dhcdht on 14-12-17.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDEventsViewController.h"

#import "EventModel.h"
#import "XDConfigManager.h"

@interface XDEventsViewController ()
{
    NSString *_userName;
}

@end

@implementation XDEventsViewController

- (id)initWithUserName:(NSString *)userName
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        // Custom initialization
        _userName = userName;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"事件";
    self.showRefreshHeader = YES;
    self.showRefreshFooter = NO;
    
    [self tableViewDidTriggerHeaderRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - data

- (void)fetchDataAtPage:(NSInteger)page isHeaderRefresh:(BOOL)isHeaderRefresh
{
    __block __weak XDEventsViewController *weakSelf = self;
    
    NSString *account = [XDConfigManager defaultManager].loginUser.userName;
    AFHTTPRequestOperation *operation = [[XDGithubEngine shareEngine] eventsForUsername:account page:page success:^(id object, BOOL haveNextPage) {
        if (isHeaderRefresh) {
            [weakSelf.dataArray removeAllObjects];
        }
        weakSelf.haveNextPage = haveNextPage;
        
        if (object) {
            for (NSDictionary *dic in object) {
                EventModel *model = [[EventModel alloc] initWithDictionary:dic];
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
