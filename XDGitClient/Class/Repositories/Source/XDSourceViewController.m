//
//  XDSourceViewController.m
//  XDGitClient
//
//  Created by dhcdht on 15-1-1.
//  Copyright (c) 2015年 XDIOS. All rights reserved.
//

#import "XDSourceViewController.h"

#import "RepositoryModel.h"
#import "XDReadMeViewController.h"

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
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 1) {
        return 1;
    }
    else{
        return [self.dataArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section == 1) {
        cell.textLabel.text = @"Read Me";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    if(indexPath.section == 1 && indexPath.row == 0)
    {
        XDReadMeViewController *readmeController = [[XDReadMeViewController alloc] initWithRepositoryFullName:_repoModel.fullName];
        [self.navigationController pushViewController:readmeController animated:YES];
    }
    //    RepositoryModel *model = [self.dataArray objectAtIndex:indexPath.row];
    //    XDRepoCardViewController *repoCardController = [[XDRepoCardViewController alloc] initWithRepositoryModel:model];
    //    [self.navigationController pushViewController:repoCardController animated:YES];
}

@end
