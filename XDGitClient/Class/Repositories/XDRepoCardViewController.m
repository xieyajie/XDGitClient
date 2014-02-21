//
//  XDRepoCardViewController.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-21.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDRepoCardViewController.h"

#import "RepositoryModel.h"
#import "XDAccountCardViewController.h"
#import "XDForkerViewController.h"
#import "XDStargazerViewController.h"
#import "XDWatcherViewController.h"

@interface XDRepoCardViewController ()
{
    AFHTTPRequestOperation *_operation;
}

@property (strong, nonatomic) RepositoryModel *repoModel;

@property (nonatomic) BOOL isLoadedPlist;
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
        _isLoadedPlist = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = self.repoModel.fullName;
    
    [self tableViewDidTriggerHeaderRefresh];
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
        CGRect sizeRect = [self.repoModel.description boundingRectWithSize:CGSizeMake(300 - 100, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDictionary context:nil];
        
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
                XDAccountCardViewController *accountController = [[XDAccountCardViewController alloc] initWithAccount:self.repoModel.owner];
                [self.navigationController pushViewController:accountController animated:YES];
            }
        }
            break;
        case KPLIST_VALUE_CONTROLLERSELECTOR_FORKORIGIN:
        {
            
        }
            break;
        case KPLIST_VALUE_CONTROLLERSELECTOR_REPOSOURCE:
        {
            
        }
            break;
        case KPLIST_VALUE_CONTROLLERSELECTOR_ISSUE:
        {
            
        }
            break;
        case KPLIST_VALUE_CONTROLLERSELECTOR_PULLREQUEST:
        {
            
        }
            break;
        case KPLIST_VALUE_CONTROLLERSELECTOR_FORKER:
        {
            XDForkerViewController *fokerController = [[XDForkerViewController alloc] initWithRepoFullname:self.repoModel.fullName];
            fokerController.title = [NSString stringWithFormat:@"%@`s fokers", self.repoModel.name];
            [self.navigationController pushViewController:fokerController animated:YES];
        }
            break;
        case KPLIST_VALUE_CONTROLLERSELECTOR_STARER:
        {
            XDStargazerViewController *starController = [[XDStargazerViewController alloc] initWithRepoFullname:self.repoModel.fullName];
            starController.title = [NSString stringWithFormat:@"%@`s stargazers", self.repoModel.name];
            [self.navigationController pushViewController:starController animated:YES];
        }
            break;
        case KPLIST_VALUE_CONTROLLERSELECTOR_WATCHER:
        {
            XDWatcherViewController *watcherController = [[XDWatcherViewController alloc] initWithRepoFullname:self.repoModel.fullName];
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
    __block __weak XDRepoCardViewController *weakSelf = self;
    _operation = [[[XDRequestManager defaultManager] activityGitEngine] repository:self.repoModel.fullName success:^(id object, BOOL haveNextPage) {
        weakSelf.isLoadedPlist = YES;
    } failure:^(NSError *error) {
        weakSelf.isLoadedPlist = YES;
    }];
    [self showLoadingViewWithRequestOperation:_operation];
}

- (void)tableViewDidTriggerHeaderRefresh
{
    [self showLoadingViewWithTitle:@"获取基本信息..."];
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
    
    if (self.repoModel.description && self.repoModel.description.length > 0) {
        [[self.plistSourceArray objectAtIndex:0] insertObject:[plistDic objectForKey:@"description"] atIndex:1];
    }
    
    NSString *forkKey = self.repoModel.isFork ? @"1" : @"0";
    NSDictionary *forkDic = [plistDic objectForKey:@"fork"];
    [[self.plistSourceArray objectAtIndex:0] addObject:[forkDic objectForKey:forkKey]];
    
    [self.tableView reloadData];
    [self hideLoadingView];
}

@end
