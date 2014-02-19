//
//  XDAccountCardViewController.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDAccountCardViewController.h"

#import "XDTableViewCell.h"
#import "XDConfigManager.h"

#define KPLIST_SOURCE_OWN @"Own"
#define KPLIST_SOURCE_OTHER @"Other"

@interface XDAccountCardViewController ()
{
    BOOL _isOwn;
}

@property (strong, nonatomic) AccountModel *accountModel;

@property (strong, nonatomic) NSArray *plistSourceArray;
@property (strong, nonatomic) NSArray *titleArray;

@property (strong, nonatomic) UIBarButtonItem *acttentionItem;;
@property (strong, nonatomic) UIImageView *headerImageView;

@end

@implementation XDAccountCardViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        _isOwn = YES;
        _accountModel = [[XDConfigManager defaultManager] loginAccount];
    }
    return self;
}

- (id)initWithAccount:(AccountModel *)model
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        // Custom initialization
        _accountModel = model;
        AccountModel *loginAccount = [[XDConfigManager defaultManager] loginAccount];
        if ([_accountModel.accountId integerValue] == [loginAccount.accountId integerValue]) {
            _isOwn = YES;
        }
        else{
            _isOwn = NO;
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = _accountModel.accountName;
    self.showRefreshHeader = YES;
    [self.navigationItem setRightBarButtonItem:self.acttentionItem];
    
//    [self tableViewDidTriggerHeaderRefresh];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissButtonTapped:(id)sender
{
    [super dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - getter

- (UIBarButtonItem *)acttentionItem
{
    if (_acttentionItem == nil && !_isOwn) {
        _acttentionItem = [[UIBarButtonItem alloc] initWithTitle:@"关注" style:UIBarButtonItemStylePlain target:self action:@selector(acttentionAction)];
    }
    
    return _acttentionItem;
}

- (UIImageView *)headerImageView
{
    if(_headerImageView == nil)
    {
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
        _headerImageView.userInteractionEnabled = YES;
        [_headerImageView setImageWithURL:[NSURL URLWithString:self.accountModel.avatarUrl] placeholderImage:[UIImage imageNamed:@"userHeaderDefault_30"]];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerImageAction)];
        [_headerImageView addGestureRecognizer:tap];
    }
    
    return _headerImageView;
}

- (NSArray *)titleArray
{
    if (_titleArray == nil) {
        if (_isOwn) {
            _titleArray = @[@"基本资料"];
        }
        else{
            _titleArray = @[@"基本资料", @"工程", @"动态", @"关注"];
        }
    }
    
    return _titleArray;
}

- (NSArray *)plistSourceArray
{
    if (_plistSourceArray == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"accountCard" ofType:@"plist"];
        NSDictionary *sourcrDic = [NSDictionary dictionaryWithContentsOfFile:path];
        NSString *sourceKey = _isOwn ? KPLIST_SOURCE_OWN : KPLIST_SOURCE_OTHER;
        _plistSourceArray = [sourcrDic objectForKey:sourceKey];
    }
    
    return _plistSourceArray;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.plistSourceArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[self.plistSourceArray objectAtIndex:section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.titleArray objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellValue1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:15.0];
        
        cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.3f alpha:1.0];
    }
    else{
        cell.textLabel.text = @"";
        [self.headerImageView removeFromSuperview];
    }
    
    NSDictionary *dic = [[self.plistSourceArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.accessoryType = [[dic objectForKey:KPLIST_SOURCEACCESSORYTYPE] integerValue];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        [cell.contentView addSubview:self.headerImageView];
        cell.detailTextLabel.text = self.accountModel.accountName;
    }
    else{
        cell.textLabel.text = [dic objectForKey:KPLIST_SOURCETITLE];
        
        NSString *selectorStr = [dic objectForKey:KPLIST_SOURCESELECTOR];
        if (selectorStr && selectorStr.length > 0) {
            SEL selectorMethod = NSSelectorFromString(selectorStr);
            if (selectorMethod) {
                NSString *resultStr = [self.accountModel performSelector:selectorMethod];
                if(resultStr && resultStr.length > 0)
                {
                    cell.detailTextLabel.text = resultStr;
                }
            }
        }
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSString *str = [self.titleArray objectAtIndex:section];
    if (str == nil || str.length == 0) {
        return 20.0;
    }
    
    return 40.0;
}

#pragma mark - action

- (void)acttentionAction
{
    
}

- (void)headerImageAction
{
    
}

#pragma mark - data

- (void)tableViewDidTriggerHeaderRefresh
{
    if (_accountModel == nil) {
        __block __weak XDAccountCardViewController *weakSelf = self;
        AFHTTPRequestOperation *operation = nil;
        if (_isOwn) {
            operation = [[[XDRequestManager defaultManager] activityGitEngine] userWithSuccess:^(id object) {
                weakSelf.accountModel = object;
                
                [weakSelf tableViewDidFinishHeaderRefresh];
            } failure:^(NSError *error) {
                [weakSelf tableViewDidFailHeaderRefresh];
            }];
        }
        else{
            operation = [[[XDRequestManager defaultManager] activityGitEngine] user:_accountModel.accountName success:^(id object) {
                weakSelf.accountModel = object;
                
//                [weakSelf tableViewDidFinishHeaderRefresh];
            } failure:^(NSError *error) {
                [weakSelf tableViewDidFailHeaderRefresh];
            }];
        }
        
        [self showLoadingViewWithRequestOperation:operation];
    }
}

@end
