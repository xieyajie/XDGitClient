//
//  XDIssuesViewController.m
//  XDGitClient
//
//  Created by dhcdht on 15-1-1.
//  Copyright (c) 2015年 XDIOS. All rights reserved.
//

#import "XDIssuesViewController.h"

#import "XDConfigManager.h"

@interface XDIssuesViewController ()
{
    NSString *_userName;
}

@end

@implementation XDIssuesViewController

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
    self.title = @"问题";
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
    return [self.dataDictionary count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSArray *issuesArray = [self.dataDictionary.allValues objectAtIndex:section];
    return [issuesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    RepositoryModel *model = [self.dataArray objectAtIndex:indexPath.row];
//    return [XDRepositoryCell heightWithModel:model];
    
    return 50.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    RepositoryModel *model = [self.dataArray objectAtIndex:indexPath.row];
//    XDRepoCardViewController *repoCardController = [[XDRepoCardViewController alloc] initWithRepositoryModel:model];
//    [self.navigationController pushViewController:repoCardController animated:YES];
}

#pragma mark - data

- (void)fetchDataAtPage:(NSInteger)page isHeaderRefresh:(BOOL)isHeaderRefresh
{
//    __block __weak XDIssuesViewController *weakSelf = self;
//    
//    NSString *account = [XDConfigManager defaultManager].loginUser.userName;
//    AFHTTPRequestOperation *operation = [[XDGithubEngine shareEngine] eventsForUsername:account page:page success:^(id object, BOOL haveNextPage) {
//        if (isHeaderRefresh) {
//            [weakSelf.dataArray removeAllObjects];
//        }
//        weakSelf.haveNextPage = haveNextPage;
//        
//        if (object) {
//            for (NSDictionary *dic in object) {
//                EventModel *model = [[EventModel alloc] initWithDictionary:dic];
//                [weakSelf.dataArray addObject:model];
//            }
//        }
//        
//        if (isHeaderRefresh) {
//            [weakSelf tableViewDidFinishHeaderRefresh];
//        }
//        else{
//            [weakSelf tableViewDidFinishFooterRefresh];
//        }
//    } failure:^(NSError *error) {
//        if (isHeaderRefresh) {
//            [weakSelf tableViewDidFailHeaderRefresh];
//        }
//        else{
//            [weakSelf tableViewDidFailFooterRefresh];
//        }
//    }];
//    
//    [self showLoadingViewWithRequestOperation:operation];
}

@end
