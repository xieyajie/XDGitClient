//
//  XDFileListViewController.m
//  XDGitClient
//
//  Created by dhcdht on 15-1-15.
//  Copyright (c) 2015年 XDIOS. All rights reserved.
//

#import "XDFileListViewController.h"

#import "RepoSourceModel.h"
#import "XDFileViewController.h"

@interface XDFileListViewController ()
{
    NSString *_repoFullName;
    NSString *_filePath;
}

@end

@implementation XDFileListViewController

- (instancetype)initWithRepositoryFullName:(NSString *)repoFullName filePath:(NSString *)filePath
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        _repoFullName = repoFullName;
        _filePath = filePath;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.showRefreshHeader = YES;
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self tableViewDidTriggerHeaderRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.row < [self.dataArray count]) {
        RepoSourceModel *model = [self.dataArray objectAtIndex:indexPath.row];
        if (model) {
            cell.textLabel.text = model.name;
            cell.imageView.image = [UIImage imageNamed:model.imageName];
            cell.accessoryType = model.cellAccessoryType;
        }
    }

    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row < [self.dataArray count]) {
        RepoSourceModel *model = [self.dataArray objectAtIndex:row];
        if (model.type == XDSourceTypeFile) {
            XDFileViewController *controller = [[XDFileViewController alloc] initWithSourceModel:model];
            controller.title = model.name;
            [self.navigationController pushViewController:controller animated:YES];
        }
        else if(model.type == XDSourceTypeDir){
            XDFileListViewController *fileController = [[XDFileListViewController alloc] initWithRepositoryFullName:_repoFullName filePath:model.path];
            fileController.title = model.name;
            [self.navigationController pushViewController:fileController animated:YES];
        }
    }
}

#pragma mark - data

- (void)tableViewDidTriggerHeaderRefresh
{
    __block __weak XDFileListViewController *weakSelf = self;
    AFHTTPRequestOperation *operation = [[DXGithubEngine shareEngine] sourceForRepository:_repoFullName filePath:_filePath success:^(id object) {
        [weakSelf.dataArray removeAllObjects];
        if ([object count] > 0) {
            for (NSDictionary *dic in object) {
                RepoSourceModel *model = [[RepoSourceModel alloc] initWithDictionary:dic];
                if (model) {
                    [weakSelf.dataArray addObject:model];
                }
            }
        }
        [weakSelf hideLoadingView];
        [weakSelf tableViewDidFinishHeaderRefresh];
        
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        [weakSelf hideLoadingView];
        [weakSelf tableViewDidFailHeaderRefresh];
    }];
    
    [[XDViewManager defaultManager] showLoadingViewWithTitle:@"获取文件..." requestOperation:operation];
}

@end
