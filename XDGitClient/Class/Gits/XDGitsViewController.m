//
//  XDGitsViewController.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-20.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDGitsViewController.h"

#import "GitModel.h"

@interface XDGitsViewController ()
{
    NSString *_userName;
    XDGitStyle _style;
}

@end

@implementation XDGitsViewController

- (id)initWithGitsStyle:(XDGitStyle)style
{
    self = [self initWithUserName:nil gitsStyle:style];
    if (self) {
        
    }
    
    return self;
}

- (id)initWithUserName:(NSString *)userName gitsStyle:(XDGitStyle)style
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        //        cell.titleLabel.textColor = [UIColor grayColor];
        //        cell.titleLabel.font = [UIFont systemFontOfSize:15.0];
    }
    
    GitModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = model.gId;
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}


#pragma mark - date

- (void)fetchDataAtPage:(NSInteger)page isHeaderRefresh:(BOOL)isHeaderRefresh
{
    __block __weak XDGitsViewController *weakSelf = self;
    AFHTTPRequestOperation *operation = [[XDGithubEngine shareEngine] gistsForUser:_userName style:_style page:self.page success:^(id object, BOOL haveNextPage) {
        
        if (isHeaderRefresh)
        {
            [weakSelf.dataArray removeAllObjects];
        }
        weakSelf.haveNextPage = haveNextPage;
        if (object) {
            for (NSDictionary *dic in object) {
                GitModel *model = [[GitModel alloc] initWithDictionary:dic];
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

#pragma mark - action

@end
