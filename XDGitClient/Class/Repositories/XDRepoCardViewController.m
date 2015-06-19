//
//  XDRepoCardViewController.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-21.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDRepoCardViewController.h"

#import "RepositoryModel.h"
#import "XDUserCardViewController.h"
#import "XDSourceViewController.h"
#import "XDForkersViewController.h"
#import "XDStargazersViewController.h"
#import "XDWatchersViewController.h"
#import "XDPullRequestsViewController.h"

@interface XDRepoCardViewController ()

@property (strong, nonatomic) RepositoryModel *repoModel;

@property (strong, nonatomic) NSMutableArray *plistSourceArray;
@property (strong, nonatomic) NSArray *titleArray;

@end

@implementation XDRepoCardViewController

- (id)initWithRepositoryModel:(RepositoryModel *)model
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        // Custom initialization
        _repoModel = model;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = self.repoModel.fullName;
    self.showRefreshHeader = NO;
    
    [self loadPlistSource];
//    [self tableViewDidTriggerHeaderRefresh];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.plistSourceArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[self.plistSourceArray objectAtIndex:section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.titleArray objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellValue1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        
        cell.textLabel.textColor = [UIColor grayColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15.0];
        cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.2f alpha:1.0];
        cell.detailTextLabel.numberOfLines = 0;
    }
    
    NSDictionary *dic = [[self.plistSourceArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.accessoryType = [[dic objectForKey:KPLIST_KEYACCESSORYTYPE] integerValue];
    cell.textLabel.text = [dic objectForKey:KPLIST_KEYTITLE];
    
    NSString *selectorStr = [dic objectForKey:KPLIST_KEYMODELSELECTOR];
    SEL selectorMethod = NSSelectorFromString(selectorStr);
    if (selectorStr && selectorStr.length && selectorMethod) {
        NSString *resultStr = [self.repoModel performSelector:selectorMethod];
        if(resultStr && resultStr.length > 0)
        {
            cell.detailTextLabel.text = resultStr;
        }
    }
    else{
        cell.detailTextLabel.text = @"";
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [[self.plistSourceArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    NSString *key = [dic objectForKey:KPLIST_KEYTITLE];
    if ([key isEqualToString:@"描述"]) {
        NSMutableDictionary *attributesDictionary = [NSMutableDictionary dictionary];
        [attributesDictionary setValue:[UIFont systemFontOfSize:15.0] forKey:NSFontAttributeName];
        CGRect sizeRect = [self.repoModel.describe boundingRectWithSize:CGSizeMake(300 - 100, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDictionary context:nil];
        
        return sizeRect.size.height < 30 ? 50.0 : (20 + sizeRect.size.height);
    }
    
    return 50.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = [[self.plistSourceArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    NSInteger controllerSelectorTag = [[dic objectForKey:KPLIST_KEYCONTROLLERSELECTOR] integerValue];
    
    switch (controllerSelectorTag) {
        case KPLIST_VALUE_CONTROLLERSELECTOR_ACCOUNT:
        {
            if (self.repoModel.owner) {
                XDUserCardViewController *cardController = [[XDUserCardViewController alloc] initWithUser:self.repoModel.owner];
                [self.navigationController pushViewController:cardController animated:YES];
            }
        }
            break;
        case KPLIST_VALUE_CONTROLLERSELECTOR_FORKORIGIN:
        {
            
        }
            break;
        case KPLIST_VALUE_CONTROLLERSELECTOR_REPOSOURCE:
        {
            XDSourceViewController *sourceController = [[XDSourceViewController alloc] initWithRepository:self.repoModel];
            sourceController.title = [NSString stringWithFormat:@"%@`s Source", self.repoModel.name];
            [self.navigationController pushViewController:sourceController animated:YES];
        }
            break;
        case KPLIST_VALUE_CONTROLLERSELECTOR_ISSUE:
        {
            
        }
            break;
        case KPLIST_VALUE_CONTROLLERSELECTOR_PULLREQUEST:
        {
            XDPullRequestsViewController *pullRequestController = [[XDPullRequestsViewController alloc] initWithRepoFullName:self.repoModel.fullName];
            pullRequestController.title = [NSString stringWithFormat:@"%@`s pull request", self.repoModel.name];
            [self.navigationController pushViewController:pullRequestController animated:YES];
        }
            break;
        case KPLIST_VALUE_CONTROLLERSELECTOR_FORKER:
        {
            XDForkersViewController *fokerController = [[XDForkersViewController alloc] initWithRepoFullname:self.repoModel.fullName];
            fokerController.title = [NSString stringWithFormat:@"%@`s fokers", self.repoModel.name];
            [self.navigationController pushViewController:fokerController animated:YES];
        }
            break;
        case KPLIST_VALUE_CONTROLLERSELECTOR_STARER:
        {
            XDStargazersViewController *starController = [[XDStargazersViewController alloc] initWithRepoFullname:self.repoModel.fullName];
            starController.title = [NSString stringWithFormat:@"%@`s stargazers", self.repoModel.name];
            [self.navigationController pushViewController:starController animated:YES];
        }
            break;
        case KPLIST_VALUE_CONTROLLERSELECTOR_WATCHER:
        {
            XDWatchersViewController *watcherController = [[XDWatchersViewController alloc] initWithRepoFullname:self.repoModel.fullName];
            watcherController.title = [NSString stringWithFormat:@"%@`s watcher", self.repoModel.name];
            [self.navigationController pushViewController:watcherController animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - action

#pragma mark - data

- (void)loadPlistSource
{
    [self showLoadingViewWithTitle:@"加载基本信息..."];
    
    self.titleArray = @[@"基本信息", @"资料", @"人气"];
    self.plistSourceArray = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"repoCard" ofType:@"plist"];
    NSDictionary *plistDic = [NSDictionary dictionaryWithContentsOfFile:path];
    for (int i = 0; i < [self.titleArray count]; i++) {
        NSString *key = [self.titleArray objectAtIndex:i];
        NSArray *array = [plistDic objectForKey:key];
        if (array) {
            [self.plistSourceArray addObject:[NSMutableArray arrayWithArray:array]];
        }
    }
    
    if (self.repoModel.describe && self.repoModel.describe.length > 0) {
        [[self.plistSourceArray objectAtIndex:0] insertObject:[plistDic objectForKey:@"describe"] atIndex:1];
    }
    
    NSString *forkKey = self.repoModel.isFork ? @"1" : @"0";
    NSDictionary *forkDic = [plistDic objectForKey:@"fork"];
    [[self.plistSourceArray objectAtIndex:0] addObject:[forkDic objectForKey:forkKey]];
    
    [self.tableView reloadData];
    [self hideLoadingView];
}

- (void)tableViewDidTriggerHeaderRefresh
{
    __block __weak XDRepoCardViewController *weakSelf = self;
    AFHTTPRequestOperation *operation = [[DXGithubEngine shareEngine] repository:self.repoModel.fullName success:^(id object) {
        if([object count] > 0)
        {
            
        }
        [weakSelf hideLoadingView];
    } failure:^(NSError *error) {
        [weakSelf hideLoadingView];
    }];
    
    [self showLoadingViewWithRequestOperation:operation];
}

@end
