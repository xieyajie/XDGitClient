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

@interface XDRepositoryViewController ()
{
    NSString *_userName;
    XDRepositoryStyle _style;
    
    UIBarButtonItem *_editItem;
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
        
        if (_userName == nil && _userName.length == 0) {
            _editItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editAction)];
            _rightItems = [NSMutableArray arrayWithObjects:_editItem, nil];
        }
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.showRefreshHeader = YES;
    
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


#pragma mark - date

- (void)tableViewDidTriggerHeaderRefresh
{
    self.page = 1;
    __block __weak XDRepositoryViewController *weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AFHTTPRequestOperation *operation = [[[XDRequestManager defaultManager] activityGitEngine] repositoriesWithUser:_userName style:_style includeWatched:NO page:self.page success:^(id object) {
            [weakSelf.dataArray removeAllObjects];
            if (object) {
                for (NSDictionary *dic in object) {
                    RepositoryModel *model = [[RepositoryModel alloc] initWithDictionary:dic];
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

- (void)tableViewDidTriggerFooterRefresh
{
    self.page++;
    __block __weak XDRepositoryViewController *weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AFHTTPRequestOperation *operation = [[[XDRequestManager defaultManager] activityGitEngine] repositoriesWithUser:_userName style:_style includeWatched:NO page:self.page success:^(id object) {
            if (object) {
                for (NSDictionary *dic in object) {
                    RepositoryModel *model = [[RepositoryModel alloc] initWithDictionary:dic];
                    [weakSelf.dataArray addObject:model];
                }
                
                [weakSelf tableViewDidFinishFooterRefresh];
            }
        } failure:^(NSError *error) {
            [weakSelf tableViewDidFailFooterRefresh];
        }];
        
        [self showLoadingViewWithRequestOperation:operation];
    });
}

#pragma mark - action

- (void)editAction
{
    self.tableView.editing = !self.tableView.editing;
    _editItem.title = self.tableView.editing ? @"完成" : @"编辑";
}

@end
