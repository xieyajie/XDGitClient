//
//  XDNotificationsViewController.m
//  XDGitClient
//
//  Created by dhcdht on 14-12-17.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDNotificationsViewController.h"

@interface XDNotificationsViewController ()
{
    NSString *_userName;
}

@end

@implementation XDNotificationsViewController

- (id)initWithUserName:(NSString *)userName
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        // Custom initialization
        _userName = userName;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.showRefreshHeader = YES;
    self.showRefreshFooter = NO;
    [self tableViewDidTriggerHeaderRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.title = @"通知";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - data

- (void)tableViewDidTriggerHeaderRefresh
{
    [self showLoadingView];
    //    __block __weak XDActivityViewController *weakSelf = self;
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    //        [[XDRequestManager defaultManager] allActivityWithSuccess:^(id object) {
    //            [weakSelf.dataArray removeAllObjects];
    //            if (object) {
    //                for (NSDictionary *dic in object) {
    //
    //                }
    //
    //                [weakSelf tableViewDidFinishHeaderRefresh];
    //            }
    //        } failure:^(NSError *error) {
    //            [weakSelf tableViewDidFinishHeaderRefresh];
    //            dispatch_async(dispatch_get_main_queue(), ^{
    //                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误" message:@"获取数据失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //                [alertView show];
    //            });
    //        }];
    //    });
}

@end
