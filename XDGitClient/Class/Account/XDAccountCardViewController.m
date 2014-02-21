//
//  XDAccountCardViewController.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDAccountCardViewController.h"

#import "XDTableViewCell.h"
#import "XDTabBarController.h"
#import "XDRepositoryViewController.h"
#import "XDGitsViewController.h"
#import "XDFollowViewController.h"
#import "XDActivityViewController.h"
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
@property (strong, nonatomic) XDTabBarController *reposityController;
@property (strong, nonatomic) XDGitsViewController *gitsController;

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
    self.title = self.accountModel.accountName;
    self.showRefreshHeader = YES;
    [self.navigationItem setRightBarButtonItem:self.acttentionItem];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
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
        [_headerImageView setImageWithURL:[NSURL URLWithString:self.accountModel.avatarUrl] placeholderImage:[UIImage imageNamed:@"userHeaderDefault_30"]];
        
        if (_isOwn) {
            _headerImageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerImageAction)];
            [_headerImageView addGestureRecognizer:tap];
        }
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

- (XDTabBarController *)reposityController
{
    if (_reposityController == nil) {
        NSArray *titleArray = @[@"全部", @"自己的", @"参与"];
        NSArray *imageArray = @[@"tab_all.png", @"side_copy.png", @"side_copy.png"];
        NSArray *selectedImageArray = @[@"tab_allSelect.png", @"side_own.png", @"side_own.png"];
        NSMutableArray *controllers = [NSMutableArray array];
        for (int i = 0; i < 3; i++) {
            XDRepositoryViewController *controller = [[XDRepositoryViewController alloc] initWithUserName:self.accountModel.accountName repositoryStyle:i];
            UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:[titleArray objectAtIndex:i] image:nil tag:i];
            [tabBarItem setImage:[UIImage imageNamed:[imageArray objectAtIndex:i]]];
            [tabBarItem setSelectedImage:[UIImage imageNamed:[selectedImageArray objectAtIndex:i]]];
            controller.tabBarItem = tabBarItem;
            
            [controllers addObject:controller];
        }
        
        _reposityController = [[XDTabBarController alloc] init];
        [_reposityController setViewControllers:controllers];
    }
    
    return _reposityController;
}

- (XDGitsViewController *)gitsController
{
    if (_gitsController == nil) {
        _gitsController = [[XDGitsViewController alloc] initWithUserName:self.accountModel.accountName gitsStyle:XDGitStyleAll];
        _gitsController.title = @"Gits";
    }
    
    return _gitsController;
}

#pragma mark - setter

- (void)setAccountModel:(AccountModel *)accountModel
{
    _accountModel = accountModel;
    [self.headerImageView setImageWithURL:[NSURL URLWithString:accountModel.avatarUrl] placeholderImage:[UIImage imageNamed:@"userHeaderDefault_30"]];
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
    
    NSDictionary *dic = [[self.plistSourceArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.accessoryType = [[dic objectForKey:KPLIST_KEYACCESSORYTYPE] integerValue];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.textLabel.text = @"";
        [cell.contentView addSubview:self.headerImageView];
        cell.detailTextLabel.text = self.accountModel.accountName;
    }
    else{
        cell.textLabel.text = [dic objectForKey:KPLIST_KEYTITLE];
        
        NSString *selectorStr = [dic objectForKey:KPLIST_KEYMODELSELECTOR];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = [[self.plistSourceArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    NSInteger controllerSelectorTag = [[dic objectForKey:KPLIST_KEYCONTROLLERSELECTOR] integerValue];
    
    switch (controllerSelectorTag) {
        case KPLIST_VALUE_CONTROLLERSELECTOR_REPO:
            [self.navigationController pushViewController:self.reposityController animated:YES];
            break;
        case KPLIST_VALUE_CONTROLLERSELECTOR_GIT:
            [self.navigationController pushViewController:self.gitsController animated:YES];
            break;
        case KPLIST_VALUE_CONTROLLERSELECTOR_EVENT:
        case KPLIST_VALUE_CONTROLLERSELECTOR_NOTIF:
        {
            XDActivityViewController *activityController = [[XDActivityViewController alloc] initWithUserName:self.accountModel.accountName];
            [self.navigationController pushViewController:activityController animated:YES];
        }
            break;
        case KPLIST_VALUE_CONTROLLERSELECTOR_FOLLOWER:
        case KPLIST_VALUE_CONTROLLERSELECTOR_FOLLOEIMG:
        {
            BOOL follower = controllerSelectorTag == KPLIST_VALUE_CONTROLLERSELECTOR_FOLLOWER ? YES : NO;
            XDFollowViewController *followController = [[XDFollowViewController alloc] initWithUserName:self.accountModel.accountName isFollowers:follower];
            followController.title = [dic objectForKey:KPLIST_KEYTITLE];
            [self.navigationController pushViewController:followController animated:YES];
        }
            break;
            
        default:
            break;
    }
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
    __block __weak XDAccountCardViewController *weakSelf = self;
    AFHTTPRequestOperation *operation = nil;
    if (_isOwn) {
        operation = [[[XDRequestManager defaultManager] activityGitEngine] userWithSuccess:^(id object, BOOL haveNextPage) {
            weakSelf.accountModel = [[AccountModel alloc] initWithDictionary:object];
            
            [weakSelf tableViewDidFinishHeaderRefresh];
        } failure:^(NSError *error) {
            [weakSelf tableViewDidFailHeaderRefresh];
        }];
    }
    else{
        operation = [[[XDRequestManager defaultManager] activityGitEngine] user:_accountModel.accountName success:^(id object, BOOL haveNextPage) {
            weakSelf.accountModel = [[AccountModel alloc] initWithDictionary:object];
            
            [weakSelf tableViewDidFinishHeaderRefresh];
        } failure:^(NSError *error) {
            [weakSelf tableViewDidFailHeaderRefresh];
        }];
    }
    
    [self showLoadingViewWithRequestOperation:operation];
}

@end
