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
    NSArray *_titleArray;
    UIBarButtonItem *_acttentionItem;
}

@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) AccountModel *accountModel;;

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
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"accountCard" ofType:@"plist"];
        self.dataArray = [NSMutableArray arrayWithContentsOfFile:path];
        
        _titleArray = @[@"", @"工程", @"动态"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = _accountModel.accountName;
    self.showRefreshHeader = YES;
    
    _acttentionItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(acttentionAction)];
    [self.navigationItem setRightBarButtonItem:_acttentionItem];
    
    self.tableView.tableHeaderView = self.headerView;
    
//    [self tableViewDidTriggerHeaderRefresh];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter

- (UIView *)headerView
{
    if (_headerView == nil) {
//        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
        
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:<#(CGRect)#>];
    }
    
    return _headerView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[self.dataArray objectAtIndex:section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_titleArray objectAtIndex:section];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSString *str = [_titleArray objectAtIndex:section];
    if (str == nil || str.length == 0) {
        return 20.0;
    }
    
    return 40.0;
}

#pragma mark - action

- (void)acttentionAction
{
    
}

#pragma mark - data

- (void)tableViewDidTriggerHeaderRefresh
{
    if (_accountModel != nil) {
        __block __weak XDAccountCardViewController *weakSelf = self;
        AFHTTPRequestOperation *operation = [[[XDRequestManager defaultManager] activityGitEngine] user:_accountModel.accountName success:^(id object) {
            [weakSelf.dataArray removeAllObjects];
//            weakSelf.accountModel = [];
            
            [weakSelf hideLoadingView];
            [weakSelf tableViewDidFinishHeaderRefresh];
        } failure:^(NSError *error) {
            [weakSelf hideLoadingView];
            [weakSelf tableViewDidFailHeaderRefresh];
        }];
        
        [self showLoadingViewWithRequestOperation:operation];
    }
}

@end
