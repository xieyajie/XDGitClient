//
//  XDSourceViewController.m
//  XDGitClient
//
//  Created by dhcdht on 15-1-1.
//  Copyright (c) 2015年 XDIOS. All rights reserved.
//

#import "XDSourceViewController.h"

#import "RepositoryModel.h"
#import "XDFileListViewController.h"

@interface XDSourceViewController ()
{
    RepositoryModel *_repoModel;
}

@end

@implementation XDSourceViewController

- (instancetype)initWithRepository:(RepositoryModel *)model
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        _repoModel = model;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.dataArray addObject:@"master"];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
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
        cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    }
    else{
        cell.textLabel.text = @"";
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
    //TODO: 目前只支持查看master
    XDFileListViewController *fileController = [[XDFileListViewController alloc] initWithRepositoryFullName:_repoModel.fullName filePath:@""];
    fileController.title = @"master";
    [self.navigationController pushViewController:fileController animated:YES];
}

@end
