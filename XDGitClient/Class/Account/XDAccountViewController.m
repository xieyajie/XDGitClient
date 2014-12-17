//
//  XDAccountViewController.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-21.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDAccountViewController.h"

#import "XDTableViewCell.h"
#import "XDAccountCardViewController.h"

@interface XDAccountViewController ()

@end

@implementation XDAccountViewController

- (id)initWithUsername:(NSString *)userName
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        // Custom initialization
        _userName = userName;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.showRefreshHeader = YES;
    self.showRefreshFooter = NO;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AccountModel *model = [self.dataArray objectAtIndex:indexPath.row];
    XDAccountCardViewController *cardController = [[XDAccountCardViewController alloc] initWithAccount:model];
    [self.navigationController pushViewController:cardController animated:YES];
}

#pragma mark - data

- (void)requestDataWithRefresh:(BOOL)isRefresh
{
    
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
