//
//  XDRepositoryViewController.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDRepositoryViewController.h"

#import "RepositoryModel.h"
#import "XDRepositoryCell.h"
#import "XDRepoCardViewController.h"

@interface XDRepositoryViewController ()
{
    NSString *_userName;
    XDRepositoryStyle _style;
}

@end

@implementation XDRepositoryViewController

- (id)initWithProjectsStyle:(XDRepositoryStyle)style
{
    self = [self initWithUserName:nil repositoryStyle:style];
    if (self) {
        
    }
    
    return self;
}

- (id)initWithUserName:(NSString *)userName repositoryStyle:(XDRepositoryStyle)style
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        _style = style;
        _userName = userName;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.showRefreshHeader = YES;
    self.tableView.separatorColor = [UIColor colorWithRed:70 / 255.0 green:175 / 255.0 blue:226 / 255.0 alpha:0.6];
    
    [self tableViewDidTriggerHeaderRefresh];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RepositoyCell";
    XDRepositoryCell *cell = (XDRepositoryCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[XDRepositoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.model = [self.dataArray objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RepositoryModel *model = [self.dataArray objectAtIndex:indexPath.row];
    return [XDRepositoryCell heightWithModel:model];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RepositoryModel *model = [self.dataArray objectAtIndex:indexPath.row];
    XDRepoCardViewController *repoCardController = [[XDRepoCardViewController alloc] initWithRepositoryModel:model];
    [self.navigationController pushViewController:repoCardController animated:YES];
}

#pragma mark - date

- (void)fetchDataAtPage:(NSInteger)page isHeaderRefresh:(BOOL)isHeaderRefresh
{
    __block __weak XDRepositoryViewController *weakSelf = self;
    AFHTTPRequestOperation *operation = [[XDGithubEngine shareEngine] repositoriesWithUser:_userName style:_style includeWatched:NO page:self.page success:^(id object, BOOL haveNextPage) {
        
        if (isHeaderRefresh)
        {
            [weakSelf.dataArray removeAllObjects];
        }
        weakSelf.haveNextPage = haveNextPage;
        if (object) {
            for (NSDictionary *dic in object) {
                RepositoryModel *model = [[RepositoryModel alloc] initWithDictionary:dic];
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
