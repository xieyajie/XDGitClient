//
//  XDIssuesViewController.m
//  XDGitClient
//
//  Created by dhcdht on 15-1-1.
//  Copyright (c) 2015年 XDIOS. All rights reserved.
//

#import "XDIssuesViewController.h"

#import "XDConfigManager.h"
#import "IssueModel.h"

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
    self.showRefreshHeader = NO;
    
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
//    IssueModel *model = [self.dataArray objectAtIndex:indexPath.row];
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

- (void)fetchDataFromServer
{
    __block __weak XDIssuesViewController *weakSelf = self;
    
    AFHTTPRequestOperation *operation = [[DXGithubEngine shareEngine] issueEventsWithSuccess:^(id object) {
        [weakSelf.dataArray removeAllObjects];
        if (object) {
            for (NSDictionary *dic in object) {
                IssueModel *model = [[IssueModel alloc] initWithDictionary:dic];
                [weakSelf.dataArray addObject:model];
            }
        }
        
        [weakSelf hideLoadingView];
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        [weakSelf hideLoadingView];
    }];
    
    [self showLoadingViewWithRequestOperation:operation];
}

@end
