//
//  XDAccountCardViewController.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDAccountCardViewController.h"

#import "XDTableViewCell.h"

@interface XDAccountCardViewController ()
{
    AccountModel *_accountModel;
}

@property (strong, nonatomic) UIView *headerView;

@end

@implementation XDAccountCardViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithAccount:(AccountModel *)model
{
    self = [self initWithStyle:UITableViewStylePlain];
    if (self) {
        // Custom initialization
        _accountModel = model;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = _accountModel.accountName;
    self.showRefreshHeader = YES;
    
    [self tableViewDidTriggerHeaderRefresh];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[self.dataArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    XDTableViewCell *cell = (XDTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[XDTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        cell.titleLabel.textColor = [UIColor grayColor];
        cell.titleLabel.font = [UIFont systemFontOfSize:15.0];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(KLEFTVIEWWIDTH - 45, 15, 35, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:13.0];
        label.textColor = [UIColor whiteColor];
        label.tag = 100;
        label.layer.cornerRadius = 5.0;
        [cell.contentView addSubview:label];
    }
    
//    NSDictionary *dic = [[self.dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
//    if (dic) {
//        cell.headerImageView.image = [UIImage imageNamed:[dic objectForKey:KSOURCEIMAGE]];
//        cell.titleLabel.text = [dic objectForKey:KSOURCETITLE];
//        
//        UILabel *detailLabel = (UILabel *)[cell.contentView viewWithTag:100];
//        detailLabel.backgroundColor = [UIColor clearColor];
//        NSString *selectorStr = [dic objectForKey:KSOURCESELECTOR];
//        if (selectorStr && selectorStr.length > 0) {
//            SEL selectorMethod = NSSelectorFromString(selectorStr);
//            if (selectorMethod) {
//                NSString *resultStr = [_configManager.loginAccount performSelector:selectorMethod];
//                if(resultStr && resultStr.length > 0)
//                {
//                    detailLabel.text = resultStr;
//                    detailLabel.backgroundColor = [UIColor lightGrayColor];
//                }
//            }
//        }
//    }
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

#pragma mark - data

- (void)tableViewDidTriggerHeaderRefresh
{
    [self showLoadingView];
    __block __weak XDAccountCardViewController *weakSelf = self;
}

@end
