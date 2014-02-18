//
//  XDFollowViewController.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDFollowViewController.h"

#import "XDTableViewCell.h"

@interface XDFollowViewController ()
{
    BOOL _isFollowers;
}

@end

@implementation XDFollowViewController

- (id)initWithFollowers:(BOOL)isFollowers
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        _isFollowers = isFollowers;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = _isFollowers ? @"关注我的" : @"我关注的";
    [self loadDataSource];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    XDTableViewCell *cell = (XDTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[XDTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        cell.titleLabel.textColor = [UIColor grayColor];
        cell.titleLabel.font = [UIFont systemFontOfSize:15.0];
    }
    
    AccountModel *model = [self.dataArray objectAtIndex:indexPath.row];
    [cell.headerImageView setImageWithURL:[NSURL URLWithString:model.avatarUrl] placeholderImage:[UIImage imageNamed:@"userHeaderDefault_30"]];
    cell.titleLabel.text = model.accountName;
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

#pragma mark - data

- (void)loadDataSource
{
    [self showLoadingView];
    __block __weak XDFollowViewController *weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<XDGitEngineProtocol> activityEngine = [[XDRequestManager defaultManager] activityGitEngine];
        if (_isFollowers) {
            [activityEngine followersWithSuccess:^(id object) {
                [weakSelf.dataArray removeAllObjects];
                if (object) {
                    for (NSDictionary *dic in object) {
                        AccountModel *model = [[AccountModel alloc] initWithDictionary:dic];
                        [weakSelf.dataArray addObject:model];
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.tableView reloadData];
                        [weakSelf hideLoadingView];
                    });
                }
            } failure:^(NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf hideLoadingView];
                    
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误" message:@"获取数据失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                });
            }];
        }
        else{
            [activityEngine followingWithSuccess:^(id object) {
                [weakSelf.dataArray removeAllObjects];
                if (object) {
                    for (NSDictionary *dic in object) {
                        AccountModel *model = [[AccountModel alloc] initWithDictionary:dic];
                        [weakSelf.dataArray addObject:model];
                    }
                    
                     dispatch_async(dispatch_get_main_queue(), ^{
                         [weakSelf.tableView reloadData];
                         [weakSelf hideLoadingView];
                     });
                }
            } failure:^(NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf hideLoadingView];
                    
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误" message:@"获取数据失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                });
            }];
        }
    });
}

@end
